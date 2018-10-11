//
//  ViewController.swift
//  Concentration
//
//  Created by JeremyXue on 2018/10/8.
//  Copyright © 2018 JeremyXue. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    
    var flipCount: Int = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }

    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet weak var restartButton: UIButton!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    var emojiChoices = ["🎃","👻","😱","🙀","🍭","😈","🍬","🦇","🍎"]
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            if game.cards[cardNumber].isFaceUp {
                return
            }
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
            flipCount += 1
            if game.isOver {
                restartButton.isHidden = false
            }
        } else {
            print("choose card was not in cardButtons")
        }
    }
    
    @IBAction func restartGame(_ sender: UIButton) {
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        emojiChoices = ["🎃","👻","😱","🙀","🍭","😈","🍬","🦇","🍎"]
        updateViewFromModel()
        sender.isHidden = true
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
            
            if card.isMatched {
                button.isEnabled = false
            } else {
                button.isEnabled = true
            }
        }
    }
    
    var emoji = [Int:String]()
    
    func emoji(for card: Card) -> String {
        
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        
        return emoji[card.identifier] ?? "?"
    }
    
}

