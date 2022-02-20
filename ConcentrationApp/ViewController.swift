//
//  ViewController.swift
//  ConcentrationApp
//
//  Created by Nick Khachatryan on 19.02.2022.
//

import UIKit

class ViewController: UIViewController {
    
    var flipCount = 0{
        didSet{
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    var emojiChoices = [ "🎃", "👻", "🎃", "👻"]
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
//  MARK: - ACTIONS
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender){
            flipCard(withEmoji: emojiChoices[cardNumber], on: sender)
        } else {
            print("chosen card was not in var cardButtons")
        }
    }
    
    
    //  MARK: - FUNCTIONS
    
    func flipCard(withEmoji emoji : String , on button: UIButton){
        if button.currentTitle == emoji {
            button.setTitle("", for: UIControl.State.normal)
            button.backgroundColor = UIColor.orange
        } else {
            button.setTitle(emoji, for: UIControl.State.normal)
            button.backgroundColor = UIColor.white
        }
    }
    
}

