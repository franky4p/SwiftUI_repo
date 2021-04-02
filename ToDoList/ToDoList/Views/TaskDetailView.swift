//
//  TaskDetailView.swift
//  ToDoList
//
//  Created by macbook on 01.04.2021.
//

import SwiftUI

struct TaskDetailView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var task: TaskProtocol
    
    var body: some View {
        VStack {
            Text("\(task.title)").font(.largeTitle)
            Spacer()
            Text("\(task.description)")
            Spacer()
            Button("Закрыть") { self.presentationMode.wrappedValue.dismiss() }
        }
    }
}



