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
//    - 프로토콜은 메서드에 대한 기본 구현을 제공한다.
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

// ## 다중상속
// - 프로토콜은 한번의 구현만으로 여러곳에서 일일히 정의할 필요없이 사용이 가능하다.
// - 마치 상속없이도 프로토콜을 통해 다중상속처럼 보이는 효과를 얻을 수 있는 것이다.
// - ** 그렇다면 이 프로토콜은 어디에 정의해야할까? **
//  - => ** extension protocol, 프로토콜의 익스텐션에 넣으면 된다. **
//  - 하지만 extension은 저장공간이 없기에 조금의 제약이 존재한다.

// ### Sequence 프로토콜의 extension protocol 예시
// - Sequence를 통해 사용가능 한 메서드
//  - -> contains(), forEach(), joined(separator:), min(), max(), filter(), map() and so on...
// - 실제 배열, 딕셔너리등을 사용할때 위와 같은 메서드들은 함께 자동으로 사용이 가능하다.
// - 하지만 좀더 효율적인 방법이나 기능을 구현하기 위해서 extension을 활용할 수 있다.
//// extension Sequence, extension protocol 사용 예시
//
// extension Sequence {
//    // ✭ 하나의 메서드만 구현해도 모든 다른 구현이 공유되어 얻을 수 있다는 것이 프로토콜의 장점이다.
//    func contains(_ element: Element) -> Bool { }
//    // etc...
// }

// ### 다중상속 관련 프로토콜
//    - CountableRange : 계수 가능 범위는 많은 프로토콜을 구현한다.(12 ~ 15개의 프로토콜이 존재)
//    - Sequence : makeIterator
//      - for in(수행하는 대상은 수열형태) 등 지원
//    - Collection : subscripting, index(offsetBy:), index(of:), etc...
// ex) Collection, Sequence, CountableRange...
// - 왜 이런 프로토콜이 필요할까??
//  - 배열(Array), 딕셔너리(Dictionary), Set, String들은 각각 하나의 Collection이다.
//  - 이들은 또한 Sequence의 특성을 가진다.
//  - 이들은 계수가능범위를 표현하는 indices()등의 메서드를 쓰기도 한다.

// ## 함수형 프로그래밍
// - 객체지향 프로그래밍의 진화된 형태라고도 한다.
// - 다중상속등을 보다 쉽게 통제할 수 있다.
// - 어떤 것이 어떤 작업을 하는지 증명할 수 있는 등 많은 장점이있다.
// - * 스위프트는 함수형프로그래밍, 객체지향프로그매이 등을 모두 지원한다.
// - 거의 모든 기초 프레임워크인 딕셔너리, 배열 등이 함수형 프로그래밍으로 만들어져 있다.
// - 프로토콜을 이용한 제약이나 프로토콜의 익스텐션 등은 함수형 프로그래밍을 지원한다.

// ## 문자열 String
// - 문자열 구조체와 별개로 문자(Character) 구조체가 있다.
// - 문자열은 유니코드로 이루어져있다. (C A F E -> 5개의 유니코드로 표현)
// - 문자열은 구조체이자 값 타입니다.
// - Swift에서는 문자열을 정수로 색인하지 않는다.
// - String, Array 전부 rangeReplacableCollection 프로토콜을 준수한다.
//
// ### String.Index
// - 정수 대신 다른 특수한 타입, Stirng.index를 사용하여 문자열을 색인한다.
// - startIndex, endIndex, index(of:) 등을 통해 인덱스를 얻을 수 있다.
// - 문자열(String)의 배열(Array)은 곧 그 문자(Character)들의 배열이다.
// let characterArray = Array(str) // Array<Character>
// print(characterArray[0]) // Array형으로 변환하면 String.Index 대신 정수값으로 접근이 가능해진다.
//
//// String.Index 사용 예시)
// let pizzaJoint = "cafe pesto"
// let firstCharacterIndex = pizzaJoint.startIndex // of type String.Index
// let fourthCharacterIndex = pizzaJoint.index(firstCharacterIndex, offsetBy: 3)
// let fourthCharater = pizzaJoint[fourthCharacterIndex] // pizzaJoint 네번째 문자열인 'e'
//
//// " "(공백) 이 없다면 인덱스 반환값이 nil일 수도 있으므로 if let 을 사용했다.
// if let firstSpace = pizzaJoint.index(of: " ") {
//    let secondWordIndex = pizzaJoint.index(firstSpace, offsetBy: 1) // 공백으로부터 1칸 뒷쪽의 문자 인덱스를 반환
//    let secondWord = pizzaJoint[secondWordIndex..<pizzaJoint.endIndex] // "pesto"
// }
// - ..< 등으로 String.Index의 영역을 지정할 수 있다.
//
// ### Range
// - Range는 제네릭 타입으로 꼭 Int형으로만 범위를 설정할 필요가 없다. ex) String.Index의 사용...
//
// ### String 제공 기능
//
// - **components**
//// components 사용 예)
// pizzaJoint.components(separatedBy: " ")[1] // pizzaJoint를 공백 단위로 쪼갠 뒤 그 중 (인덱스 1)2번째의 값을 반환한다.
//
// - **insert**
//// insert 사용 예)
// var s = pizzaJoint // String은 구조체이자 값타입이므로 값복사를 한다.
// s.insert(contentOf: " foo", at: s.index(of: " ")!) // "cafe foo pesto" or Crashed(because of '!')
//
// - **replaceSubrange**
//// replaceSubrange 사용 예시
//// ..< 로 좌변을 구체적으로 명시 안해도 스위프트는 영리하게 startIndex로 인식하여 계산한다.
// s.replaceSubrange(..<s.endIndex, with: "new Contents") // Change Strings with "new Contents"
// - **remove**
//// remove 사용 예시
// emojiChoices.remove(at: randomStringIndex)

// ### NSAttributedString
// - 각각의 문자가 속성을 지닌 문자열
// - 여러문자의 범위 내에서 하나의 딕셔너리를 사용한다.
// - 속정 문자별로 다양한 폰트나 문자 색상등을 부여하는 등 UI라벨 글자설정, UI버튼 설정 등에 활용가능

// ## Any
// - 어떤 구조체나 클래스던 모두 들어갈 수 있음을 의미
// - 강타입의 Swift답지 않은 표현이다.
// - 절대 자료구조에 Any를 쓰지 말자

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

    // Character Array 상태
    // private var emojiChoices = ["👻", "🎃", "😱", "🥵", "🥶", "😭", "💀", "👽"]

    // String 상태
    private var emojiChoices = "👻🎃😱🥵🥶😭💀👽"
    private var emoji = [Card: String]()

    private func emoji(for card: Card) -> String {
        // 왜 옵셔널이 들어갈까?? -> 딕셔너리에 없는 값일 수도 있기 때문.
        // * 딕셔너리에서 무언가 찾는다면 옵셔널을 리턴한다는 것을 명심하자.
        // 딕셔너리의 키와 값 형태를 활용해보자.
        if emoji[card] == nil, emojiChoices.count > 0 {
            // * arc4random_uniform은 부호없는 정수형만 취급한다. -> UInt32로 랩핑하면 사용 가능
            // 한번 사용한 이모티콘은 emojiChoices 배열에서 삭제한다.
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4Random)
            emoji[card] = String(emojiChoices.remove(at: randomStringIndex))
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
