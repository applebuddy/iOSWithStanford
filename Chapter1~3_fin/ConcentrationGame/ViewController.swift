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
//
// ### UIStackView
// - 다양한 UI객체를 묶어 관리할 수 있다.
// - 여러개의 UI를 선택 -> 인터페이스 빌더 하단 embed in View 로 스택뷰 처리가능
// - 스택뷰 프로퍼티
// - distribution : 스택뷰 내 서브뷰의 배치 설정
// - alignment : 스택뷰 정렬 기준 설정
//
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
//
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
//
// ### 계산프로퍼티 (Computed Properties)
// - 쓰기, 읽기 시 기 지정한 get, set 대로 계산되는 프로퍼티
// - 저장프로퍼티와 달리 쓰기, 읽기 시 마다 set, get 블럭 내용을 신행된다.
// - get과 달리 set은 필수 구현요소가 아니다.
//    - -> 읽기/쓰기(get/set) or 읽기(get) 상태로 구현 가능
//    - get 만 사용한다면 get 명시 없이 return ~~~~ 로 구현할 수도 있다.
// - 상황에 따라 계산되는 속성으로 코드는 훨씬 간결해지고, 직관적이게 된다. 일어난 상황에따라 반응하기 때문이다.
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
//
// ## **접근제어 Access Control**
// - 외부로부터 코드 내부를 접근하는 기준을 지정할 수 있다.
// ### open : 해당 프레임워크 이외의 모듈에서 불러올 뿐만 아니라 할당, 서브클래싱, 오버라이딩 까지 전부 가능하다. 즉 완전개방 상태이다.
// ### public : 해당 프레임워크 이외의 모듈에서도 사용자가 불러와 사용이 가능하다.
// ### Internal : default 접근제어, Internal일 경우, 모듈 내에 서는 지정한 객체나 코드이던 해당 메서드, 프로퍼티에 접근이 가능하다.
// ### Private : 다른 객체로부터 불러올 수 없다. 해당 지정된 블록 내에서만 접근 가능, 접근 비공개상태
// ### Private(set) : 다른 객체로부터 불려질 수 있다. 읽기 접근은 되지만 할당은 불가능 하다. 지정 된 내부에서만 할당 가능.
// ### pileprivate : 파일 이내에서는 지정 된 메서드, 프로퍼티에 대해서 접근 및 할당 가능
//
// ## 확장 Extension
// - 확장은 iOS에서 매우 강력한 도구이다. 마치 조심스럽게 다루는 무기와 같다.
// - extension 객체이름 {} 과 같은 식으로 사용할 수 있다.
// - extension은 저장공간이 있는 변수는 아니다.
// - extension은 쉽게 남용 될 수 있다. 확장 사용 시 불필요한 기능인지 고려할 필요가 있다.
//
//// ## 옵셔널
////- Optional "옵셔널도 enum이다."
////- nil일 수도 있음을 의미. The Enumeration
////- 다음주에 볼 주제, 옵셔널.
////- 옵셔널의 정의 형태) enum +  배열과 같은 제네릭 형태로 되어있다.
// enum Optional<T> {
//    case none // 설정되어있지 않은 상태
//    case some(<T>) // 그 이외 데이터타입 'T'와 관련된 상태
// }
////- 구조가 매우 단순해 보이지만, Optional은 다른 타입들은 가지고 있지 않은 많은 특별한 구문(syntax)들을 갖고 있다.
////- 만약 값이 없는 옵셔널을 강제바인딩 '!' 처리 한다면???)
// let hello: String?
// print(hello!)
// switch hello {
// case .none: // 예외 발생(강제 바인딩을 했으나 값이 없으므로 오류발생), 안전한 바인딩 시 해당 상황 시 옵셔널 바인딩의 else 부분이 실행 되고 Crash를 면할 수 있다.
// case .some: // 만약 강제 바인딩 시 값이 존재했다면 오류없이 해당 데이터(연동자료)를 출력 했을 것이다.
// }
//
// ### 옵셔널 체이닝
// - 옵셔널 체이닝은 수차례의 옵셔널 검사를 하며 값을 접근하는 방법이다.
// - 옵셔널 체이닝 사용 예시)
//
////전부 이상없이 접근이 되었다면 z를 리턴한다.
//// 만약 x, foo(), bar를 접근하며 어느 하나라도 값이 nil(case .none)이라면 해당 옵셔널 체이닝을 빠져나가 nil을 리턴한다.
// let opt = x?.foo()?.bar?.z
//
// ## ARC (Automatic Reference Counting)
// - iOS의 자동 참조할당 해제 방식
// - ARC가 0 이되면 Heap에서 빼내서 할당을 해제한다.
// - strong, weak 등의 참조 옵션이 존재한다.
//
//    ### Strong
//    - 참조카운팅의 기본 설정값.
//    - strong으로 설정하고 있는 한 해당 객체는 힙 내에 계속 사용된다.
//
// ### weak
// - 힙 내의 어떤것을 가리키고 있지만, 흥미가 있어야만 사용되는 것
// - weak은 옵셔널 포인터로 참조타입을 가리킨다.
// - 아울렛, 델리게이트 등에 사용될 수 있다. 그 외에에는 사용을 안하는 편이다.
//
// ### unowned
// - "만약 내가 문제가 있으면 오류를 발생시켜라."
//    - 반드시 nil이 아니라고 판단될때 사용해야 문제가 없다.
// - 참조순환(메모리 사이클)을 방지하기 위해 사용한다.
//    - 클로저를 사용하면 캡쳐링 등의 참조순환 문제가 발생할 수 있는데 이를 방지하기 위해 사용하곤 한다.
// - 매우 위험한 참조카운팅 방식
// - 매우 드물게 사용한다.
//
// ## Swift 앱개발에 사용되는 자료구조
// ## Class, Struct, Enum, Protocol
//
// ### 클래스 Class
// - 클래스는 참조타입, 상속을 지원한다.
// - 참조타입으로서 힙(Heap)영역에 존재하게 된다.
// - 클래스 등의 참조계산 방식은 ARC(Automatic Refernce Counting)로 동작한다.
//
// ### 구조체 Struct
// - 구조체는 값타입, 상속을 지원하지 않는다.
// - 배열, 딕셔너리, 문자열, 문자, 정수형 ,Double, UInt32 등...#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//
//// ## 열거형 Enum
//
// - 타입의 일종, 타입 종류로는 enum, struct, class 가 있다.
// - struct, class와 비슷하다.
// - 메서드, 변수를 가질 수 있지만 저장공간을 가지지는 않는다.
// - enum의 저장공간은 연동자료들 각각에 대해서만 존재한다. 그러므로 enum의 값들은 계산된 변수만을 가질 수 있다.
//    -enum의 연동자료 이외에 대한 저장공간은 존재하지 않는다.
// - 구조체(struct)와 동일한 값 타입이다.
// - swift enum은 다른 언어의 열거형과 흡사하다. 하지만...
// - **다른 언어에 비해 swift의 enum은 매우 강력하다.**
//    - enum 각각의 케이스들이 연동된 데이터 혹은 값을 가질 수 있기 때문이다.
// - * 타입 추론이 가능하지만 좌측 혹은 우측 어느 한곳에는 해당 타입을 명시해주어야 추론이 가능하다.
// - swift enum의 사용 예시)
// enum FastFoodMenuItem {
//    case hamburger(numberOfPatties,: Int)
//    case fries(size: FryOrderSize)
//    case drink(String, ounces: Int)
//    case cookie
// }
// - enum 값을 셋팅 한데 관련 데이터를 반드시 제공해야 한다.
// let menuItem: FastFoodMenuItem = FastFoodMenuItem.hamburger(patties: 2)
// var otherItem: FastFoodMenuItem = FastFoodMenuItem.cookie
// - enum은 등호대신 switch 문을 통해 비교한다.
// - enum switch 문 내 case문에서 ".값" 만 명시해도 값 추론이 가능하다.
// - case 내 두줄 이상의 코드도 실행 가능하다.
// ### break
// - switch 문 내에서 특정 분기 시 아무것도 실행하고 싶지 않다면, break문을 사용하면 된다.menuItem
// var menuItem = FastFoodMenuItem.hamburger(patties: 2)
//    switch menuItem {
//        case .hamburger: break // 아무것도 실행 하기 싫으면 이렇게 break문 사용하면 된다.
//        case .fires: print("fries")
//        case .drink: print("drinK")
//        case .cookie: print("cookie")
//    }
// ### default:
// - 만약 특정 케이스 이외의 케이스를 한번에 묶어 구분하려면 default:를 사용할 수 있다.
//
// ### case let
// - 만약 case 내 정보에 따른 연동자료를 얻고 싶다면 case문 내에 let을 활용할 수 있다.
// - let 변수 이름은 enum 요소와 무관하게 지정해도 무방하다.
// - case let 사용 예시)
//// drink에 대한 특정 값 부여에 따른 연동자료를 얻을 수 있다.
// var menuItem = FastFoodMenuItem.drink("Coke", ounces: 32)
// switch menuItem {
// case . hamburger(let pattyCount): print("a burger with \(pattyCount) patties!")
// case .fries(let size): print("a \(size) order of fries!")
// case .drink(let brand, let ounces): print("a \(ounces)oz \(brand)")
// case .cookie: print("a cookie!")
// }
//
////### switch self
////- enum 내에 switch self 를 구성하여 case에 따른 연동자료를 반환시길 수 있다.
////- enum 내부적으로 self를 변경 시킬 수도 있다.
////    * 단, 값타입인 enum 타입 내에서는 mutating 속성이 부여되어 있어야 내부 쓰기가 가능
////- switch self 사용 예시)
// enum FastFoodMenuItem {
//    ...
//    // switch self 사용예시 1)
//    func isIncludedInSpecialOrder(number: Int) -> Bool {
//        switch self {
//        case . hamburger(let pattyCount): return pattyCount == number
//        case .fries, .cookie: return true // 음료수와 쿠키를 항상 스페셜 주문(true)이다.
//        case .drink(_, let ounces): return ounces == 16 // & 16oz...
//            // * ',' 반점을 사용해 몇 개의 케이스 경우를 묶어줄 수 있다.
//        }
//    }
//
//    // switch self 사용예시 2)
//    mutating func switchToBeingACookie() {
//        // enum 객체의 self를 변경할 수 있다.
//        self = .cookie
//    }
// }
//
// ### 프로토콜 Protocol
// - 문자열, 배열 등 많은 것들이 프로토콜을 사용하며 이들의 기초가 된다.
//
// ### 3강 용어정리
// * Safe Area : 안전영역 즉, 스크린 주변의 다른 UI와 겹치지 않고 배치할 수 있는 영역
// * Assertion : 어떤 것이 참임을 단언하는 함수
// - 만약 단언한 내용이 성립하지 않으면 앱스토어 배포단계에서는 무관하나, 디버깅단계에서 프로그램 에러를 발생시킨다.
// - API를 보호하기 좋은 수단이다.

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
    private var emoji = [Int: String]()
    private func emoji(for card: Card) -> String {
        // 왜 옵셔널이 들어갈까?? -> 딕셔너리에 없는 값일 수도 있기 때문.
        // * 딕셔너리에서 무언가 찾는다면 옵셔널을 리턴한다는 것을 명심하자.
        // 이모지가 셋팅 안되있고, 선택
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            // * arc4random_uniform은 부호없는 정수형만 취급한다. -> UInt32로 랩핑하면 사용 가능
            // extension 으로 해당 랜덤상수 생성 메서드를 정의했기에 필요가 없어졌다. (deprecated...)
//            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count - 1)))
            // 한번 사용한 이모티콘은 emojiChoices 배열에서 삭제한다.
            emoji[card.identifier] = emojiChoices.remove(at: emojiChoices.count.arc4Random)
        }

        return emoji[card.identifier] ?? "?"
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
