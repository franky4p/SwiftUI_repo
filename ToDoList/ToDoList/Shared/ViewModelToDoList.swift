//
//  ViewModelToDoList.swift
//  ToDoList
//
//  Created by macbook on 31.03.2021.
//

import Foundation

class ViewModel: ObservableObject {
    @Published private var model: ListToDo = createToDoList()
    
    static private let caretakerTask = RecordsTask()
    
    static func createToDoList() -> ListToDo {
        var tasks = caretakerTask.loadRecords()
        if tasks.count == 0 {
            let task2 = Composite(id: 0, title: "Тренажерный зал", description: "Подкачаться")
            let task1 = Composite(id: 0, title: "Занятие спортом", description: "Все знают, что спорт необходим")
            task1.tasks = [task2]
            tasks = [task1]
        }
        
        return ListToDo(toDo: tasks)
    }
    
    var tasksList: Array<Composite> {
        model.toDo
    }
    
    func getTask(_ categori: Composite) -> Array<TaskProtocol> {
        categori.tasks
    }
    
    func thisIsCategory(_ task: TaskProtocol) -> Bool {
        if task is Task {
            return false
        } else {
            return true
        }
    }
    
    func addTask(task: TaskProtocol?, title: String, description: String , itIsTask: Bool) {
        if itIsTask, task != nil {
            model.addTask(task: task, title: title, description: description)
        } else {
            model.addComposite(task: task, title: title, description: description)
        }
        
        ViewModel.caretakerTask.saveRecords(model.toDo)
    }
}
