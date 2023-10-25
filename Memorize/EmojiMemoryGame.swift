//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by 郑敏 on 2023/10/25.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    private static let emojis = ["👻", "🎃", "🕷️", "😈", "💀", "🕸️", "😱", "👹", "☠️", "👺", "👽", "🤖"]
    
    @Published
    private var model = MemoryGame(numberOfPairOfCards: 10) { pairIndex in
        return emojis[pairIndex]
    }
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    // MARK: - Intents
    
    func shuffle() {
        model.shuffle()
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
