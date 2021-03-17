//
//  ModelQuiz.swift
//  Quiz
//
//  Created by macbook on 17.03.2021.
//

import Foundation


struct ModelQuiz {
    var questions: Array<Question>
    
    init() {
        questions = ModelQuiz.createQuestion()
        //questions.shuffle()
    }
    
    static func createQuestion() -> Array<Question> {
        var questions = [Question]()
        questions.append(Question(id: 0, textQuestion: "Как называют жесткий компьютерный диск?", correctAnswer: 1,
                                  variantAnswer: [1:"Винчестер", 2:"Ремингтон", 3:"Кольт", 4:"Беррета"]))
        questions.append(Question(id: 1, textQuestion: "Какой объем информации влезает на 3,5 дюймовую дискету?", correctAnswer: 3,
                                  variantAnswer: [1:"3,5 мб", 2:"2 мб", 3:"1,44 мб", 4:"1,25 мб"]))
        questions.append(Question(id: 2, textQuestion: "Сколько байт в 1 Мбайте?", correctAnswer: 4,
                                  variantAnswer: [1:"1000", 2:"1024", 3:"8192", 4:"1048576"]))
        questions.append(Question(id: 3, textQuestion: "В каком городе находится штаб-квартира Microsoft?", correctAnswer: 2,
                                  variantAnswer: [1:"Редмонд", 2:"Пало Альто", 3:"Купертино", 4:"Лос Гатос"]))
        questions.append(Question(id: 4, textQuestion: "Сколько bit имеет SEGA Mega Drive?", correctAnswer: 2,
                                  variantAnswer: [1:"8", 2:"16", 3:"32", 4:"64"]))
        questions.append(Question(id: 5, textQuestion: "Когда появился первый компьютер?", correctAnswer: 1,
                                  variantAnswer: [1:"1974", 2:"1958", 3:"1938", 4:"1983"]))
        questions.append(Question(id: 6, textQuestion: "Как зовут главного героя компьютерной игры «Легенда Зельды»?", correctAnswer: 1,
                                  variantAnswer: [1:"Линк", 2:"Пинк", 3:"Тинк", 4:"Винк"]))
        questions.append(Question(id: 7, textQuestion: "Какая клавиша на компьютерной клавиатуре находится левее буквы “S”?", correctAnswer: 1,
                                  variantAnswer: [1:"A", 2:"Q", 3:"Z", 4:"D"]))
        questions.append(Question(id: 8, textQuestion: "Бессмертие в игре DOOM II", correctAnswer: 2,
                                  variantAnswer: [1:"IDQQD", 2:"IDDQD", 3:"IQDQD", 4:"IQDDQ"]))
        questions.append(Question(id: 9, textQuestion: "Какая частота используется в беспроводной технологии Wi-Fi?", correctAnswer: 3,
                                  variantAnswer: [1:"2,1 Ггц", 2:"2,3 Ггц", 3:"2,4 Ггц", 4:"2,6 Ггц"]))
        
        return questions
    }
    
    struct Question: Identifiable  {
        var id: Int
        var textQuestion: String
        var correctAnswer: Int
        var variantAnswer: [Int:String]
    }
    
}

