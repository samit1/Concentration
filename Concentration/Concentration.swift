//
//  Concentration.swift
//  Concentration
//
//  Created by Sami Taha on 5/8/18.
//  Copyright © 2018 taha.sami. All rights reserved.
//

import Foundation

struct Concentration {
    private(set) var cards = [Card]()
    private var flipCount = 0, score = 0 
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
//            return faceUpCardIndices.count == 1 ? faceUpCardIndices.first : nil
            
        } set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    
    
    private var previouslyFlippedCards = [Int:Card]()
    //    private var score = 0
    //if card is chosen flip face up or face down
    //3 cases
    // no cards are face up
    // two cards are faced up, don't match. flip down
    // two cards are faced up, they match
    //we do our matching on the card identifier
    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index): chosen index not in the cards")
        if !cards[index].isMatched {
            var resultedInMatch = false
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    resultedInMatch = true
                }
                cards[index].isFaceUp = true
                
                // either no cards or 2 cards are now face up
            } else {
                indexOfOneAndOnlyFaceUpCard = index
                
            }
            
            // if we matched, pass flipTypes type to adjustGameScore
            // otherwise, if we did not match and we had previously flipped this card
            // then pass the flipTypes type to the adjustGameScore
            
            if resultedInMatch {
                adjustGameScore(flipType: flipTypes.flipMatched)
            } else if !resultedInMatch && previouslyFlippedCards[index] != nil && indexOfOneAndOnlyFaceUpCard != index {
                adjustGameScore(flipType: flipTypes.flipPreviouslySeen)
            }
            previouslyFlippedCards[index] = cards[index]
        }
        print(score)
        flipCount += 1
    }
    //set all cards to face down and unmatched
    //and shuffle cards
    mutating func resetGame() {
        resetCards()
        shuffleCards()
        setFlipCount(to: 0)
        setScoreCount(to: 0)
    }
    
    private mutating func resetCards() {
        for card in cards.indices {
            cards[card].resetInitialStateOfCard()
        }
    }
    
    private mutating func setFlipCount(to int: Int) {
        flipCount = int
    }
    
    func getFlipCount() -> Int {
        return flipCount
    }
    
    private mutating func setScoreCount(to int: Int) {
        score = 0
    }
    
    func getScoreCount() -> Int {
        return score
    }
    
    
    //we add the same card in twice
    //so the two cards have the same identifier
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init\(numberOfPairsOfCards) is negative")
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card,card]
        }
        shuffleCards()
    }
    
    // Shuffle the cards randomly in place
    private mutating func shuffleCards() {
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
    
    
    private mutating func adjustGameScore(flipType: flipTypes) {
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

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
