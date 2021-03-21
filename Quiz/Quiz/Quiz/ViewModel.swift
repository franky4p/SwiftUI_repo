//
//  File.swift
//  Quiz
//
//  Created by macbook on 17.03.2021.
//

import SwiftUI

class ViewModel: ObservableObject {
    //так то хотел хранить состояние игры в модели типа структуры, но по условию нужны классы
    @Published private var model: ModelQuiz = startGame()
    
    static func startGame() -> ModelQuiz {
        Game.shared.gameSession = GameSession()
        return ModelQuiz()
    }
    
    var questions: Array<ModelQuiz.Question> {
        model.questions
    }
    
    var rezult: Array<RezultGame> {
        Game.shared.resultGame
    }
    
    func newQuestion() -> ModelQuiz.Question? {
        let currentQ = (Game.shared.gameSession?.countQuestion)!
        if currentQ >= model.questions.count {
            return nil
        }
        
        return model.questions[currentQ]
    }
    
    func resetGame() {
        safeRezultGame()
        model = ViewModel.startGame()
    }
    
    func safeRezultGame() {
        let rezult = RezultGame(id: Game.shared.resultGame.count, date: Date(),
                                rezult: "\(Game.shared.lastQuestion) из \(model.questions.count)")
        
        Game.shared.addRecord(rezult)
    }
    
    func Answers(_ question: ModelQuiz.Question?) -> [Int:String] {
        if question == nil {
            return [0: "Начать новую игру"]
        }
        return question!.variantAnswer
    }
    
    func checkAnswer(_ idAnswer: Int) {
        //если что-то пошло не так
        if idAnswer == 0 {
            resetGame()
        }
        let currentQ = (Game.shared.gameSession?.countQuestion)!
        if model.questions[currentQ].correctAnswer == idAnswer {
            Game.shared.gameSession?.countQuestion += 1
            Game.shared.lastQuestion = currentQ + 1
        } else {
            //незамысловатый способ завершить игру
            Game.shared.gameSession?.countQuestion = model.questions.count + 1
        }
        self.objectWillChange.send()
    }
    
}
