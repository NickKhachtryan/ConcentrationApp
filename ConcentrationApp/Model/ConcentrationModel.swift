//
//  ConcentrationModel.swift
//  ConcentrationApp
//
//  Created by Nick Khachatryan on 20.02.2022.
//

import Foundation

struct ConcentrationModel{
    
    
    //  MARK: - CUSTOM PROPERTIES
    private(set) var cards = [Card]()
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter {cards[$0].isFaceUp}.oneAndOnly
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    
    //  MARK: - FUNCTIONS
    mutating func chooseCard(at index: Int){
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in the cards")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex] == cards[index]{
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
         }
    }
    
   mutating func setNewGame(){
        for index in cards.indices {
            cards[index].isFaceUp = false
            cards[index].isMatched = false
        }
       cards.shuffle()
    }
    
    //  MARK: - INITIALIZATIONS
    init(numberOfPairsOfCards: Int){
        assert(numberOfPairsOfCards > 0, "Concentration.init(at: \(numberOfPairsOfCards)): you must have at least one pair of cards")
        for _ in 1...numberOfPairsOfCards{
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
    }
}


    //  MARK: - EXTENSIONS
extension Collection {
    
    
    var oneAndOnly : Element? {
        return count == 1 ? first : nil
    }
}
