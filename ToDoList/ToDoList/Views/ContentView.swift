//
//  ContentView.swift
//  Shared
//
//  Created by macbook on 31.03.2021.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ViewModel
    @State private var addTask: Bool = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.tasksList) { value in
                    NavigationLink (
                        destination: TaskView(task: value).environmentObject(viewModel)){
                        Text("\(value.title)")
                            .padding()
                    }
                }
            }
            .navigationBarItems(trailing: Button(action: { addTask.toggle() }) {
                                    Text("➕")
                                        .sheet(isPresented: $addTask) {
                                            AddTaskView().environmentObject(viewModel)
                                        }
                                        .font(.largeTitle) } )
        }
    }
}

    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ViewModel())
    }
}
