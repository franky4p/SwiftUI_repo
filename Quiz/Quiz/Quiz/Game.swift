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
    var shuffleQuestion: Bool = false
    
    private(set) var resultGame: Array<RezultGame> {
        didSet {
            caretaker.saveRecords(resultGame)
        }
    }
    
    private let caretaker = RecordsQuize()
    
    private init() {
        resultGame = caretaker.loadResults()
    }
    
    func addRecord(_ record: RezultGame) {
        resultGame.append(record)
    }
}


class GameSession {
    var countQuestion: Int
    var lastQuestion: Int = 0
    
    init() {
        countQuestion = 0
    }
}
