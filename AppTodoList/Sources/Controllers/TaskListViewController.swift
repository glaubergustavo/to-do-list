//
//  TaskListViewController.swift
//  AppTodoList
//
//  Created by Glauber Gustavo on 18/12/22.
//

import UIKit

class TaskListViewController: UIViewController {

    //MARK: @IBOutlet
    @IBOutlet weak var tbTaskList: UITableView!
    
    //MARK: var/let
    private var list:[Task] = []
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.loadItens()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? CreateTaskTableViewController {
            guard let task = sender as? Task else { return }
            controller.task = task
        }
    }
    //MARK: Custom Methods
    private func configUI() {
        tableViewConfig()
        
    }
    
    private func loadItens() {
        self.list = TaskDefaultHelper().getTaskList()
        self.tbTaskList.reloadData()
    }
    
    private func tableViewConfig() {
        
        self.tbTaskList.delegate = self
        self.tbTaskList.dataSource = self
        
        self.tbTaskList.register(UINib(nibName: "EmptyCell", bundle: nil), forCellReuseIdentifier: "EmptyCell")
    }
    
    private func callCreateTask(task: Task?) {
        self.performSegue(withIdentifier: "createTaskSegue", sender: task)
    }
    
    //MARK: Actions
    @IBAction func addTask(_ sender: Any) {
        self.callCreateTask(task: sender as? Task)
    }
}

extension TaskListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count > 0 ? self.list.count : 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.list.count > 0 ? 121 : 151
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.list.count > 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TaskCell
            let task: Task = self.list[indexPath.row]
            cell.setTitle(title: task.title)
            cell.setDate(date: task.date)
            cell.setHour(hour: task.time)
            
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "EmptyCell", for: indexPath) as! EmptyCell
            cell.selectionStyle = .none
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.list.count > 0 {
            self.callCreateTask(task: self.list[indexPath.row])
        } else {
            self.callCreateTask(task: nil)
        }
    }
    
}
