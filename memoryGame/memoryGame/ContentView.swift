//
//  ContentView.swift
//  memoryGame
//
//  Created by macbook on 29.11.2020.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: EmojiGame
    
    var body: some View {
        VStack {
            Grid(items: viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    withAnimation(.easeInOut(duration: 1)) {
                        viewModel.choose(card: card) }
                }
                .padding(5)
            }
            .padding()
            .foregroundColor(.green)
            Button(action: { withAnimation(.easeInOut(duration: 1)) 
                    { self.viewModel.resetGame()} }, label: {
                Text("New game")
            })
        }
    }
}

struct CardView: View {
    var card: Memorize<String>.Card
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    @State private var animatedBonus: Double = 0
    
    private func startBonusTimeAnimation() {
        animatedBonus = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            animatedBonus = 0
        }
    }
    
    @ViewBuilder
    func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Group {
                    if card.isConsumingBonusTime {
                        Pie(startAngle: Angle.degrees(0-90), endAngel: Angle.degrees(-animatedBonus*360-90), clockwise: true)
                            .onAppear { self.startBonusTimeAnimation() }
                    } else {
                        Pie(startAngle: Angle.degrees(0-90), endAngel: Angle.degrees(-card.bonusRemaining*360-90), clockwise: true)
                    }
                }
                .padding(5).opacity(0.4)
                Text(card.content)
                    .font(Font.system(size: fontSize(for: size)))
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(.easeIn(duration: 1))
            }
            .modifier(Cardyfy(isFaceUp: card.isFaceUp))
            .transition(.scale)
        }
    }
    
//    MARK: - Drawing Constants
    let fontScaleFactor: CGFloat = 0.65
    
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.7
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: EmojiGame())
    }
}
