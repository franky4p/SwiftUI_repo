//
//  AnswerData.swift
//  TestTask
//
//  Created by macbook on 14.05.2021.
//

import Foundation


struct Response<T: Decodable> : Decodable {
    private enum CodingKeys : String, CodingKey {
        case items = "rates"
        case rid = "rid"
        case code = "code"
        case downloadDate = "downloadDate"
        case message = "message"
        case messageTitle = "messageTitle"
        case productState = "productState"
    }
    let code: Int
    let downloadDate: String
    let message: String
    let messageTitle: String
    let rid: String
    let productState: Int
    let items : [T]
}
