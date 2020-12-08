//
//  EmojiGame.swift
//  memoryGame
//
//  Created by macbook on 29.11.2020.
//

import SwiftUI

class EmojiGame: ObservableObject {
    @Published private var model: Memorize<String> = createGame()
    
    static func createGame() -> Memorize<String> {
        let emojis: Array<String> = ["🦁", "🐸", "🪲", "🐛", "🦆", "🐢", "🐊"]
        return Memorize<String>(numberOfPairsCard: emojis.count) { pairIndex in
            return emojis[pairIndex]
            
        }
    }
    
    var cards: Array<Memorize<String>.Card> {
        model.cards
    }
    
    func choose(card: Memorize<String>.Card) {
        model.choose(card)
    }
    
    func resetGame() {
        model = EmojiGame.createGame()
    }
}
