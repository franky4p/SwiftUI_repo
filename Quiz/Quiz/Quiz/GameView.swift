//
//  GameView.swift
//  Quiz
//
//  Created by macbook on 21.03.2021.
//

import SwiftUI

struct GameView: View {
    @EnvironmentObject var viewModel: ViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        let question = viewModel.newQuestion()
        NavigationView {
            VStack {
                Text("\(viewModel.currentResult())")
                Divider()
                Text("\(question?.textQuestion ?? "Игра окончена")").font(.largeTitle)
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
