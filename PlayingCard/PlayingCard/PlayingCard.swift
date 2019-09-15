//
//  PlayingCard.swift
//  PlayingCard
//
//  Created by MinKyeongTae on 16/09/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

// MARK: - 5강 카드덱 출력하기 구현

import Foundation

// ✓ CustomStringConvertible 프로토콜을 활용하면 콘솔의 특정 값 문자열을 보다 깔끔하게 출력할 수 있다.
struct PlayingCard: CustomStringConvertible {
    var description: String { return "\(rank)\(suit)" }

    var suit: Suit
    var rank: Rank

    // 열거형 타입, Suit
    // 열거형의 원시값 타입을 Int로 지정하면 case 순서대로 1....N의 값을 갖게 된다.
    enum Suit: String {
        case spades = "♠"
        case hearts = "❤️"
        case diamonds = "☘️"
        case clubs = "♦"

        static var all = [Suit.spades, .hearts, .diamonds, .clubs]
    }

    // 열거형 타입, Rank
    enum Rank {
        case ace
        case face(String)
        case numeric(Int)
        // * 만약 들어갈 인자값이 명확하지 않다면 타입만 명시해도 된다.
        //   - 하지만 해당 방법은 타입의 내용이 뭔지 명확하지 않으므로 좋은 표현방법은 아니다.
        // case numuric(pipsCount: Int)
        var order: Int {
            switch self {
            case .ace: return 1
            case let .numeric(pips): return pips
            // where을 사용하면 특정 경우에 따른 실행처리가 가능하다.
            // * 단, where은 모든경우의 수가 아니기 떄문에 Switch문의 완성을 만들어주지 않는다.
            // => "Switch must be exhaustive"
            case let .face(kind) where kind == "J": return 11
            case let .face(kind) where kind == "Q": return 12
            case let .face(kind) where kind == "K": return 13
            default: return 0
            }
        }

        static var all: [Rank] {
            var allRanks = [Rank.ace]
            for pips in 2 ... 10 {
                allRanks.append(Rank.numeric(pips))
            }
            allRanks += [Rank.face("J"), .face("Q"), .face("K")]
            return allRanks
        }
    }
}
