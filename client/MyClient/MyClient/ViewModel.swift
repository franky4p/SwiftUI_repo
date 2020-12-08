//
//  ViewModel.swift
//  MyClient
//
//  Created by macbook on 08.12.2020.
//

import SwiftUI

class ViewModel: ObservableObject{
//    @Published private var model: ModelApp
    
    static func connect(login: String, password: String) {
        print("Hello \(login) your pas \(password)")
    }
    
}
