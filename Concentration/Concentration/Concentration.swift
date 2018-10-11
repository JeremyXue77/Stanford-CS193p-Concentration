//
//  Concentration.swift
//  Concentration
//
//  Created by JeremyXue on 2018/10/10.
//  Copyright © 2018 JeremyXue. All rights reserved.
//

import Foundation

class Concentration {
    
    var cards = [Card]()
    
    var isOver = false
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    func chooseCard(at index: Int) {
        
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
                checkGameStatus()
            } else {
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    // Check if all the cards are matched
    func checkGameStatus() {
        for card in cards {
            if !card.isMatched {
                isOver = false
                return
            }
        }
        isOver = true
    }
    
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        // TODO: Shuffle the cards
        cards.shuffle()
    }
}
