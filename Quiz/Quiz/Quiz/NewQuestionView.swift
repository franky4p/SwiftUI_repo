//
//  NewQuestionView.swift
//  Quiz
//
//  Created by macbook on 21.03.2021.
//

import SwiftUI

struct NewQuestionView: View {
    @EnvironmentObject var viewModel: ViewModel
    @State private var question = ""
    @State private var rightAnswer: Int = 0
    @State private var answersText: String = ""
    
    var body: some View {
        VStack{
            Text("Вопрос")
            TextField("Введите текс вопроса", text: $question)
            //странная работа форматера или текст филда, если не нажать энтер в поле, то не работает
            //возможно так работает только в симуляторе
            Text("Правильный ответ")
            TextField("Номер правильного ответа", value: $rightAnswer, formatter: NumberFormatter.int)
            Text("Введите варианты ответов, каждый с новой строки")
            TextEditor(text: $answersText)
                .foregroundColor(.blue)
                .disableAutocorrection(true)
            Divider()
            Spacer()
            //TODO добавить оповещение о добавлении вопроса
            Button(action: { withAnimation(.easeInOut(duration: 1))
                { viewModel.addQuestion(textQuestion: question, correctAnswer: rightAnswer, variantAnswer: answersText )
                answersText = ""
                question = ""
            }
            },
            label: {
                Text("Добавить вопрос").font(.largeTitle)
            })
        }
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .padding([.horizontal])
    }
}
