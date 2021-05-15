//
//  TestTaskApp.swift
//  TestTask
//
//  Created by macbook on 14.05.2021.
//

import SwiftUI

@main
struct TestTaskApp: App {
    var body: some Scene {
        WindowGroup {
            let app = ModelView()
            ContentView(viewModel: app)
        }
    }
}
