//
//  RecordsQuiz.swift
//  Quiz
//
//  Created by macbook on 20.03.2021.
//

import Foundation

class RecordsQuize {
    
    private typealias Memento = Data
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    private let key = "1234_QuizRecords1"
    
    func saveRecords(_ records: [RezultGame]) {
        do {
            let data: Memento = try encoder.encode(records)
            UserDefaults.standard.setValue(data, forKey: key)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func loadResults() -> [RezultGame] {
        guard let data: Memento = UserDefaults.standard.data(forKey: key) else {
            return []
        }
        do {
            return try decoder.decode([RezultGame].self, from: data)
        } catch {
            print(error.localizedDescription)
        }
        return []
    }
}


class RecordsUserAnswers {
    
    private typealias Memento = Data
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    private let key = "1234_QuizAnswers4"
    
    func saveRecords(_ records: [ModelQuiz.Question]) {
        do {
            let data: Memento = try encoder.encode(records)
            UserDefaults.standard.setValue(data, forKey: key)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func loadResults() -> [ModelQuiz.Question] {
        guard let data: Memento = UserDefaults.standard.data(forKey: key) else {
            return []
        }
        do {
            return try decoder.decode([ModelQuiz.Question].self, from: data)
        } catch {
            print(error.localizedDescription)
        }
        return []
    }
}
