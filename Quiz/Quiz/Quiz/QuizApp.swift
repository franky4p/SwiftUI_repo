//
//  QuizApp.swift
//  Quiz
//
//  Created by macbook on 17.03.2021.
//

import SwiftUI

@main
struct QuizApp: App {
    var body: some Scene {
        WindowGroup {
            let app = ViewModel()
            ContentView(viewModel: app)
        }
    }
}
