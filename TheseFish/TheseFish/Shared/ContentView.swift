//
//  ContentView.swift
//  TheseFish
//
//  Created by macbook on 07.01.2021.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ViewModel
    @State var search: String = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 5) {
                HStack{
                    TextField("Enter Text", text: $search)
                        .border(Color.blue)
                    Button(action: { withAnimation(.easeInOut(duration: 1))
                        { self.viewModel.searchFish(search) } }, label: {
                            Text("🔍")
                        })
                }
                .frame(width: 350.0)
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 5.0) {
                        ForEach(viewModel.categories) {card in
                            cardCategory(card.category ?? "")
                        }
                    } .onAppear { self.viewModel.addCategories() }
                }
            }.navigationBarTitle(Text("🌏 🐠"))
        }
    }
}

struct cardCategory: View {
//    let card: Categories
    private let title: String
    init(_ title: String) {
        self.title = title
    }
    
    var body: some View {
        NavigationLink(destination: DetailView(title: title)) {
            Text("\(title)")
                .foregroundColor(.white)
                .font(.largeTitle)
                .multilineTextAlignment(.center)
                .frame(width: 350, height: 200)
                .background(Color.blue)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ViewModel())
    }
}
