//
//  TaskView.swift
//  ToDoList
//
//  Created by macbook on 31.03.2021.
//

import SwiftUI

struct TaskView: View {
    @EnvironmentObject var viewModel: ViewModel
    @State private var addTask: Bool = false
    @State private var selectedTask: Task? = nil
    
    var task: TaskProtocol
    
    var body: some View {
        List {
            ForEach(viewModel.getTask(task as! Composite) , id: \.id) { value in
                if viewModel.thisIsCategory(value) {
                    NavigationLink (destination: TaskView(task: value).environmentObject(viewModel)){
                        Text("\(value.title)").padding()
                    }
                } else {
                    Text("\(value.title)").onTapGesture {
                        self.selectedTask = value as? Task
                    }.padding()
                }
            }
        }.navigationBarItems(trailing: Button(action: { addTask.toggle() }) {
                                Text("➕")
                                    .sheet(isPresented: $addTask) {
                                        AddTaskView(task: task).environmentObject(viewModel)
                                    }
                                    .font(.largeTitle) } )
        .sheet(item: self.$selectedTask) { value in
            TaskDetailView(task: value) }
    }
}

