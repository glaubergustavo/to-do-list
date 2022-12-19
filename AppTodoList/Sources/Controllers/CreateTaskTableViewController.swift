//
//  CreateTaskTableViewController.swift
//  AppTodoList
//
//  Created by Glauber Gustavo on 18/12/22.
//

import UIKit
import FSCalendar

class CreateTaskTableViewController: UITableViewController {

    //MARK: - @IBOutlet
    @IBOutlet weak var txtTaskTitle: UITextField!
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var btnTime: UIButton!
    @IBOutlet weak var btnRemove: UIButton!
    
    //MARK: - var/let
    private var time: String = ""
    private var data: String = ""
    public var task: Task?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configUI()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? TimePickerViewController {
            controller.delegate = self
        }
    }
    
    //MARK: - Custom Methods
    
    private func configUI() {
        self.btnRemove.isHidden = self.task == nil
        guard let taskAux = self.task else { return }
        self.btnTime.setTitle(taskAux.time, for: .normal)
        self.txtTaskTitle.text = taskAux.title
        self.data = taskAux.date
        self.time = taskAux.time

    }
    //MARK: - @IBActions
    
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func showTimePicker(_ sender: Any) {
        self.performSegue(withIdentifier: "timePickerSegue", sender: nil)
    }
    
    @IBAction func cancelTask(_ sender: Any) {
        TaskDefaultHelper().deleteTask(task: self.task!)
        self.dismiss(sender)
    }
    
    @IBAction func saveTask(_ sender: Any) {
        if self.task != nil {
            self.task!.date = self.data
            self.task!.time = self.time
            self.task!.title = self.txtTaskTitle.text!
            
            TaskDefaultHelper().updateTask(task: self.task!)
        }else {
            var list:[Task] = TaskDefaultHelper().getTaskList()
            let id = TaskDefaultHelper().getNextId()
            let newtask:Task = Task(id: id, title: self.txtTaskTitle.text ?? "Sem Título", time: self.time, data: self.data)
            list.append(newtask)
            
            TaskDefaultHelper().saveTaskList(list: list)
        }
        self.dismiss(sender)
    }
    
}

extension CreateTaskTableViewController: FSCalendarDelegate, FSCalendarDelegateAppearance {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        self.data = Date().convertDateToString(date: date, dateFormatter: "dd/MM/yyyy")
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
        let dateStr = Date().convertDateToString(date: date, dateFormatter: "dd/MM/yyyy")
        if self.task != nil {
            if self.data == dateStr {
                return .green
            }
        }
        return nil
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        let dateStr = Date().convertDateToString(date: date, dateFormatter: "dd/MM/yyyy")
        if self.task != nil {
            if self.data == dateStr {
                return .black
            }
        }
        return nil
    }
}

extension CreateTaskTableViewController: TimePickerProtocol {
    func timeHour(time: String) {
        self.btnTime.setTitle(time, for: .normal)
        self.time = time
    }    
}

extension CreateTaskTableViewController {
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
}
