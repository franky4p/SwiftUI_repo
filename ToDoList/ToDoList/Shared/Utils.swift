//
//  Utils.swift
//  ToDoList
//
//  Created by macbook on 31.03.2021.
//

import Foundation


extension Array where Element: Identifiable {
    func firstIndex(matching: Element) -> Int? {
        for index in 0..<self.count {
            if self[index].id == matching.id {
                return index
            }
        }
        return nil
    }
}

//TODO доделать кодирование для поля tasks
extension Composite: Codable {
    enum CodingKeys: String, CodingKey {
        case title
        case id
        case description
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(id, forKey: .id)
        try container.encode(description, forKey: .description)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        id = try container.decode(Int.self, forKey: .id)
        description = try container.decode(String.self, forKey: .description)
    }
}
