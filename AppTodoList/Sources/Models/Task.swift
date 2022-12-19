//
//  Task.swift
//  AppTodoList
//
//  Created by Glauber Gustavo on 18/12/22.
//

import Foundation

class Task: Codable {
    var id: Int
    var title: String
    var time: String
    var date: String
    
    init(id:Int, title:String, time:String, data:String) {
        self.id = id
        self.title = title
        self.time = time
        self.date = data
    }
    
}
