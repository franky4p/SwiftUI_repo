//
//  TheseFishApp.swift
//  TheseFish
//
//  Created by macbook on 07.01.2021.
//

import SwiftUI

@main
struct TheseFishApp: App {
    var body: some Scene {
        WindowGroup {
            let app = ViewModel()
            ContentView(viewModel: app)
        }
    }
}
