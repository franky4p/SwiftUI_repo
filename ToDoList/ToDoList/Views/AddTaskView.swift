//
//  AddTaskView.swift
//  ToDoList
//
//  Created by macbook on 31.03.2021.
//

import SwiftUI


struct AddTaskView: View {
    @EnvironmentObject var viewModel: ViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var title = ""
    @State private var description: String = ""
    @State private var itIsTask = false
    
    var task: TaskProtocol?
    
    var body: some View {
        VStack{
            Text("Название")
            TextField("Задача", text: $title)
            if task != nil {
                Toggle(isOn: $itIsTask){
                    if itIsTask {
                        Text("Это задача")
                    } else {
                        Text("Это категория") }
                }.padding()
            }
            Text("Описание")
            TextEditor(text: $description)
                .foregroundColor(Color.gray)
                .disableAutocorrection(true)
                .border(Color.blue, width: 3)
            Divider()
            Spacer()
            Button(action: { withAnimation(.easeInOut(duration: 1))
            { viewModel.addTask(task: task, title: title, description: description, itIsTask: itIsTask)
                self.presentationMode.wrappedValue.dismiss()
            }
            },
            label: {
                Text("Добавить задачу").font(.largeTitle)
            })
        }
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .padding([.horizontal])
    }
}
