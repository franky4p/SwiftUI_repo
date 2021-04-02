//
//  ToDoListApp.swift
//  Shared
//
//  Created by macbook on 31.03.2021.
//

import SwiftUI

@main
struct ToDoListApp: App {
    var body: some Scene {
        WindowGroup {
            let app = ViewModel()
            ContentView(viewModel: app)
        }
    }
}
