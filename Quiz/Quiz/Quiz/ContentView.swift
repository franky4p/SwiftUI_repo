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
                NavigationLink(destination: GameView().environmentObject(viewModel)) {
                    Text("Играть").font(.largeTitle)
                }
                NavigationLink(destination: ResultView().environmentObject(viewModel)) {
                    Text("Результаты").font(.largeTitle)
                }
            }
        }
    }
}


struct GameView: View {
    @EnvironmentObject var viewModel: ViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        let question = viewModel.newQuestion()
        NavigationView {
            VStack {
                Text("\(question?.textQuestion ?? "Игра окончена")")
                Spacer()
                Divider()
                Group {
                    if question == nil {
                        Button(action: { self.presentationMode.wrappedValue.dismiss()
                            viewModel.resetGame()
                        }, label: {
                            Text("Закончить игру")
                        })
                    } else {
                        AnswersView(question: question).environmentObject(viewModel)
                    }
                }
            }
        }.navigationBarHidden(true)
    }
}


struct AnswersView: View {
    @EnvironmentObject var viewModel: ViewModel
    var question: ModelQuiz.Question?
    
    var  body: some View {
        VStack {
            ForEach(viewModel.Answers(question).sorted(by: <), id: \.key) {key, value in
                Button(action: { withAnimation(.easeInOut(duration: 1))
                            { viewModel.checkAnswer(key) } }, label: {
                                Text("\(key) : \(value)").font(.largeTitle)
                            })
            }.padding(2)
            Divider()
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
