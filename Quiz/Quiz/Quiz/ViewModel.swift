//
//  File.swift
//  Quiz
//
//  Created by macbook on 17.03.2021.
//

import SwiftUI

class ViewModel: ObservableObject {
    @Published private var model: ModelQuiz = startGame()
    
    static func startGame() -> ModelQuiz {
        Game.shared.gameSession = GameSession()
        return ModelQuiz()
    }
    
    var questions: Array<ModelQuiz.Question> {
        model.questions
    }
    
    func newQuestion() -> ModelQuiz.Question? {
        let currentQ = (Game.shared.gameSession?.countQuestion)!
        if currentQ >= model.questions.count {
            return nil
        }
        return model.questions[currentQ]
    }
    
    func resetGame() {
        model = ViewModel.startGame()
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
        
        Game.shared.gameSession?.countQuestion += 1
        self.objectWillChange.send()
    }
}
