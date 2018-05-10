//
//  ViewController.swift
//  Concentration
//
//  Created by Sami Taha on 5/8/18.
//  Copyright © 2018 taha.sami. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
    }
    
    @IBAction func resetGame(_ sender: UIButton) {
        // let Concentration know the reset was pressed
        // so it can update its intrnal state
        game.resetGame()
        
        // update view
        updateViewFromModel()
        
        // reset dictionary
        emoji = [:]
        
        // set the theme to nil
        emojisToDisplay = nil
        
    }
    func updateViewFromModel() {
        flipCountLabel.text = "Flips: \(game.getFlipCount())"
        scoreLabel.text = "Score: \(game.getScoreCount())"
        updateFlipColors()

    }
    
    private func updateFlipColors() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    
    var availableGameThemes = [
        ["🎃", "👻","😈","👺","🤡","👽"],
        ["😺", "😹","😻","😼","😽","🙀"],
        ["🚗", "🚕","🚙","🚌","🚎","🏎"]
    ]
    
    
    // choose a random theme
    private func chooseTheme() -> [String]  {
        let randIndex = Int(arc4random_uniform(UInt32(availableGameThemes.count)))
        return availableGameThemes[randIndex]
    }
    
    // a new game theme is loaded each game
    // since this is being implemented without the viewDidLoad method
    // then we will make the themeIndex optional
    // if it is set, that means the game theme has been chosen
    var emojisToDisplay: [String]?
    
    
    // contains the dictionary of what has already been displayed
    var emoji = [Int: String]()
    
    private func emoji(for card: Card) -> String {
        
        // if the theme has not been set yet
        // then set the emojis to display
        emojisToDisplay = emojisToDisplay ?? chooseTheme()
        
        if emoji[card.identifier] == nil, emojisToDisplay!.count > 0 {
            
            let randomIndex = Int(arc4random_uniform(UInt32(emojisToDisplay!.count)))
            emoji[card.identifier] = emojisToDisplay!.remove(at: randomIndex)
            
        }
        return emoji[card.identifier] ?? "?"
    }
    
    
}

