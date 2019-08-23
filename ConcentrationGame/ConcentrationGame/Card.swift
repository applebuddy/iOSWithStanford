//
//  Card.swift
//  ConcentrationGame
//
//  Created by MinKyeongTae on 23/08/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import Foundation

struct Card {
    var isFaceUp = false
    var isMatched = false
    var identifier: Int

    // 타입 프로퍼티, Card 타입에 붙어있는 프로퍼티
    static var identifierFactory = 0

    // 정적 메서드, Card 타입에 붙어있는 메서드.
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }

    init() {
        identifier = Card.getUniqueIdentifier()
    }
}
