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
        VStack(spacing: 5) {
            HStack{
                TextField("Enter Text", text: $search)
                    .border(Color.blue)
                Button(action: { withAnimation(.easeInOut(duration: 1))
                    { self.viewModel.searchFish(search) } }, label: {
                        Text("🔍")
                    })
            }
            .padding(.horizontal, 2.0)
            .frame(width: 350.0)
            
            ScrollView {
                ContentFish()
            }
        }
    }
}

struct ContentFish: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 5.0) {
            ForEach(0..<10) {
                cardFish($0)
            }
        }
    }
}

struct cardFish: View {
    private let id: Int
    init(_ id: Int) {
        self.id = id
    }
    
    var body: some View {
        Text("Item \(id)")
            .foregroundColor(.white)
            .font(.largeTitle)
            .frame(width: 350, height: 200)
            .background(Color.blue)
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ViewModel())
    }
}
