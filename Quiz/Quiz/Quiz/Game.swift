//
//  Game.swift
//  Quiz
//
//  Created by macbook on 17.03.2021.
//

import Foundation


final class Game {
    
    static let shared = Game()
    var gameSession: GameSession?
    var resultGame: Array<String>?
    
    private init() {}
}


class GameSession {
    var countQuestion: Int
    
    init() {
        countQuestion = 0
    }
}
