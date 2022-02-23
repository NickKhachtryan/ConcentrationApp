//
//  ViewController.swift
//  ConcentrationApp
//
//  Created by Nick Khachatryan on 19.02.2022.
//

import UIKit

class ViewController: UIViewController {
    
     
    private lazy var game = ConcentrationModel(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards : Int {
        return (cardButtons.count + 1) / 2
    }
    
    private(set) var flipCount = 0 { didSet { flipCountLabel.text = "Flips: \(flipCount)" } }
        
    private var emojiChoices = ["🦇" , "😱", "🙀" , "😈" , "🎃" , "👻" , "🍭" , "🍬" , "🍎"]
    
    private var emoji = [Int : String]()
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    @IBOutlet private var cardButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
//  MARK: - ACTIONS
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card was not in var cardButtons")
        }
    }
    
    
    //  MARK: - FUNCTIONS
    
    private func updateViewFromModel(){
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for : card), for: UIControl.State.normal)
                button.backgroundColor = UIColor.white
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? UIColor.clear : UIColor.orange
            }
        }
    }
    
    private func emoji(for card : Card) -> String{
        if emoji[card.identifier] == nil , emojiChoices.count > 0 {
            emoji[card.identifier] = emojiChoices.remove(at: emojiChoices.count.arc4random)
            }
        return emoji[card.identifier] ?? "?"
    }
}

extension Int{
    var arc4random: Int{
        if self > 0{
        return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0{
            return -Int(arc4random_uniform(UInt32(self)))
        } else {
            return 0
        }
    }
}
