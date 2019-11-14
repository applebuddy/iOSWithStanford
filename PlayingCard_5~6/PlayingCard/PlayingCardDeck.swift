//
//  PlayingCardDeck.swift
//  PlayingCard
//
//  Created by MinKyeongTae on 16/09/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import Foundation

struct PlayingCardDeck {
    private(set) var cards = [PlayingCard]()

    init() {
        for suit in PlayingCard.Suit.all {
            for rank in PlayingCard.Rank.all {
                cards.append(PlayingCard(suit: suit, rank: rank))
            }
        }
    }

    // 구조체의 변형을 일으키는 메서드이므로 메서드에 mutating func을 지정해준다.
    mutating func draw() -> PlayingCard? {
        if cards.count > 0 {
            return cards.remove(at: cards.count.arc4random)
        } else {
            return nil
        }
    }
}

// 확장기능, extension의 사용 예
// extension을 통해 코드를 더욱 간결하게 구현 할 수 있다.
// extension 코드 내 여러가지 입력값에 대비한 코드처리를 했다.
extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
