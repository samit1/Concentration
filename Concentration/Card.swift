//
//  Card.swift
//  Concentration
//
//  Created by Sami Taha on 5/8/18.
//  Copyright © 2018 taha.sami. All rights reserved.
//

import Foundation

struct Card : Hashable {
    
    var hashValue: Int {return identifier}
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    
    var isFaceUp = false
    var isMatched = false
    private var identifier: Int
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    mutating func resetInitialStateOfCard() {
        self.isFaceUp = false
        self.isMatched = false
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
