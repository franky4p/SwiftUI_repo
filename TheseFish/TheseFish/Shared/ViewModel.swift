//
//  ViewModel.swift
//  TheseFish
//
//  Created by macbook on 07.01.2021.
//

import SwiftUI

class ViewModel: ObservableObject {
    @Published private var model: ModelTheseFish = fishHunting()
    
    static func fishHunting() -> ModelTheseFish {
        return ModelTheseFish()
    }
    
    func searchFish(_ searchText: String) {
        print(" You looking \(searchText)")
    }
    
}
