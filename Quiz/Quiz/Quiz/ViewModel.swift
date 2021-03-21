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
    
    static private let caretakerAnswer = RecordsUserAnswers()
    
    var shuffle: Bool = false {
        didSet {
            shuffleQuestion(shuffle)
        }
    }
    
    static func startGame() -> ModelQuiz {
        Game.shared.gameSession = GameSession()
        var answers = caretakerAnswer.loadResults()
        if answers.count == 0 {
           answers = createQuestion()
        }
        
        return ModelQuiz(questions: answers)
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
    
    func currentResult() -> String {
        if model.questions.count == 0 {
            return ""
        }
        let numberQuestion = Game.shared.gameSession?.lastQuestion ?? 0
        let percent = Double(numberQuestion) / Double(model.questions.count) * 100
        return "Вопрос \(numberQuestion) : \(String(format:"%.2f", percent)) %"
    }
    
    func safeRezultGame() {
        let rezult = RezultGame(id: Game.shared.resultGame.count, date: Date(),
                                rezult: "\(Game.shared.gameSession?.lastQuestion ?? 0) из \(model.questions.count)")
        
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
            Game.shared.gameSession?.lastQuestion = currentQ + 1
        } else {
            //незамысловатый способ завершить игру
            Game.shared.gameSession?.countQuestion = model.questions.count + 1
        }
        self.objectWillChange.send()
    }
    
    func shuffleQuestion(_ on: Bool) {
        //не знаю, зачем это в синглтоне при моей архитектуре, но в задании написано сделать
        Game.shared.shuffleQuestion = on
        model.shuffleQuestion(on)
    }
    
    func addQuestion(textQuestion: String, correctAnswer: Int, variantAnswer: String) {
        //из-за странной работы текст филда может не подставиться значение
        if correctAnswer == 0 { print("Некорректный правильный ответ")
            return }
        
        let arrayAnswer = variantAnswer.split(separator: "\n").map(String.init)
        var answers = [Int:String]()
        var numberAnswer = 0
        
        for item in arrayAnswer {
            numberAnswer += 1
            answers[numberAnswer] = item
        }
        
        model.addQuestion(textQuestion: textQuestion, correctAnswer: correctAnswer, variantAnswer: answers)
        ViewModel.caretakerAnswer.saveRecords(model.questions)
    }
    
    static func createQuestion() -> Array<ModelQuiz.Question> {
        var questions = [ModelQuiz.Question]()
        questions.append(ModelQuiz.Question(id: 0, textQuestion: "Как называют жесткий компьютерный диск?", correctAnswer: 1,
                                  variantAnswer: [1:"Винчестер", 2:"Ремингтон", 3:"Кольт", 4:"Беррета"]))
        questions.append(ModelQuiz.Question(id: 1, textQuestion: "Какой объем информации влезает на 3,5 дюймовую дискету?", correctAnswer: 3,
                                  variantAnswer: [1:"3,5 мб", 2:"2 мб", 3:"1,44 мб", 4:"1,25 мб"]))
        questions.append(ModelQuiz.Question(id: 2, textQuestion: "Сколько байт в 1 Мбайте?", correctAnswer: 4,
                                  variantAnswer: [1:"1000", 2:"1024", 3:"8192", 4:"1048576"]))
        questions.append(ModelQuiz.Question(id: 3, textQuestion: "В каком городе находится штаб-квартира Microsoft?", correctAnswer: 1,
                                  variantAnswer: [1:"Редмонд", 2:"Пало Альто", 3:"Купертино", 4:"Лос Гатос"]))
        questions.append(ModelQuiz.Question(id: 4, textQuestion: "Сколько bit имеет SEGA Mega Drive?", correctAnswer: 2,
                                  variantAnswer: [1:"8", 2:"16", 3:"32", 4:"64"]))
        questions.append(ModelQuiz.Question(id: 5, textQuestion: "Когда появился первый компьютер?", correctAnswer: 1,
                                  variantAnswer: [1:"1974", 2:"1958", 3:"1938", 4:"1983"]))
        questions.append(ModelQuiz.Question(id: 6, textQuestion: "Как зовут главного героя компьютерной игры «Легенда Зельды»?", correctAnswer: 1,
                                  variantAnswer: [1:"Линк", 2:"Пинк", 3:"Тинк", 4:"Винк"]))
        questions.append(ModelQuiz.Question(id: 7, textQuestion: "Какая клавиша на компьютерной клавиатуре находится левее буквы “S”?", correctAnswer: 1,
                                  variantAnswer: [1:"A", 2:"Q", 3:"Z", 4:"D"]))
        questions.append(ModelQuiz.Question(id: 8, textQuestion: "Бессмертие в игре DOOM II", correctAnswer: 2,
                                  variantAnswer: [1:"IDQQD", 2:"IDDQD", 3:"IQDQD", 4:"IQDDQ"]))
        questions.append(ModelQuiz.Question(id: 9, textQuestion: "Какая частота используется в беспроводной технологии Wi-Fi?", correctAnswer: 3,
                                  variantAnswer: [1:"2,1 Ггц", 2:"2,3 Ггц", 3:"2,4 Ггц", 4:"2,6 Ггц"]))
        
        return questions
    }
}
