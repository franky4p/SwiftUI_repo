//
//  ContentView.swift
//  TestTask
//
//  Created by macbook on 14.05.2021.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ModelView
    
    var body: some View {
        Group{
            if viewModel.dataUpdate {
                List {
                    ForEach(viewModel.rezult) { value in
                        VStack {
                            Text("\(value.name)").font(.largeTitle)
                            Text("(\(value.id) -> \(value.currMnemFrom))")
                            Text("from: \(value.from), to: \(value.to), tp: \(value.tp)")
                            Text("buy: \(value.buy), deltaBuy: \(value.deltaBuy)")
                            Text("sale: \(value.sale), deltaSale: \(value.deltaSale)")
                        }
                    }
                }
            } else {
                Text("Подождите, данные обновляются")
            }
        }.onAppear { self.viewModel.updateRatesFromServer() }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ModelView())
    }
}
