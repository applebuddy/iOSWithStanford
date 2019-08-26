//
//  ViewController.swift
//  ConcentrationGame
//
//  Created by MinKyeongTae on 16/08/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

// 4강)
//  4강에서 다룰 주제 : protocol, closure, string, mutating...
//  Concentration 객체를 class -> struct로 변경!
//    - 이제 Concentration은 ViewController에 참조되는 포인터가 아닌 하나의 모델이 된다.
//    - **왜 구조체로 교체할까??**
//        - 구조체는 값복사 타입이다. 그러므로 Heap에 존재하지 않고 구조체를 전달 시 계속해서 그 값을 복사한다.
//        - 값이 계속 복사되니 비효율적이라고 생각할 수 있다.
//        - 다만 스위프트는 영리해서 struct일 지라도 해당 내용이 변경되엇을 때만 값을 복제한다.

// ## Protocol
// - Struct, Class, Enum과 함께 스위프트의 자료구조를 형성하는 네번째 기둥
//    - 별도의 구현이 없는 메서드와 변수의 리스트이자 하나의 일급타입
//    - 프로토콜은 API에서 원하는 것을 불러운 방식으로 작동한다.
//    - 블라인드 커뮤니케이션을 할때 최적의 도구이다.
//    - 특정 유사한 기능을 공유하면서도 동일한 클래스로부터 상속받을 필요가 없도록 할 수 있다.
//    - ** 프로토콜은 코드가 없다. 구현방식이 아닌 순수한 선언이기 때문이다. **
//    - 만약 ** 특정 프로토콜이 클래스만 받는 프로토콜 이라면, 프로토콜 뒤에 : class 를 표시 ** 해주어야 한다.
//      - : class 선언을 해두면 굳이 mutating 표시를 할 필요가 없다. class 에 mutating 을 넣을 일은 없기 때문이다.
//      - extension에 protocol을 채택하여 사용할 수도 있다.

// ### 프로토콜의 선언
// - 1) 프로토콜의 선언
//  - 클래스, 열거형, 구조체 선언과 같은 선언방식
//  - 클래스, 구조체 등의 선언방식과 유사
//// 프로토콜 선언 예
// AProtocol을 구현하려면, IngeritedProtocolA, InheritedProtocolB 프로토콜을 충족시켜야 한다.
// protocol AProtocol: InheritedProtocolA, InheritedProtocolB {
//    var someProperty: Int { get set }
//    func aMethod(arg1: Double, anotherArgument: String) -> SomeType
//    mutating func changeIt()
//    init(arg: Type)
// }
// - 2) 클래스나 구조체, 열거형이 프로토콜의 메서드, 변수를 구성
// - 3) 클래스나 구조체, 열거형 등의 구조 내부에 구성
//    - 클래스로 프로토콜을 구현하려 한다면 클래스의 init 에 required 예약어를 붙여주어야 만 한다.
//    - 서브클래스에서는 더이상 이 프로토콜을 구현하지 않았는데도 사람들은 프로토콜이 서브클래스에서도 가능한것으로 착각할 수 있기 때문이다.
//    - 서브클래스의 init이 형성되지 않도록 메인 클래스의 required init 지정을 해준다.

// ### 프로토콜 채택방법
//// 프로토콜 채택방법 예시(클래스)
// class SomeClass: SuperClassOfSomeClass, SomeProtocol, AnotherProtocol {
//    // 클래스의 구현
//    // 채택한 프로토콜, SomeProtocol, AnotherProtocol을 준수해야한다.
// }
//// 프로토콜 채택방법 예시(구조체)
// struct SomeStruct: SomeProtocol, AnotherProtocol {
//    // 구조체의 구현
//    // 채택한 프로토콜, SomeProtocol, AnotherProtocol을 준수해야한다.
// }

// ### 프로토콜 옵셔널 메서드
// - 프로토콜에서 지정한 메서드를 반드시 선언하지 않아도 되도록 설정할 수 있다.
// - 프로토콜의 메서드를 선택적으로 사용 할 수 있다.

// ### mutating
//// Concentratino을 struct로 변경하니 내부 오류가 발생한다. 이때 내부에서 Concentration 객체 자체를 변경시킬 것임을 mutating을 통해 명시해주어야 한다.

// ### 프로토콜 사용 예
//// 프로토콜, Moveable
// protocol Moveable {
//    mutating func move(to point: CGPoint)
// }
//// Moveable 프로토콜을 채택한 클래스, Car
// class Car: Moveable {
//    // Car는 Class이자 참조타입이므로 mutating이 필요없다.
//    func move(to point: CGPoint) {...}
//    func changeOil()
// }
//
// struct Shape: Moveable {
//    // Shape는 Struct이다 값타입이므로 mutating을 명시해주어야 한다.
//    mutating func move(to point: CGPoint) {...}
//    func draw()
// }
//
//// Car 인스턴스, prius
// let prius: Car = Car()
//// Shape 인스턴스, square
// let square: Chape = Chape()
//
//// prius를 참조하는 thingToMovem
// var thingToMove: Moveable = prius
//thingToMove.move(to:...) // prius의 move(to:)가 실행된다.
//thingToMove.changeOil() // Moveable타입이므로 Car의 메서드 실행불가
//
//// prius, square을 Moveable 타입 배열로 받을 수 있다.
//// 둘다 Moveable 프로토콜을 준수하는 인스턴스이기 때문이다.
// let thingsToMove: [Moveable] = [prius, square]
//
// func slide(slider: Moveable) {
//    let positionToSlideTo = ...
//        slider.move(to: positionToSlideTo)
// }
//
//// prius, square 둘 다 Moveable 프로토콜을 준수하기때문에 들다 slide의 인자값으로 사용할 수 있다.
// slide(slider: prius)
// slide(slider: square)

// ### MVC Delegation
// - Protocol을 사용하면 ViewController에서 데이터 Model에 대해서 몰라도 뷰-모델 간 반응을 시킬 수 있다.
//
// ### MVC Delegation 사용 순서
// - 1) 스크롤뷰, 테이블뷰와 같은 델리게이션 P프로토콜을 선언한다. ex) will, should, did...
//// delegate 변수를 weak으로 설정
//// -> 사용하지 않고, 힙에서 빠져나가려 한다면 nil로 설정하고 더이상 사용하지 않는다.
//// ex) weak var delegate: UIScrollViewDelegate?
//
// - 2) 프로토콜 적용을 할 A뷰 내부에 D변수를 생성한다. 이 D변수는 공개변수이며 weak속성을 가진다.
// - 3) A뷰가 will, did, should등의 이벤트를 보내고 싶을때 D변수에 전해주면 된다.
// - 4) C컨트롤러가 P프로토콜을 채택한다. 사용을 시작한다.
// - 5) C컨트롤러가 A뷰의 P프로토콜 변수인 B변수를 자기 자신으로 설정한다.
//    //ex) scrollView.delegate = self
//  - C컨트롤러는 P프로토콜의 D델리게이트를 구현하기로 선언했고, D델리게이트는 P프로토콜을 타입으로 가지고 있다.
// - 6) C컨트롤러는 프로토콜을 준수해야한다. (프로토콜의 모든 필수 메서드를 구현해야 한다.)
//  - 일반적으로 대부분의 델리게이트 메서드는 옵셔널이다. 그렇기에 대부분은 그냥 원하는 델리게이트 메서드만 사용할 수 있다.
// - 7) C컨트롤러가 P프로토콜의 D델리게이트 변수를 자기자신으로 선언 + 델리게이트메서드 구현을 하여 서로 의사소통할 수 있다.
//  - A뷰는 C컨트롤러로 원하는 will, did, should 이벤트 등을 전달 할 수 있게 되었다.
//  - C컨트롤러는 A뷰 클래스에대해 잘 몰라도 뷰와 소통할 수 있게 되었다.

// ### Hashable
// - 해쉬가능하다 -> 딕셔너리의 키가 될 수 있다.

//// Hashable의 Protocol 사용 예시)
//// Hashable 해시테이블 등에서 고유한 해시같아 보이지만 그것을 보장할 수 없다.
//// => 이를 확실히 보장하기 위해 등호를 통해 서로 동일한지 비교가 필요하다. 그래서 Equatable프로토콜을 준수한다.
// protocol Hashable: Equatable {
//    // 읽기전용 해쉬벨류 변수
//    var hashValue: Int { get }
// }
//
// protocol Equatable {
//    // lhs는 좌변, rhs는 우변을 의미한다.
//    // Self는 현재 타입을 의미한다.
//    // 좌변, 우변을 비교하고 그 결과를 Boolean으로 반환한다.
//    static func == (lhs: Self, rhs: Self) -> Bool
// }

// ### 딕셔너리 dictionary
// - 키와 값(해쉬가능한 키와 값)으로 이루어진 컬렉션
// - 키는 Hashable프로토콜을 준수해야, 값은 어떤 값이든 상관없다.
// - 딕셔너리는 Hashable한 즉, 키가 될 수 있어야만 값과 함께 구현이 될 수 있는 컬렉션
// - 딕셔너리의 키를 접근해 얻는 값은 옵셔널형태이다.
//// 딕셔너리의 정의 형태 예시)
// Dictionary<Key: Hashable, Value>

import UIKit

class ViewController: UIViewController {
    @IBOutlet private var flipCountLabel: UILabel!

    // Outlet Collection Property
    @IBOutlet private var emojiCardButtons: [UIButton]!

    // ✭ 실제 UI와 직결될 수 있는 데이터는 private 처리하는 것이 좋다.
    private lazy var game: Concentration = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)

    // * 읽기만 가능한 변수이므로 internal로 두어도 무방하다.
    var numberOfPairsOfCards: Int {
        // get만 있으므로 아래와 같이 return ~~ 방식으로 만 표현할 수 있다.
        return (emojiCardButtons.count + 1) / 2
    }

    // flipCount 또한 UI와 직결되므로, 읽기만 가능하도록 private(set) 설정을 할 수 있다.
    private(set) var flipCount: Int = 0 {
        // didSet은 값이 설정되기 직후에 실행되며, 설정되기 전 값인 oldValue에 접근할 수 있다.
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }

//        /// willSet은 값이 설정되기 직전에 실행되며, 새로 설정 된 newValue에 접근할 수 있다.
//        willSet {
//            flipCountLabel.text = "Flips: \(flipCount)"
//        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    /// * @IBAction은 Xcode에서 추가한 지시문이다. 인터페이스빌더 내 UI객체와 연결이 되어 동작한다.
    @IBAction private func emojCardPressed(_ sender: UIButton) {
        flipCount += 1 // 넘긴 횟수를 1 증가 시킨다.
        if let cardNumber = emojiCardButtons.firstIndex(of: sender) { // 선택한 카드의 인덱스를 확인
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
            print("cardNumber = \(cardNumber)")
        } else {
            print("chosen card was not in emojuCardButtons")
        }
    }

    // UI를 업데이트하면 UI와 직결되는 메서드이므로 역시 private 처리하는 것이 좋다.
    private func updateViewFromModel() {
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

    private var emojiChoices = ["👻", "🎃", "😱", "🥵", "🥶", "😭", "💀", "👽"]
    private var emoji = [Card: String]()
    private func emoji(for card: Card) -> String {
        // 왜 옵셔널이 들어갈까?? -> 딕셔너리에 없는 값일 수도 있기 때문.
        // * 딕셔너리에서 무언가 찾는다면 옵셔널을 리턴한다는 것을 명심하자.
        // 딕셔너리의 키와 값 형태를 활용해보자.
        if emoji[card] == nil, emojiChoices.count > 0 {
            // * arc4random_uniform은 부호없는 정수형만 취급한다. -> UInt32로 랩핑하면 사용 가능
            // 한번 사용한 이모티콘은 emojiChoices 배열에서 삭제한다.
            emoji[card] = emojiChoices.remove(at: emojiChoices.count.arc4Random)
        }

        return emoji[card] ?? "?"
    }
}

// 확장기능, extension의 사용 예
// extension을 통해 코드를 더욱 간결하게 구현 할 수 있다.
// extension 코드 내 여러가지 입력값에 대비한 코드처리를 했다.
extension Int {
    var arc4Random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
