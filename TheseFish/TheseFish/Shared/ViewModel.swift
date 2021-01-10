//
//  ViewModel.swift
//  TheseFish
//
//  Created by macbook on 07.01.2021.
//

import SwiftUI

class ViewModel: ObservableObject {
    @Published private var model: ModelTheseFish = fishСategories()
    
    static func fishСategories() -> ModelTheseFish {
        return ModelTheseFish()
    }
    
    var categories: Array<Categories> {
        model.categories
    }
    
    func searchFish(_ searchText: String) {
        print(" You looking \(searchText)")
    }
    
    func addCategories() {
        let request = RequestWiki.requestRegionFish()
        Session.shared.requestToAPI(url: request, typeReceiver: Root<Categories>.self){ results in
            switch results {
            case .success(let response):
                var data: [Categories] = [Categories]()
                response.query.items.forEach {
                    data.append($0)
                }
                self.model.addCategories(data)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
