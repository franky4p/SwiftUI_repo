//
//  SettingsView.swift
//  Quiz
//
//  Created by macbook on 21.03.2021.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        Toggle(isOn: $viewModel.shuffle){
            Text("Перемешать вопросы")
        }
        Spacer()
    }
}
