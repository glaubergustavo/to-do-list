//
//  TimePickerViewController.swift
//  AppTodoList
//
//  Created by Glauber Gustavo on 18/12/22.
//

import UIKit

protocol TimePickerProtocol {
    func timeHour(time: String)
}
class TimePickerViewController: UIViewController {

    @IBOutlet weak var timePicker: UIDatePicker!
    
    public var delegate: TimePickerProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func confirmTime(_ sender: Any) {
        self.dismiss(animated: true) {
            guard let delegate = self.delegate else { return }
            let datePickerSelect = self.timePicker.date
            let timeString = Date().convertDateToString(date: datePickerSelect, dateFormatter: "HH:mm")
            delegate.timeHour(time: timeString)
        }
    }
    
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
