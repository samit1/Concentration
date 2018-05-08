//
//  ViewController.swift
//  Concentration
//
//  Created by Sami Taha on 5/8/18.
//  Copyright © 2018 taha.sami. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    private var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }

    var emojoChoices = ["🎃", "👻", "🎃", "👻"]
    
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender) {
            flipCard(withEmoji: emojoChoices[cardNumber], on: sender)
            print("cardNumber = \(cardNumber)")
        } else {print("Chosen card was not in cardButtons") }
    }

    @IBOutlet var cardButtons: [UIButton]!
    
    
    // card is flipped back when colored
    // card is flipped front when emoji showing
    private func flipCard(withEmoji emoji: String, on button: UIButton) {
        print("flipCard(withEmoji: \(emoji)")
        if button.currentTitle == emoji {
            button.setTitle("", for: UIControlState.normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        } else {
            button.setTitle(emoji, for: UIControlState.normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }
    
}

