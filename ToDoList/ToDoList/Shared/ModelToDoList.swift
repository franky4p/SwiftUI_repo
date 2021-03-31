//
//  ModelToDoList.swift
//  ToDoList
//
//  Created by macbook on 31.03.2021.
//

import Foundation

protocol TaskProtocol: Codable {
    var id: Int { get }
    var title: String { get }
    var description: String { get }
}


struct Composite: TaskProtocol, Identifiable {
    var id: Int
    var title: String
    var description: String
    var tasks: [TaskProtocol] = []
    
    struct Task: TaskProtocol, Identifiable {
        var id: Int
        var title: String
        var description: String
    }
}

//возможно это излищняя сущность и можно просто использовать Composite в качестве
//корневого элемента, но пока оставлю так для создания минимум одной папки по умолчанию
struct ListToDo {
    var toDo: [Composite] = []
    
    mutating func addComposite(task: TaskProtocol?, title: String, description: String) {
        if task == nil {
            toDo.append(Composite(id: toDo.count, title: title, description: description))
        } else {
            if let chosenIndex: Int = toDo.firstIndex(matching: task as! Composite) {
                toDo[chosenIndex].tasks.append(Composite(id: toDo[chosenIndex].tasks.count, title: title, description: description))
            }
        }
    }
    
    mutating func addTask(task: TaskProtocol?, title: String, description: String) {
        if task != nil {
            if let chosenIndex: Int = toDo.firstIndex(matching: task as! Composite) {
                toDo[chosenIndex].tasks.append(Composite.Task(id: toDo[chosenIndex].tasks.count, title: title, description: description))
            }
        }
    }
}

