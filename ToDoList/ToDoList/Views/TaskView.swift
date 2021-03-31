//
//  TaskView.swift
//  ToDoList
//
//  Created by macbook on 31.03.2021.
//

import SwiftUI

struct TaskView: View {
    @EnvironmentObject var viewModel: ViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var itIsTask: Bool = false
    @State private var addTask: Bool = false
    var task: TaskProtocol
    
    var body: some View {
        Group {
            if viewModel.thisIsCategory(task) {
                List {
                    ForEach(viewModel.getTask(task as! Composite) , id: \.id) { value in
                        if viewModel.thisIsCategory(value) {
                            NavigationLink (destination: TaskView(task: value).environmentObject(viewModel)){
                                Text("\(value.title)").padding()
                            }
                        } else {
                            Text("\(value.title)").onTapGesture {
                                itIsTask.toggle()
                            }.sheet(isPresented: $itIsTask, content: {
                                TaskView(task: value).environmentObject(viewModel)
                            })
                        }
                    }
                }.navigationBarItems(trailing: Button(action: { addTask.toggle() }) {
                                        Text("➕")
                                            .sheet(isPresented: $addTask) {
                                                AddTaskView(task: task).environmentObject(viewModel)
                                            }
                                            .font(.largeTitle) } )
            } else {
                VStack {
                    Text("\(task.title)").font(.largeTitle)
                    Spacer()
                    Text("\(task.description)")
                    Spacer()
                    Button("Закрыть") { self.presentationMode.wrappedValue.dismiss() }
                }
            }
        }
    }
}
