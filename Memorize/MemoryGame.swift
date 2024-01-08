//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Aaryan Sinha on 12/24/23.
//

import Foundation



struct MemoryGame<CardContent> {
    
    private(set) var cards: Array<Card>
    
    
    init(numberOfCardPairs: Int, cardContent: (Int) -> CardContent) {
        cards = []
        
        for pairIndex in 0..<max(2, numberOfCardPairs) {
            let content = cardContent(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
        
    }
    
    func choose(card: Card) {
        
    }
    
    
    
    
    
    // Cards: Faceup state for each
    // Cardcount
    // If two of the same card are face up at the same time, add to the score
    // Score counter
    // When is the game over
    // Choose a card
    
    
    struct Card {
        var isFaceUp = false
        var isMatched = false
        let content: CardContent
        
    }
    
    
}



