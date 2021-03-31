//
//  ModelQuiz.swift
//  Quiz
//
//  Created by macbook on 17.03.2021.
//

import Foundation


struct ModelQuiz {
    private(set) var questions: Array<Question>
    
    init(questions: [Question]) {
        self.questions = questions
        //questions.shuffle()
    }
    
    mutating func shuffleQuestion(_ on:Bool) {
        if on == true {
            questions.shuffle()
        }
    }
    
    mutating func addQuestion(textQuestion: String, correctAnswer: Int, variantAnswer: [Int:String]) {
        let question = Question(id: questions.count, textQuestion: textQuestion, correctAnswer: correctAnswer,
                                variantAnswer: variantAnswer)
        
        questions.append(question)
    }
    
    struct Question: Identifiable, Codable  {
        let id: Int
        let textQuestion: String
        let correctAnswer: Int
        var variantAnswer: [Int:String]
    }
    
}

struct RezultGame: Identifiable, Codable {
    let id: Int
    let date: Date
    let rezult: String
    
    init() {
        id = 0
        date = Date()
        rezult = "Здесь будет ваш результат"
    }
    
    init(id: Int, date: Date, rezult: String) {
        self.id = id
        self.date = date
        self.rezult = rezult
    }
}
