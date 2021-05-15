//
//  ModelView.swift
//  TestTask
//
//  Created by macbook on 14.05.2021.
//

import Foundation

class ModelView: ObservableObject {
    @Published private var model: ModelApp = startApp()
    @Published var dataUpdate: Bool = false
    
    static func startApp() -> ModelApp {
        let model = ModelApp(exchageRates: [])
        return model
    }
    
    var rezult: Array<ExchangeRate> {
        model.exchageRates
    }
    
    func updateRatesFromServer() {
        updateFromServer(self)
    }
    
    func updateRates(_ data: Array<ExchangeRate>) {
        DispatchQueue.main.async {
            self.model.updateRates(data)
            self.dataUpdate = true
        }
    }
}
