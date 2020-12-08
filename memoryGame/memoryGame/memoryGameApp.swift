//
//  memoryGameApp.swift
//  memoryGame
//
//  Created by macbook on 29.11.2020.
//

import SwiftUI

@main
struct memoryGameApp: App {
    var body: some Scene {
        WindowGroup {
            let game = EmojiGame()
            ContentView(viewModel: game)
        }
    }
}
