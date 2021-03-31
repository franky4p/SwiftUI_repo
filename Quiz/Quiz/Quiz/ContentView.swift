//
//  ContentView.swift
//  Quiz
//
//  Created by macbook on 17.03.2021.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                NavigationLink(destination: GameView().environmentObject(viewModel)) {
                    Text("Играть").font(.largeTitle)
                }
                NavigationLink(destination: ResultView().environmentObject(viewModel)) {
                    Text("Результаты").font(.largeTitle)
                }
                Spacer()
                Divider()
                HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 30) {
                    NavigationLink(destination: SettingsView().environmentObject(viewModel)) {
                        Text("Настройки")
                    }
                    NavigationLink(destination: NewQuestionView().environmentObject(viewModel)) {
                        Text("Добавить вопрос")
                    }
                }
            }
        }
    }
}


struct ResultView: View {
    @EnvironmentObject var viewModel: ViewModel
    var body: some View {
        Text("Результаты проведенных игр").font(.headline)
        List{
            ForEach(viewModel.rezult) { value in
                Text("\(value.id) : \(value.date) -> \(value.rezult)")
            }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ViewModel())
    }
}
