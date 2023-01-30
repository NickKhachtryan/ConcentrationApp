//
//  ViewController.swift
//  ConcentrationApp
//
//  Created by Nick Khachatryan on 19.02.2022.
//

import UIKit

class ConcentrationViewController: UIViewController {
    
    
     //  MARK: - CUSTOM PROPERTIES
    private lazy var game = ConcentrationModel(numberOfPairsOfCards: numberOfPairsOfCards)
    var numberOfPairsOfCards : Int {
        return (cardButtons.count + 1) / 2
    }
    private(set) var flipCount = 0 {
        didSet {
           updateFlipCountLabel()
        }
    }
    var theme: String?{
        didSet{
            emojiChoices = theme ?? ""
            emoji = [:]
            updateViewFromModel()
        }
    }
    private var emojiChoices = "🦇😱🙀😈🎃👻🍭🍬"
    private var emoji = [Card : String]()
    
    
    //  MARK: - IBOUTLET PROPERTIES
    @IBOutlet private weak var flipCountLabel: UILabel! {
        didSet{
            updateFlipCountLabel()
        }
    }
    @IBOutlet private var cardButtons: [UIButton]!
    
    
    //  MARK: - VC LIFE CYCLE
    override func viewDidLoad() {
        updateViewFromModel()
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
    
    @IBAction func PressNewGame(_ sender: UIButton) {
        flipCount = 0
        game.setNewGame()
    }
    
    
    //  MARK: - FUNCTIONS
      private func updateFlipCountLabel() {
        let attributes: [NSAttributedString.Key:Any] = [
            .strokeWidth : 5.0,
            .strokeColor : UIColor.black
        ]
        let attributedString = NSAttributedString(string: "Flips: \(flipCount)", attributes: attributes)
        flipCountLabel.attributedText = attributedString
    }
    
    private func updateViewFromModel(){
        if cardButtons != nil {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index] 
            if card.isFaceUp {
                button.setTitle(emoji(for : card), for: UIControl.State.normal)
                button.backgroundColor = UIColor.lightGray
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? UIColor.clear : UIColor.blue
            }
        }
    }
}
    
    private func emoji(for card : Card) -> String{
        if emoji[card] == nil , emojiChoices.count > 0 {
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy : emojiChoices.count.arc4random)
            emoji[card] = String(emojiChoices.remove(at: randomStringIndex))
            }
        return emoji[card] ?? "?"
    }
}


//  MARK: - EXTENSIONS
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
