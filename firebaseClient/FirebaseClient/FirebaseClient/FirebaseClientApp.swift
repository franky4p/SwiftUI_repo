//
//  FirebaseClientApp.swift
//  FirebaseClient
//
//  Created by macbook on 27.01.2021.
//

import SwiftUI

@main
struct FirebaseClientApp: App {
    var body: some Scene {
        WindowGroup {
            let app = ViewModel()
            ContentView(viewModel: app)
        }
    }
}
