//
//  ContentView.swift
//  FirebaseClient
//
//  Created by macbook on 27.01.2021.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ViewModel
    @State var uzerName: String = ""
    @State var uzerPas: String = ""
    
    var body: some View {
        Group {
            if viewModel.loginSuccessful() {
                MainView(viewModel:viewModel).onAppear{
                    viewModel.saveToFireBase()
                }
            } else {
                VStack{
                    HStack{
                        Text("Логин:")
                            .frame(width: 65.0)
                        TextField("Email пользователя", text: $uzerName)
                            .border(Color.blue, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                    }
                    HStack{
                        Text("Пароль:")
                            .frame(width: 65.0)
                        SecureField("", text: $uzerPas)
                            .border(Color.blue, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                    }
                    Group {
                        if viewModel.errorsFound() != nil {
                            Text("Произошла ошибка: \(viewModel.errorsFound()!)")
                                .foregroundColor(.red)
                        }
                    }
                    HStack{
                        Button(action: { self.viewModel.connect(uzerName: uzerName, uzerPas: uzerPas) },
                               label: { Text("Войти") })
                        Button(action: { self.viewModel.registration(uzerName: uzerName, uzerPas: uzerPas) },
                               label: { Text("Регистрация") })
                    }
                }.padding()
            }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ViewModel())
    }
}
