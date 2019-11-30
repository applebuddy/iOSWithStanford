//
//  Concentration.swift
//  ConcentrationGame
//
//  Created by MinKyeongTae on 23/08/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

struct Concentration {
    // 카드의 매칭을 위해 읽기는 필요하지만 외부의 할당권한까지 줄 필요는 없으므로 private(set) 접근제어를 설정한다.(Concentration 내부에서만 쓰기, 할당이 가능)
    private(set) var cards = [Card]()

    // 내부적으로 이미 구현되어 있으므로, Private 처리를 해도 무방하다.
    // 계산프로퍼티로 구현되는 indexOfOneAndOnlyFaceUpCard
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {
            // ✭ 클로져를 활용하면 보다 가독성있고 간결한 코드를 구성할 수 있다.
            // 컬렉션에서 제공하는 filter 클로저를 적용한다.
            // 1) cards의 계수가능 법위 정수를 순회하며 앞면인 경우만 추린다.
            // 2) 만약 앞면인 카드가 하나뿐일 경우면 해당 인덱스를 리턴, 그 이외에는 nil을 반환한다.
            // 각각 인덱스의 카드가 앞면이면 true, 뒷면이면 false를 리턴할 것이다.
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly

//            var foundIndex: Int?
//            for index in cards.indices {
//                if cards[index].isFaceUp {
//                    // 막 하나만 뒤집은 상황
//                    if foundIndex == nil {
//                        foundIndex = index
//                    } else { // 이미 하나 뒤집고 두번째 뒤집는 상황
//                        // 두개 뒤집은 뒤엔 다시 nil로 초기화 한다.
//                        return nil
//                    }
//                }
//            }
//            return foundIndex
        }

        // newValue는 set 블럭 내의 지역변수가 될 것 이다.(newValue 외 다른 변수명으로 지정할 수도 있다.)
        set {
            // indexOfOneAndOnlyFaceUpCard가 방금 설정한 "어떤 수"와 같으면 참값이 된다.
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }

    // 기본적인 공개 API(외부 객체에서 사용하는 API) 이므로 해당 메서드는 private 처리하지 않는다.
    // 카드를 선택한다.
    // struct Concentration -> mutating을 통해 객체를 바꾸는 함수임을 명시하면 오류가 사라진다.
    mutating func chooseCard(at index: Int) {
        // ✭ 공개 API 내의 보호를 위해 Assertion 단언문을 넣어 잘못된 인자값이 들어올 시 오류를 발생시킬 수 있다.
        // 사용자가 잘못 된 인자값을 넣었음을 알 수 있도록 한다.
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index): chosen index not in the cards")

        if !cards[index].isMatched {
            // 비교해야할 카드 인덱스가 존재하고, 이후 선택한 인덱스가 다른 인덱스일때, 비교를 시작한다.
            if let matchIndex = indexOfTheOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                // 만약 비교하는 두개의 카드 식별자가 일치한다면,
                if cards[matchIndex] == cards[index] {
                    // 두개의 카드는 서로 매치 처리
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true

            } else {
                // 단 하나 뒤집어진 카드 인덱스를 indexOfOneAndOnlyFaceUpCard에 저장한다.
                indexOfTheOneAndOnlyFaceUpCard = index
            }
        }
    }

    init(numberOfPairsOfCards: Int) {
        // * 양수값이 아닌 잘못된 값이 들어왔을 시 오류를 발생시키는 Assert 단언문으로 공개메서드 사용시 오류를 인지할 수 있다.
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): you must have at least one pair of cards")
        for _ in 0 ..< numberOfPairsOfCards {
            // 카드종류 * 2 만큼의 카드를 생성한다.
            let card = Card()
            cards += [card, card]
        }
        // TODO: Shuffle the cards
        cards.shuffle()
    }
}

extension Collection {
    // 배열 내 요소가 하나일 때 단 하나 존재하는 하나의 값을 반환하는 variable
    // ex) "hello".oneAndOnly // => nil
    //      "h".oneAndOnly // 단 하나의 요소만 존재하므로 해당 요소를 출력 => "h"
    // * Element : 컬렉션의 요소 별명 타입
    var oneAndOnly: Element? {
//         collection의 기본 프로퍼티들
//             - count : 컬렉션의 크기를 반환
//             - first : 컬렉션의 첫번째 요소를 반환
        return count == 1 ? first : nil
    }
}
