//
//  ViewController.swift
//  Concentration
//
//  Created by Sami Taha on 5/8/18.
//  Copyright © 2018 taha.sami. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    private var theme: Theme?
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
        theme = nil
        
    }
    private func updateViewFromModel() {
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
    
    // choose index for random theme
    private func chooseTheme() -> Theme  {
        let randIndex = Int(arc4random_uniform(UInt32(themes.count)))
        return themes[randIndex]
    }
    
    private struct Theme {
        var name: String
        var emojis: [String]
        var backgroundColor: UIColor
        var cardBackColor:  UIColor
    }
    
    
    
    
    private var themes: [Theme] = [
        Theme(name: "Halloween",
              emojis: ["🎃", "👻","😈","👺","🤡","👽"],
              backgroundColor: #colorLiteral(red: 1, green: 0.8999392299, blue: 0.3690503591, alpha: 1),
              cardBackColor: #colorLiteral(red: 0.5519944677, green: 0.4853407859, blue: 0.3146183148, alpha: 1)),
        Theme(name: "Cats",
              emojis: ["😺", "😹","😻","😼","😽","🙀"],
              backgroundColor: #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1),
              cardBackColor: #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)),
        Theme(name: "Cars",
              emojis: ["🚗", "🚕","🚙","🚌","🚎","🏎"],
              backgroundColor: #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1),
              cardBackColor: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1))
    ]
    
    
    
    // a new game theme is loaded each game
    // since this is being implemented without the viewDidLoad method
    // then we will make the themeIndex optional
    // if it is set, that means the game theme has been chosen
//    private var emojisToDisplay: [String]?
    
    
    // contains the dictionary of what has already been displayed
    private var emoji = [Int: String]()
    
    private func emoji(for card: Card) -> String {
        
        // if the theme has not been set yet
        // then set the emojis to display
        theme = theme ?? chooseTheme()
//        emojisToDisplay = emojisToDisplay ?? chooseTheme()
        
        if emoji[card.identifier] == nil, (theme?.emojis.count)! > 0 {
            
            let randomIndex = Int(arc4random_uniform(UInt32(theme!.emojis.count)))
            emoji[card.identifier] = theme?.emojis.remove(at: randomIndex)
            
        }
        return emoji[card.identifier] ?? "?"
    }
    
    
}

