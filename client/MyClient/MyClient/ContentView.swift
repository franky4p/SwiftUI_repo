//
//  ContentView.swift
//  MyClient
//
//  Created by macbook on 08.12.2020.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ViewModel
    @State private var login = ""
    @State private var password = ""
    
    var body: some View {
        VStack(alignment: .center, spacing: 5)  {
            VStack(spacing: 1){
                HStack {
                    Text("Login: ").padding()
                    TextField("Enter your name", text: $login)
                }
                HStack {
                    Text("Password: ")
                    SecureField("Password", text: $password)
                }
            }
            .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button(action: { ViewModel.connect(login: login, password: password) },
                   label: { Text("Connect") })
                .padding()
        }
        .padding(45)
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ViewModel())
    }
}
