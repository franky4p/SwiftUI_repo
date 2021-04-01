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


//struct Composite: TaskProtocol, Identifiable {
//    var id: Int
//    var title: String
//    var description: String
//    var tasks: [TaskProtocol] = []
//
//    struct Task: TaskProtocol, Identifiable {
//        var id: Int
//        var title: String
//        var description: String
//    }
//}


class Composite: TaskProtocol, Identifiable {
    var id: Int
    var title: String
    var description: String
    var tasks: [TaskProtocol] = []
    
    enum CodingKeys: String, CodingKey {
        case title
        case id
        case description
        case tasks
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(id, forKey: .id)
        try container.encode(description, forKey: .description)
        
        //не знаю как сделать encode для массива TaskProtocol
        //var additionalInfo = container.nestedContainer(keyedBy: CodingKeys.self, forKey: .tasks)
        //try additionalInfo.encode(tasks, forKey: .title)
        
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        id = try container.decode(Int.self, forKey: .id)
        description = try container.decode(String.self, forKey: .description)
    }
    
    init(id: Int, title: String, description: String) {
        self.id = id
        self.title = title
        self.description = description
    }
}


class Task: TaskProtocol, Identifiable {
    var id: Int
    var title: String
    var description: String
    
    init(id: Int, title: String, description: String) {
        self.id = id
        self.title = title
        self.description = description
    }
}

//для работы механизма @Published нужна структура
struct ListToDo {
    var toDo: [Composite] = [] 
    
    mutating func addComposite(task: TaskProtocol?, title: String, description: String) {
        if task == nil {
            toDo.append(Composite(id: toDo.count, title: title, description: description))
        } else {
            (task as! Composite).tasks.append(Composite(id: (task as! Composite).tasks.count, title: title, description: description))
        }
    }
    
    mutating func addTask(task: TaskProtocol?, title: String, description: String) {
        if task != nil {
            (task as! Composite).tasks.append(Task(id: (task as! Composite).tasks.count, title: title, description: description))
        }
    }
}

