//
//  Concentration.swift
//  ConcentrationGame
//
//  Created by MinKyeongTae on 23/08/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

class Concentration {
    var cards = [Card]()

    // 계산프로퍼티로 구현되는 indexOfOneAndOnlyFaceUpCard
    var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    // 막 하나만 뒤집은 상황
                    if foundIndex == nil {
                        foundIndex = index
                    } else { // 이미 하나 뒤집고 두번째 뒤집는 상황
                        // 두개 뒤집은 뒤엔 다시 nil로 초기화 한다.
                        return nil
                    }
                }
            }
            return foundIndex
        }

        // newValue는 set 블럭 내의 지역변수가 될 것 이다.(newValue 외 다른 변수명으로 지정할 수도 있다.)
        set {
            // indexOfOneAndOnlyFaceUpCard가 방금 설정한 "어떤 수"와 같으면 참값이 된다.
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }

    // 카드를 선택한다.
    func chooseCard(at index: Int) {
        // ===============계산프로퍼티 설정으로 필요 없어진 코드부분 =============== //
//        if cards[index].isFaceUp {
//            cards[index].isFaceUp = false
//        } else {
//            cards[index].isFaceUp = true
//        }
        // ===============계산프로퍼티 설정으로 필요 없어진 코드부분 =============== //

        if !cards[index].isMatched {
            // 비교해야할 카드 인덱스가 존재하고, 이후 선택한 인덱스가 다른 인덱스일때, 비교를 시작한다.
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                // 만약 비교하는 두개의 카드 식별자가 일치한다면,
                if cards[matchIndex].identifier == cards[index].identifier {
                    // 두개의 카드는 서로 매치 처리
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true

                // ===============계산프로퍼티 설정으로 필요 없어진 코드부분 =============== //
//                indexOfOneAndOnlyFaceUpCard = nil // 비교대상 카드는 다시 없어졌으므로 nil 처리

            } else {
                // 단 하나 뒤집어진 카드 인덱스를 indexOfOneAndOnlyFaceUpCard에 저장한다.
                indexOfOneAndOnlyFaceUpCard = index

                // ===============계산프로퍼티 설정으로 필요 없어진 코드부분 =============== //
//                // either no cards or 2 cards are face up
//                // 비교 대상 카드가 없거나 다른 인덱스 선택이 없었다면 모든 카드를 원상태로 뒤집는다.
//                for flipDownIndex in cards.indices {
//                    cards[flipDownIndex].isFaceUp = false
//                }
//                // 선택한 카드 단 하나만 반대로 뒤집는다.
//                cards[index].isFaceUp = true
                // ===============계산프로퍼티 설정으로 필요 없어진 코드부분 =============== //
            }
        }
    }

    init(numberOfPairsOfCards: Int) {
        for _ in 0 ..< numberOfPairsOfCards {
            // 카드종류 * 2 만큼의 카드를 생성한다.
            let card = Card()
            cards += [card, card]
        }
        // TODO: Shuffle the cards
        cards.shuffle()
    }
}
