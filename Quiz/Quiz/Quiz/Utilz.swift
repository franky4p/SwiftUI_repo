//
//  Utilz.swift
//  Quiz
//
//  Created by macbook on 21.03.2021.
//

import Foundation

extension NumberFormatter {
    static var int: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        return formatter
    }
}
