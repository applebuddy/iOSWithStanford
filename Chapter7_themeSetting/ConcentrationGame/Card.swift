//
//  Card.swift
//  ConcentrationGame
//
//  Created by MinKyeongTae on 23/08/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import Foundation

struct Card: Hashable {
    var isFaceUp = false
    var isMatched = false
    private var identifier: Int

    // Hashable이 준수해야하는 Equatable을 구현한다.
    // deprecated variable, hashValue -> hash(into:)를 대체해 사용해야 한다.
    var hashValue: Int { return identifier }

    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }

    // * 내부적인 처리방식의 타입프로퍼티, 타입메서드는 private 설정 해준다.
    // 타입 프로퍼티, Card 타입에 붙어있는 프로퍼티
    private static var identifierFactory = 0

    // 정적 메서드, Card 타입에 붙어있는 메서드.
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }

    init() {
        identifier = Card.getUniqueIdentifier()
    }
}
