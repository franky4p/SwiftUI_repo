//
//  RecordsTask.swift
//  ToDoList
//
//  Created by macbook on 31.03.2021.
//

import Foundation


class RecordsTask {
    
    private typealias Memento = Data
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    private let key = "1_ToDoList_4"
    
    func saveRecords(_ records: [Composite]) {
        do {
            let data: Memento = try encoder.encode(records)
            UserDefaults.standard.setValue(data, forKey: key)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func loadRecords() -> [Composite] {
        guard let data: Memento = UserDefaults.standard.data(forKey: key) else {
            return []
        }
        do {
            return try decoder.decode([Composite].self, from: data)
        } catch {
            print(error.localizedDescription)
        }
        return []
    }
}
