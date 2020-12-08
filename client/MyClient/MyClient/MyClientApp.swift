//
//  MyClientApp.swift
//  MyClient
//
//  Created by macbook on 08.12.2020.
//

import SwiftUI

@main
struct MyClientApp: App {
    var body: some Scene {
        WindowGroup {
            let app = ViewModel()
            ContentView(viewModel: app)
        }
    }
}
