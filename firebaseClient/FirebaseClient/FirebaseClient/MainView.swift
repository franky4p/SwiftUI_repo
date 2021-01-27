//
//  MainView.swift
//  FirebaseClient
//
//  Created by macbook on 27.01.2021.
//

import SwiftUI

struct MainView: View {
    var viewModel: ViewModel
    
    var body: some View {
        VStack{
            HStack{
                Spacer()
                Button(action: { self.viewModel.disConnect() },
                       label: { Text("Выйти") })
            }.padding()
            Text("Hello \(viewModel.currentUser())")
            Spacer()
        }
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(viewModel: ViewModel())
    }
}
