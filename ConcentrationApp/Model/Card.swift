//
//  Card.swift
//  ConcentrationApp
//
//  Created by Nick Khachatryan on 20.02.2022.
//

import Foundation

struct Card : Hashable {
    
    
    //  MARK: - CUSTOM PROPERTIES
    var isFaceUp = false
    var isMatched = false
    private var identifier: Int
    private static var identifierFactory = 0
    
    
    //  MARK: - FUNCTIONS
    private static func getUniqueIdentifier() -> Int{
        identifierFactory += 1
        return identifierFactory
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    static func ==(lhs: Card, rhs: Card) -> Bool{
        return lhs.identifier == rhs.identifier
    }
    
    
    //  MARK: - INITIALIZATIONS
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
