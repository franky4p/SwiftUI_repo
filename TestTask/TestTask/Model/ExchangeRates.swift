//
//  ExchangeRates.swift
//  TestTask
//
//  Created by macbook on 14.05.2021.
//

import Foundation

struct ExchangeRate: Decodable, Identifiable {
    
    static func primaryKey() -> String? {
        return "currMnemTo"
    }
    
    private enum CodingKeys : String, CodingKey {
        case id = "currMnemTo"
        case buy = "buy"
        case currMnemFrom = "currMnemFrom"
        case from = "from"
        case deltaBuy = "deltaBuy"
        case deltaSale = "deltaSale"
        case name = "name"
        case sale = "sale"
        case to = "to"
        case tp = "tp"
    }
    
    var id: String
    var buy: String
    var currMnemFrom: String
    var deltaBuy: String
    var deltaSale: String
    var from: Int
    var name: String
    var sale: String
    var to: Int
    var tp: Int
}
