//
//  ViewController.swift
//  ConcentrationGame
//
//  Created by MinKyeongTae on 16/08/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

//
/// Lecture 3)
// 지금까지 만든 집중력게임, 세로모드에선 문제 없어보이지만.. 가로모드가 된다면?? -> 어설픈 레이아웃 상태...
// ✭이런 문제 해결을 위해서 오토레이아웃이 필요하다.

// ### **앞서 강의에서 배운 내용 간략정리**
// - 타겟/액션, IBOutlet, IBOutletCollection
// - 메서드와 프로퍼티 사용
// - 프로퍼티옵저버(didSet, willSet)
// - 배열 Array<Element>
// - 딕셔너리 Dictionary<Key, Value> -> 해쉬타입
// - for in 반복문 : 시퀀스(sequence) 성질이 있는 요소 순회탐색에 사용 가능
// - 문자열, 배열, 딕셔너리, Set 등
// - MVC(Model-View-Controller) 패턴
// - 값타입 Struct, 참조타입 class
// - 초기화함수, initializers
// - 실제 실행 시 초기화 되는 lazy 프로퍼티(프로퍼티옵저버 역할 불가능)
// - 타입변환 (ex) UInt32(Int) )
// - nil이 될 수도 있는 옵셔널, 옵셔널바인딩방법 "if let"

// ### Stride(from:,through:,by:)
// - Float 등의 부동소수점을 반복문으로 돌릴 수 없을까?
// - Swift에서는 stride 전역함수를 이용하여 구현할 수 있다.
// - 부동소수점 이외에 문자열의 인수 등도 셀 수 있다.
// - for (i = 0.5; i<=15.25; i+=0.3) 과 같은 동작의 stride 사용 예
// for i in stride(from: 0.5, through: 15.25, by: 0.3) {
//
// }
// ### Tuple
// - 튜플은 무엇일까? 메소드나 변수가 없는 소형 구조체, 값만 들어가 있는 다른 언어의 구조체와 유사하다.
// - 가볍기때문에 한줄만으로 표현할 수 있다.
// - 여러 요소의 이름을 유연하게 설정할 수 있다.
// - 함수 내에서 하나 이상의 값을 리턴할때 유용하다.
//    - ex) (weight: Double, height: Double)로 신장+체중 리턴
// - Tuple 사용 예)
// let tuple: (String, Int, Double) = ("Hello", 5, 9.84) // tuple의 타입이 Tuple이 된다.
// - Tuple 사용 예 2)
// let tuple2: (w: String, i: Int, v: Double) = ("Hello", 5, 9.85)
// print(tuple2.w) // prints "Hello"
// print(tuple2.i) // prints 5
// print(tuple2.v) // prints 9.85

// ### 계산프로퍼티 (Computed Properties)
// - 쓰기, 읽기 시 기 지정한 get, set 대로 계산되는 프로퍼티
// - 저장프로퍼티와 달리 쓰기, 읽기 시 마다 set, get 블럭 내용을 신행된다.
// - get과 달리 set은 필수 구현요소가 아니다.
//    - -> 읽기/쓰기(get/set) or 읽기(get) 상태로 구현 가능
// - 특정 행위를 할때마다 변경 혹은 읽기가 필요한 경우 유용할 수 있다.
// - **저장프로퍼티, 계산프로퍼티의 특성을 살릴 만한 상황을 잘 판단하여 사용하는 것이 좋다.**
//    - ex) indexOfOneAndOnlyFaceUpCard: Int? -> 카드를 뒤집을때 카드의 상태에 따라 다른 처리가 필요한 변수
// - 계산프로퍼티 사용 예)
// var foo: Double {
//    get {
//        // return the calculated value of foo
//        return 계산된 foo의 값
//    }
//
//    set(newValue) {
//        // do comething based on the fact that foo has changed to newValue
//        // 새로운 값으로 변경이 됄 때 해당 블럭이 실행 된다.
//    }
// }

// ### UIStackView
// - 다양한 UI객체를 묶어 관리할 수 있다.
// - 여러개의 UI를 선택 -> 인터페이스 빌더 하단 embed in View 로 스택뷰 처리가능
// - 스택뷰 프로퍼티
// - distribution : 스택뷰 내 서브뷰의 배치 설정
// - alignment : 스택뷰 정렬 기준 설정

// ### 3강 용어정리
// * Safe Area : 안전영역 즉, 스크린 주변의 다른 UI와 겹치지 않고 배치할 수 있는 영역
import UIKit

class ViewController: UIViewController {
    @IBOutlet var flipCountLabel: UILabel!
    
    // Outlet Collection Property
    @IBOutlet var emojiCardButtons: [UIButton]!
    
    lazy var game: Concentration = Concentration(numberOfPairsOfCards: (emojiCardButtons.count + 1) / 2)
    
    var flipCount: Int = 0 {
        // didSet은 값이 설정되기 직후에 실행되며, 설정되기 전 값인 oldValue에 접근할 수 있다.
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
        
        /// willSet은 값이 설정되기 직전에 실행되며, 새로 설정 된 newValue에 접근할 수 있다.
        willSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    /// * @IBAction은 Xcode에서 추가한 지시문이다. 인터페이스빌더 내 UI객체와 연결이 되어 동작한다.
    @IBAction func emojCardPressed(_ sender: UIButton) {
        flipCount += 1 // 넘긴 횟수를 1 증가 시킨다.
        if let cardNumber = emojiCardButtons.firstIndex(of: sender) { // 선택한 카드의 인덱스를 확인
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
            print("cardNumber = \(cardNumber)")
        } else {
            print("chosen card was not in emojuCardButtons")
        }
    }
    
    func updateViewFromModel() {
        for index in emojiCardButtons.indices {
            let button = emojiCardButtons[index]
            let card = game.cards[index]
            // 카드가 앞면인지 뒷면인지에 따라 카드를 처리한다.
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = .white
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? .clear : #colorLiteral(red: 0.476841867, green: 0.5048075914, blue: 1, alpha: 1)
            }
        }
    }
    
    var emojiChoices = ["👻", "🎃", "😱", "🥵", "🥶", "😭", "💀", "👽"]
    var emoji = [Int: String]()
    func emoji(for card: Card) -> String {
        // 왜 옵셔널이 들어갈까?? -> 딕셔너리에 없는 값일 수도 있기 때문.
        // * 딕셔너리에서 무언가 찾는다면 옵셔널을 리턴한다는 것을 명심하자.
        // 이모지가 셋팅 안되있고, 선택
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            // * arc4random_uniform은 부호없는 정수형만 취급한다. -> UInt32로 랩핑하면 사용 가능
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            // 한번 사용한 이모티콘은 emojiChoices 배열에서 삭제한다.
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        
        return emoji[card.identifier] ?? "?"
    }
}
