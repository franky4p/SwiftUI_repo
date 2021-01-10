//
//  ModelTheFish.swift
//  TheseFish
//
//  Created by macbook on 07.01.2021.
//

import Foundation

struct ModelTheseFish {
    var categories: Array<Categories>
    
    init() {
        categories = [Categories]()
    }
    
    mutating func addCategories(_ data: [Categories]) {
        self.categories = data
    }
    
}



struct Root<T: Decodable> : Decodable {
    private enum CodingKeys : String, CodingKey { case query = "query" }
    let query : Query<T>
}

struct Query<T: Decodable> : Decodable {
    private enum CodingKeys : String, CodingKey {
        case items = "categorymembers"
    }
    let items : [T]
}

struct Categories: Decodable, Identifiable {
    private enum CodingKeys : String, CodingKey {
        case ns = "ns"
        case id = "pageid"
        case title = "title"
    }
    let id: Int
    let ns : Int
    let title: String
    
    var category: String? {
        get {
            var name = self.title
            let firstСolon = name.firstIndex(of: ":") ?? name.endIndex
            name.removeSubrange(...firstСolon)
            return name
        }
    }
}
