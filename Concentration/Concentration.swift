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
    private var flipCount = 0, score = 0 
    private var indexOfOneAndOnlyFaceUpCard: Int?
    private var previouslyFlippedCards = [Int:Card]()
//    private var score = 0
    //if card is chosen flip face up or face down
    //3 cases
    // no cards are face up
    // two cards are faced up, don't match. flip down
    // two cards are faced up, they match
    //we do our matching on the card identifier
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            var resultedInMatch = false
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    resultedInMatch = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
                
            // either no cards or 2 cards are now face up
            } else {
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
         
            }
          
            // if we matched, pass flipTypes type to adjustGameScore
            // otherwise, if we did not match and we had previously flipped this card
            // then pass the flipTypes type to the adjustGameScore
            
            if resultedInMatch {
                adjustGameScore(flipType: flipTypes.flipMatched)
            } else if !resultedInMatch && previouslyFlippedCards[index] != nil {
                adjustGameScore(flipType: flipTypes.flipPreviouslySeen)
            }
            previouslyFlippedCards[index] = cards[index]
        }
        print(score)
        flipCount += 1
    }
    //set all cards to face down and unmatched
    //and shuffle cards
    func resetGame() {
        resetCards()
        shuffleCards()
        setFlipCount(to: 0)
    }
    
    private func resetCards() {
        for card in cards.indices {
            cards[card].resetInitialStateOfCard()
        }
    }
    
    private func setFlipCount(to int: Int) {
        flipCount = int
    }
    
    func getFlipCount() -> Int {
        return flipCount
    }
    
    private func setScoreCount(to int: Int) {
        score = 0
    }
    
    func getScoreCount() -> Int {
        return score
    }
    
    
    //we add the same card in twice
    //so the two cards have the same identifier
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card,card]
        }
        shuffleCards()
    }
    
    // Shuffle the cards randomly in place
    private func shuffleCards() {
        // begin checking at end of index
        var index = cards.count - 1
        // check until the first element.
        while index > 0 {
            
            // create a random integer between 0 and the index we are incrementing over
            // no need to check for 0 because the index will never be 0
            // because this is already checked in the while loop
            let randint = Int(arc4random_uniform(UInt32(index)))
            let tmp = cards[index] //hold the index of the looping card in a temp variable
            cards[index] = cards[randint]
            cards[randint] = tmp
            
            index -= 1
        }
    }
    

    private func adjustGameScore(flipType: flipTypes) {
        switch flipType {
            
        // for each flip type
        // compute different score logic
        // only alter the score once per  fliptype
        case .flipMatched:
            score += 2
            break;
        case .flipPreviouslySeen:
            score -= 1
            break;
        case .flipNotPreviouslySeen:
            // score does not need to change
            break;
        }
    }
    
    enum flipTypes {
        case flipMatched
        case flipPreviouslySeen
        case flipNotPreviouslySeen
    }
    
}
