//
//  TaskCell.swift
//  AppTodoList
//
//  Created by Glauber Gustavo on 18/12/22.
//

import UIKit

class TaskCell: UITableViewCell {

    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblHour: UILabel!
    @IBOutlet weak var lblTaskTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    public func setTitle(title:String) {
        self.lblTaskTitle.text = title
    }
    
    public func setDate(date:String) {
        self.lblDate.text = date
    }
    
    public func setHour(hour:String) {
        self.lblHour.text = hour
    }

}
