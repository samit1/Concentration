//
//  Concentration.swift
//  Concentration
//
//  Created by Sami Taha on 5/8/18.
//  Copyright © 2018 taha.sami. All rights reserved.
//

import Foundation

class Concentration {
    var cards = [Card]()
    
    private var indexOfOneAndOnlyFaceUpCard: Int?
    //if card is chosen flip face up or face down
    //3 cases
    // no cards are face up
    // two cards are faced up, don't match. flip down
    // two cards are faced up, they match
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                // either no cards or 2 cards are face up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    func resetCards() {
        for card in cards.indices {
            cards[card].resetInitialStateOfCard()
        }
        shuffleCards()
    }
    
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card,card]
        }
        
        shuffleCards()
    }
    
    // Shuffle the cards randomly in place
    private func shuffleCards() {
        print(cards)
        // begin checking at end of index
        var index = cards.count - 1
        print(cards.count)
        // check until the first element.
        while index > 0 {
            
            // create a random integer between 0 and the index we are incrementing over
            // no need to check for 0 because the index will never be 0
            // because this is already checked in the while loop
            let randint = Int(arc4random_uniform(UInt32(index)))
            print(randint)
            let tmp = cards[index] //hold the index of the looping card in a temp variable
            cards[index] = cards[randint]
            cards[randint] = tmp
            
            index -= 1
        }
        print(cards)
    }
    
    
}
