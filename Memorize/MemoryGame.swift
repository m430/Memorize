//
//  MemorizeGame.swift
//  Memorize
//
//  Created by 郑敏 on 2023/10/25.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    
    init(numberOfPairOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        for pairIndex in 0..<max(2, numberOfPairOfCards) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: "\(pairIndex+1)a"))
            cards.append(Card(content: content, id: "\(pairIndex+1)b"))
        }
        
    }
    
    var indexOfOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter {index in cards[index].isFaceUp}.only }
        set { cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0)}}
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
                if let potentialMatchedIndex = indexOfOneAndOnlyFaceUpCard {
                    if cards[chosenIndex].content == cards[potentialMatchedIndex].content {
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchedIndex].isMatched = true
                    }
                } else {
                    indexOfOneAndOnlyFaceUpCard = chosenIndex
                }
                cards[chosenIndex].isFaceUp = true
            }
        }
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    struct Card: Identifiable, Equatable, CustomDebugStringConvertible {
        var isFaceUp = false
        var isMatched = false
        var content: CardContent
        
        var id: String
        var debugDescription: String {
            "\(id): \(content) \(isFaceUp ? "up" : "down") \(isMatched ? "matched" : "")"
        }
    }
}

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
