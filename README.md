# iOS With Stanford
iOS Study with Stanford

<br>
<br>

# Lecture 1) 
## 기본 Xcode 사용법 및 개발
 * 개발자 문서 내 자주사용하는 클래스의 OverView는 전부 읽어보도록 하자.
 * 프로젝트를 만들때 필요한 것 : 프로젝트명, 팀명, 기관명, 기관식별자
 
### ➣  Xcode Interface 요소
 - 네비게이터 : 좌측 창 영역은 네비게이터라고 한다. 검색/디버깅/파일목록 등을 볼 수 있다. (CMD+0)
 - 유틸리티창 : 우측 창 영역 (OPT+CMD+0)
 - 콘솔창 : 디버깅 출력 등에 사용하는 하단창 (CMD+SHIFT+Y)
 - Simulator : 실 기기로 무/유선 디버깅이 되지만 시뮬레이터를 통한 디버깅도 지원하고 있다.
 - 인터페이스빌더 : InterfaceBuilder, 스토리보드 등으로 뷰요소를 시각적으로 구성할 수 있으며 IBOutlet, IBAction 등으로 뷰 ~ 컨트롤러 간 소통할 수 있게 해준다.

### ➣  1강 용어정리
* 인터페이스빌더 내 확대/축소 : Alt+Scroll, 핀치동작으로 가능하다.
* 메서드의 인자이름 지정 방법 : withEmoji emoji 처럼 외/내부 인자이름을 설명할 수 있다. 물론 외/내부 인자이름 동일하게 emogi 하나만 지정할 수도 있다.

### ➣  1강 구현결과
<div>
 <img width="250" src="https://user-images.githubusercontent.com/4410021/63637175-66a4cc80-c6b4-11e9-840f-70017918c1f0.png">
</div>

<br>

## 총 평
- Xcode 기본 인터페이스, 집중력게임 기본로직 개발

<br>
<br>

# Lecture 2) 
## MVC패턴 : Medel + View + Controller 의 모델-뷰-컨트롤러로 구성하는 디자인패턴 기법
 
 ### ➣  Controller : UIViewController 등의 컨트롤러 요소
 - 모델과 원하는대로 얘기 하며 사용자에게 보여져야 할 데이터를 받는다.(특히 공개적인 데이터와는 무제한적으로 대화가능)
 - Outlet을 통해 view와 소통한다.
 
 ### ➣  View : 스토리보드... UILabel, UIImageView, UIView... and so on...
 - 모델과 절대 소통 불가능
 - 뷰는 컨트롤러와 블라인드상태로 소통해야한다. 뷰는 컨트롤러가 집중력게임 컨트롤러인이 어떤 컨트롤러인지 알지 못한다. 소통 시 컨트롤러에서 뷰에 대한 정의를 구조적으로 지정하고 교류할 수 있다.(타겟메서드, 델리게이트, 데이터소스 프로토콜 등...)
 ex) 컨트롤러에 타겟 메서드를 지정 후 뷰가 동작 시 메서드가 동작하는 방식으로 소통 가능
 ex) 스크롤뷰 등의 did, will, should Delegate 메서드 등을 컨트롤러에서 등록하여 사용할 수 있다.
 ex) 테이블 뷰 등의 스트롤 시 셀 갯수 등을 UITableViewDataSource Protocol로 지정하고 상황에 따라 필요한 만큼의 데이터만 모델에 요청하여 유저에게 보여줄 수 있다.
 ### ➣  Model : 뷰에 표현 될 데이터모델
 - View와 절대 소통 불가능
 - Contorller에 사용자에게 보여져야 할 데이터를 제공한다.
 - Controller와 직접적으로는 소통하지 못한다.
 - Notification, KVO(Key Value Observing) 방식으로 컨트롤러와 소통할 수 있다. -> 라디오방송국으로 생각하면 이해하기 좋다.

### ➣  클래스가 아닌 struct를 사용하는 이유??
 - 사실 스위프트의 클래스와 구조체는 대부분이 유사하다. 하지만 두가지 큰 차이가 있다.
   - 구조체는 값타입이다. vs 클래스는 참조타입이다.
   - 구조체는 상속성을 가지고 있지않다. vs 클래스는 상속성을 가지고 있다.
   - 구조체는 모든 멤버변수를 초기화할 수 있는 공짜 이니셜라이저가 존재한다. vs 클래스는 이러한 공짜 이니셜라이저가 존재하지 않는다.

### ➣  2강 용어정리 
 * API란? : Application Programming Interface(인스턴스 리스트)의 약자
 * lazy : lazy를 사용하면 실제 사용하기 전까진 초기화 하지 않는다.누군가 game을 사용하려 할때 비로소 초기화 된다.
 lazy를 사용하면 프로퍼티 옵저버(Property Obserber, 프로퍼티 감시자)로서의 역할은 불가능하다.
 * 배열.indices() : 계수가능 범위를 배열로 리턴해준다.
   - indices 사용 예 : for index in emojiCardButtons.indices {}
 * 배열.shuffle() : 컬렉션 요소를 랜덤하게 섞어준다.
   - shuffle 사용 예 : emojiCardButtons.shuffle()

### ➣  2강 구현결과
<div>
 <img width="250" src="https://user-images.githubusercontent.com/4410021/63637283-f26b2880-c6b5-11e9-9967-775e9b80fc14.png">
 <img width="250" src="https://user-images.githubusercontent.com/4410021/63637222-27c34680-c6b5-11e9-9af0-6935c3027674.png">
 <img width="250" src="https://user-images.githubusercontent.com/4410021/63637223-298d0a00-c6b5-11e9-9358-420d8d4e3675.png">
</div>

<br>

## 총 평
- MVC패턴의 개념 이해
- 집중력게임의 MVC 적용연습

<br>
<br>

# Lecture 3) 
## Swift 기초문법

### **앞서 강의에서 배운 내용 간략정리**
- 타겟/액션, IBOutlet, IBOutletCollection
- 메서드와 프로퍼티 사용
- 프로퍼티옵저버(didSet, willSet)
- 배열 Array<Element>, [Element]
- 딕셔너리 Dictionary<Key, Value> -> 해쉬타입
- for in 반복문 : 시퀀스(sequence) 성질이 있는 요소 순회탐색에 사용 가능
- 문자열, 배열, 딕셔너리, Set 등
- MVC(Model-View-Controller) 패턴
- 값타입 Struct, 참조타입 class
- 초기화함수, initializers
- 실제 실행 시 초기화 되는 lazy 프로퍼티(프로퍼티옵저버 역할 불가능)
- 타입변환 
  - ex) UInt32(Int)
- nil이 될 수도 있는 옵셔널, 옵셔널바인딩방법 "if let"
 
* **오토레이아웃을 적용하지 않은 집중력게임앱 가로모드 실행화면**
<div>
 <img width="500" src="https://user-images.githubusercontent.com/4410021/63637755-88ee1880-c6bb-11e9-90cb-7c47b704ebbf.png">
</div>

- 지금까지 만든 집중력게임, 세로모드에선 문제 없어보이지만.. 가로모드가 된다면?? 
  - 컨텐츠가 전부 보이지 않는 어설픈 레이아웃 상태...
  - ✭ 문제 해결을 위해서 오토레이아웃 구현이 필요하다.

 ### UIStackView
 - 다양한 UI객체를 묶어 관리할 수 있다.
 - 여러개의 UI를 선택 
   - -> 인터페이스 빌더 하단 embed in View 로 스택뷰 처리가능
 - 스택뷰 프로퍼티
 - distribution : 스택뷰 내 서브뷰의 배치 설정
 - alignment : 스택뷰 정렬 기준 설정

 ### Stride(from:,through:,by:)
 - Float 등의 부동소수점을 반복문으로 돌릴 수 없을까?
 - Swift에서는 stride 전역함수를 이용하여 구현할 수 있다.
 - 부동소수점 이외에 문자열의 인수 등도 셀 수 있다.

 ~~~ swift
 // for (i = 0.5; i<=15.25; i+=0.3) 과 같은 동작의 stride 사용 예
 for i in stride(from: 0.5, through: 15.25, by: 0.3) {

 }
 ~~~
 
 ### Tuple
 - 튜플은 무엇일까? 
   - 메소드나 변수가 없는 소형 구조체, 값만 들어가 있는 다른 언어의 구조체와 유사하다.
 - 가볍기때문에 한 줄만으로 표현할 수 있다.
 - 여러 요소의 이름을 유연하게 설정할 수 있다.
 - 함수 내에서 하나 이상의 값을 리턴할때 유용하다.
    - ex) (weight: Double, height: Double)로 신장+체중 리턴
 ~~~ swift
 // Tuple 사용 예)
 // tuple의 타입이 Tuple이 된다.
 let tuple: (String, Int, Double) = ("Hello", 5, 9.84) 
 ~~~
 
 ~~~ swift
 // Tuple 사용 예 2)
 let tuple2: (w: String, i: Int, v: Double) = ("Hello", 5, 9.85)
 print(tuple2.w) // prints "Hello"
 print(tuple2.i) // prints 5
 print(tuple2.v) // prints 9.85
 ~~~

 ### 계산프로퍼티 (Computed Properties)
 - 쓰기, 읽기 시 기 지정한 get, set 대로 계산되는 프로퍼티
 - 프로퍼티감지자(property Observer)와 혼용해서 사용할 수 없다.
 - 저장프로퍼티와 달리 쓰기/읽기 시 마다 set, get 블럭 내용을 신행된다.
 - get과 달리 set은 필수 구현요소가 아니다.
    - -> 읽기/쓰기(get/set) or 읽기(get) 상태로 구현 가능
    - get 만 사용한다면 get 명시 없이 return ~~~~ 로 구현할 수도 있다.
 - 상황에 따라 계산되는 속성으로 코드는 훨씬 간결해지고, 직관적이게 된다. 일어난 상황에따라 반응하기 때문이다.
 - 특정 행위를 할때마다 변경 혹은 읽기가 필요한 경우 유용할 수 있다.
 - **저장프로퍼티, 계산프로퍼티의 특성을 살릴 만한 상황을 잘 판단하여 사용하는 것이 좋다.**
    - ex) indexOfOneAndOnlyFaceUpCard: Int? -> 카드를 뒤집을때 카드의 상태에 따라 다른 처리가 필요한 변수
    
 ~~~ swift 
 // 계산프로퍼티 사용 예)
 var foo: Double {
    get {
        // return the calculated value of foo
        return 계산된 foo의 값
    }

    set(newValue) {
        // do comething based on the fact that foo has changed to newValue
        // 새로운 값으로 변경이 됄 때 해당 블럭이 실행 된다.
    }
 }
 ~~~

<br>

## **접근제어 Access Control**
 - 외부로부터 코드 내부를 접근하는 기준을 지정할 수 있다.
### - open : 해당 프레임워크 이외의 모듈에서 불러올 뿐만 아니라 할당, 서브클래싱, 오버라이딩 까지 전부 가능하다. 즉 완전개방 상태이다.
### - public : 해당 프레임워크 이외의 모듈에서도 사용자가 불러와 사용이 가능하다.
### - Internal : default 접근제어, Internal일 경우, 모듈 내에 서는 지정한 객체나 코드이던 해당 메서드, 프로퍼티에 접근이 가능하다.
### - Private : 다른 객체로부터 불러올 수 없다. 해당 지정된 블록 내에서만 접근 가능, 접근 비공개상태
### - Private(set) : 다른 객체로부터 불려질 수 있다. 읽기 접근은 되지만 할당은 불가능 하다. 지정 된 내부에서만 할당 가능.
### - fileprivate : 파일 이내에서는 지정 된 메서드, 프로퍼티에 대해서 접근 및 할당 가능

<br>

## 확장 Extension
 - 확장은 iOS에서 매우 강력한 도구이다. 마치 "조심스럽게 다루는 무기"와 같다.
 - extension 객체이름 {} 과 같은 식으로 사용할 수 있다.
 - extension은 저장공간이 있는 변수는 아니다.
 - extension은 간편하여 쉽게 남용 될 수 있다. 그러므로 확장 사용 시 불필요한 기능인지 고려할 필요가 있다.

<br>

## 옵셔널
- Optional "옵셔널도 enum이다."
- nil일 수도 있음을 의미. The Enumeration
- 다음주에 볼 주제, 옵셔널.
- 옵셔널의 정의 형태) enum + 배열과 같은 제네릭 형태로 되어있다.

~~~ swift
// Optional의 코드 형태
 enum Optional<T> {
    case none // 설정되어있지 않은 상태
    case some(<T>) // 그 이외 데이터타입 'T'와 관련된 상태
 }
~~~

- 옵셔널의 구조가 매우 단순해 보이지만, Optional은 다른 타입들은 가지고 있지 않은 많은 특별한 구문(syntax)들을 갖고 있다.

~~~ swift
// 만약 값이 없는 옵셔널을 강제바인딩 '!' 처리 한다면???)
 let hello: String?
 print(hello!)
~~~

~~~ swift
 // hello 상수에 대한 동작과정
 switch hello {
    case .none: // 예외 발생(강제 바인딩을 했으나 값이 없으므로 오류발생), 안전한 바인딩 시 해당 상황 시 옵셔널 바인딩의 else 부분이 실행 되고 Crash를 면할 수 있다.
    case .some: // 만약 강제 바인딩 시 값이 존재했다면 오류없이 해당 데이터(연동자료)를 출력 했을 것이다.
 }
 ~~~

### ➣  옵셔널 체이닝
 - 옵셔널 체이닝은 수차례의 옵셔널 검사를 하며 값을 접근하는 방법이다.

~~~ swift
// 옵셔널 체이닝 사용 예시)
// 전부 이상없이 접근이 되었다면 z를 리턴한다.
// 만약 x, foo(), bar를 접근하며 어느 하나라도 값이 nil(case .none)이라면 해당 옵셔널 체이닝을 빠져나가 nil을 리턴한다.
 let opt = x?.foo()?.bar?.z
~~~

<br> 

## ARC (Automatic Reference Counting)
 - iOS의 자동 참조할당 해제 방식
 - ARC가 0 이되면 Heap에서 빼내서 할당을 해제한다.
 - strong, weak, unowned 등의 참조 옵션이 존재한다.

### ➣  Strong
- 참조카운팅의 기본 설정값.
- strong으로 설정하고 있는 한 해당 객체는 힙 내에 계속 유지된다.

### ➣  weak
- weak은 옵셔널 포인터로 참조타입을 가리킨다.
- 힙 내의 어떤것을 가리키고 있지만, 흥미가 있어야만 사용되는 것
- 아울렛, 델리게이트 등에 사용될 수 있다. 그 외에에는 사용을 안하는 편이다.

### ➣  unowned
- "만약 내가 문제가 있으면 오류를 발생시켜라."
   - 반드시 nil이 아니라고 판단될때 사용해야 문제가 없다.
- 참조순환(메모리 사이클)을 방지하기 위해 사용한다.
   - 클로저를 사용하면 캡쳐링 등의 참조순환 문제가 발생할 수 있는데 이를 방지하기 위해 사용하곤 한다.
- 매우 위험한 참조카운팅 방식
- 매우 드물게 사용한다.

<br>

## Swift 앱개발에 사용되는 자료구조
## Class, Struct, Enum, Protocol

## 클래스 Class
- 클래스는 참조타입, 상속을 지원한다.
- 참조타입으로서 힙(Heap)영역에 존재하게 된다.
- 클래스 등의 참조계산 방식은 앞서 언급한 ARC(Automatic Refernce Counting)로 동작한다.

## 구조체 Struct
- 구조체는 값타입, 상속을 지원하지 않는다.
- 구조체 종류
  - 배열, 딕셔너리, 문자열, 문자, 정수형 ,Double, UInt32 등... 많다.

## 열거형 Enum
- 타입의 일종, 데이터 구조 타입인 enum, struct, class 중 하나인 열거형.
- struct, class와 비슷하다.
  - 그 중 구조체(struct)와 동일한 값 타입이다.
- 메서드, 변수를 가질 수 있지만 저장공간을 가지지는 않는다.
  - enum의 저장공간은 연동자료들 각각에 대해서만 존재한다. 그러므로 enum의 값들은 계산된 변수만을 가질 수 있다.
    - enum의 연동자료 이외에 대한 저장공간은 존재하지 않는다.
- swift enum은 다른 언어의 열거형과 흡사하다. 하지만...
- **다른 언어에 비해 swift의 enum은 매우 강력하다.**
   - enum 각각의 케이스들이 연동된 데이터 혹은 값을 가질 수 있기 때문이다.
- * 타입 추론이 가능하지만 좌측 혹은 우측 어느 한곳에는 해당 타입을 명시해주어야 추론이 가능하다.

~~~ swift
// swift enum의 사용 예시)
enum FastFoodMenuItem {
   case hamburger(numberOfPatties,: Int)
   case fries(size: FryOrderSize)
   case drink(String, ounces: Int)
   case cookie
}
~~~

- enum 값을 셋팅 할때 관련 데이터를 반드시 제공해야 한다.
~~~ swift
let menuItem: FastFoodMenuItem = FastFoodMenuItem.hamburger(patties: 2)
var otherItem: FastFoodMenuItem = FastFoodMenuItem.cookie
~~~
 
- enum은 등호(==)대신 switch 문을 통해 비교한다.
- enum switch 문 내 case문에서 ".값" 만 명시해도 값 추론이 가능하다.
- case 내 두줄 이상의 코드도 실행 가능하다.
 
### ➣  break
 - switch 문 내에서 특정 분기 시 아무것도 실행하고 싶지 않다면, break문을 사용하면 된다.
 ~~~ swift
 var menuItem = FastFoodMenuItem.hamburger(patties: 2)
    switch menuItem {
        case .hamburger: break // 아무것도 실행 하기 싫으면 이렇게 break문 사용하면 된다.
        case .fires: print("fries")
        case .drink: print("drinK")
        case .cookie: print("cookie")
    }
~~~

### ➣  default:
- 만약 특정 케이스 이외의 케이스를 한번에 묶어 구분하려면 case로 default:를 사용할 수 있다.

### ➣  case let
- 만약 case 내 정보에 따른 연동자료를 얻고 싶다면 case문 내에 let을 활용할 수 있다.
- let 변수 이름은 enum 요소와 무관하게 지정해도 무방하다.

~~~ swift
// case let 사용 예시)
// drink에 대한 특정 값 부여에 따른 연동자료를 얻을 수 있다.
 var menuItem = FastFoodMenuItem.drink("Coke", ounces: 32)
 switch menuItem {
     case . hamburger(let pattyCount): print("a burger with \(pattyCount) patties!")
     case .fries(let size): print("a \(size) order of fries!")
     case .drink(let brand, let ounces): print("a \(ounces)oz \(brand)")
     case .cookie: print("a cookie!")
 }
~~~

### ➣  switch self 
- enum 내에 switch self 를 구성하여 case에 따른 연동자료를 반환시길 수 있다.
- enum 내부적으로 self를 변경 시킬 수도 있다.
  - 단, 값타입인 enum 타입 내에서는 mutating 속성이 부여되어 있어야 내부 쓰기가 가능
  
~~~ swift
// switch self 사용 예시)
 enum FastFoodMenuItem {
    ...
    // switch self 사용예시 1)
    func isIncludedInSpecialOrder(number: Int) -> Bool {
        switch self {
            case . hamburger(let pattyCount): return pattyCount == number
            case .fries, .cookie: return true // 음료수와 쿠키를 항상 스페셜 주문(true)이다.
            case .drink(_, let ounces): return ounces == 16 // & 16oz...
                // * ',' 반점을 사용해 몇 개의 케이스 경우를 묶어줄 수 있다.
        }
    }
 

    // switch self 사용예시 2)
    mutating func switchToBeingACookie() {
        // enum 객체의 self를 변경할 수 있다.
        self = .cookie
    }
 }
~~~

## 프로토콜 Protocol
 - 문자열, 배열 등 많은 것들이 프로토콜을 사용하며 이들의 기초가 된다.

<br>

### ➣  3강 용어정리
 * Safe Area : 안전영역 즉, 스크린 주변의 다른 UI와 겹치지 않고 배치할 수 있는 영역
 * Assertion : 어떤 것이 참임을 단언하는 함수
   - 만약 Assertion을 통해 단언한 내용이 성립하지 않으면 디버깅단계에서 프로그램 에러를 발생시킨다.
   - 앱스토어 배포단계에서 Assertion은 무관하게 취급한다.
   - API를 보호하기 좋은 수단이다.

### ➣  3강 구현결과 

<div>
 <img width="400" src="https://user-images.githubusercontent.com/4410021/63647522-54329d80-c75d-11e9-93ce-7be2acb2d7a6.png">
 <p><img width="250" src="https://user-images.githubusercontent.com/4410021/63647523-54329d80-c75d-11e9-8774-47b6ab64e86b.png">
</div>
<br>

## 총 평
- Swift 핵심 기초문법 훑어보기
- 집중력게임(Concentratino Game)의 오토레이아웃 적용
- 집중력게임 내 계산프로퍼티, extension 적용을 통한 코드 간결화


