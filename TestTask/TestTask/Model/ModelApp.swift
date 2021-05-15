//
//  ModelApp.swift
//  TestTask
//
//  Created by macbook on 14.05.2021.
//

import Foundation

struct ModelApp {
    private(set) var exchageRates: Array<ExchangeRate>
    
    mutating func updateRates(_ rates: Array<ExchangeRate>) {
        exchageRates = rates
    }
}
