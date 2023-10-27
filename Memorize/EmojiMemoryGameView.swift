//
//  ContentView.swift
//  Memorize
//
//  Created by 郑敏 on 2023/10/23.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    typealias Card = MemoryGame<String>.Card
    
    @ObservedObject
    var viewModel: EmojiMemoryGame
    
    private let aspectRatio: CGFloat = 2/3
    
    var body: some View {
        VStack {
            cards
                .foregroundColor(viewModel.color)
                .animation(.default, value: viewModel.cards)
            Button("Shuffle") {
                viewModel.shuffle()
            }
        }
        .padding()
    }
    
    private var cards: some View {
        AspectVGrid(viewModel.cards, aspectRatio: aspectRatio) { card in
            CardView(card)
                .padding(4)
                .overlay(FlyingNumber(number: scoreChange(causeBy: card)))
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 3)) {
                        viewModel.choose(card)
                    }
                }
        }
        .foregroundColor(viewModel.color)
    }
    
    private func scoreChange(causeBy card: Card) -> Int {
        return 0
    }
}

struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
