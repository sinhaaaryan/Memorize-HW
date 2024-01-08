//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Aaryan Sinha on 12/24/23.
//

import SwiftUI

class EmojiMemoryGame {
    
    
    private static let emojis = ["🍏", "🍎", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🫐", "🍈", "🍑", "🥭", "🍍", "🥥", "🥝", "🍆"]
    
    private static func createMemoryGame() -> MemoryGame<String> {
        return MemoryGame(numberOfCardPairs: 4, cardContent: { pairIndex in
            if emojis.indices.contains(pairIndex) {
                return emojis[pairIndex]
            }
            else {
                return "??"
            }

            
        })
    }
    
    private var model = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
    
    
//    init(model: MemoryGame<String>) {
//        self.model = model
//    }
}
