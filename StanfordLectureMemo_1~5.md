# iOS With Stanford
iOS Study with Stanford Lecture Study 1~5

<br>
<br>

# 목차
## [Lecture 1](https://github.com/applebuddy/iOSWithStanford/blob/master/StanfordLectureMemo_1~5.md#lecture-1-1)
- **기본 Xcode 사용법 & 개발 준비**
## [Lecture 2](https://github.com/applebuddy/iOSWithStanford/blob/master/StanfordLectureMemo_1~5.md#lecture-2-1)
- **MVC(Model-View-Controller)패턴** 개념
- **클래스(Class) vs 구조체(Struct)**
## [Lecture 3](https://github.com/applebuddy/iOSWithStanford/blob/master/StanfordLectureMemo_1~5.md#lecture-3-1)
- **오토레이아웃(AutoLayout)**
- **Swift 핵심 기초문법**
- **Swift 핵심 자료구조**
  - **Struct, Class, Enum, Protocol**
- 확장기능, extension 
## [Lecture 4](https://github.com/applebuddy/iOSWithStanford/blob/master/StanfordLectureMemo_1~5.md#lecture-4-1)
- **Protocol의 역할, 사용방법**
- **Closure의 역할, 사용방법**
- **클래스(Class) vs 구조체(Struct)** (2)
- **Extension, String**의 활용
- **MVC Delegation패턴의 작동방식, 적용 예**
## [Lecture 5](https://github.com/applebuddy/iOSWithStanford/blob/master/StanfordLectureMemo_1~5.md#lecture-5-1)
- **Any & AnyObject**
- **throws, try/do-catch 에러처리**
- **UIView**
  
  - 초기화 방법, 프로퍼티, 뷰 그리기
- **Core Graphics**
  
  - **UIImage, NSAttributedString, UIFont**...
- 열거형을 활용한 카드 덱 출력 데모

  

<br>
<br>
<br>

# Lecture 1) 
## ♣︎ 기본 Xcode 사용법 및 개발
 * 개발자 문서 내 자주사용하는 클래스의 OverView는 전부 읽어보도록 하자.
 * 프로젝트를 만들때 필요한 것 : 프로젝트명, 팀명, 기관명, 기관식별자

### ➣  Xcode Interface 요소
 - 네비게이터 : 좌측 창 영역은 네비게이터라고 한다. 검색/디버깅/파일목록 등을 볼 수 있다. (CMD+0)
 - 유틸리티창 : 우측 창 영역 (OPT+CMD+0)
 - 콘솔창 : 디버깅 출력 등에 사용하는 하단창 (CMD+SHIFT+Y)
 - 시뮬레이터(Simulator) : 실 기기로 무/유선 디버깅이 되지만 시뮬레이터를 통한 디버깅도 지원하고 있다.
 - 인터페이스빌더(InterfaceBuilder) : 스토리보드 등으로 뷰요소를 시각적으로 구성할 수 있으며 IBOutlet, IBAction 등으로 뷰 ~ 컨트롤러 간 소통할 수 있게 해준다.

### ➣  1강 용어정리
* 인터페이스빌더 내 확대/축소 : Alt+Scroll, 핀치동작으로 가능하다.
* 메서드의 인자이름 지정 방법 : withEmoji emoji 처럼 외/내부 인자이름을 설명할 수 있다. 물론 외/내부 인자이름 동일하게 emoji 하나만 지정할 수도 있다.

### ➣  1강 구현결과
<div>
 <img width="250" src="https://user-images.githubusercontent.com/4410021/63637175-66a4cc80-c6b4-11e9-840f-70017918c1f0.png">
</div>

<br>

## ♣︎ 총 정리
- Xcode 기본 인터페이스, 집중력게임 기본로직 개발

<br>
<br>

# Lecture 2) 
## ♣︎ MVC패턴
- Model + View + Controller (모델-뷰-컨트롤러)로 구성하는 디자인패턴 기법

 ### ◼︎ Controller : UIViewController 등의 컨트롤러 요소
 - 모델과 원하는대로 얘기 하며 사용자에게 보여져야 할 데이터를 받는다.(특히 공개적인 데이터와는 무제한적으로 대화가능)
 - @IBOutlet, @IBAction 등 을 통해 View와 소통한다. 
   - ex) @IBOutlet/Action Delegation패턴 등 으로 Interface builder 내 View 요소와 블라인드 소통 가능

 ### ◼︎ View : 스토리보드의 UILabel, UIImageView, UIView... and so on...
 - 모델과 절대 소통 불가능
 - 뷰는 컨트롤러와 블라인드상태로 소통해야한다. 뷰는 컨트롤러가 집중력게임 컨트롤러인지 어떤 컨트롤러인지 알지 못한다. 소통 시 컨트롤러에서 뷰에 대한 정의를 구조적으로 지정하고 교류할 수 있다.(타겟메서드, 델리게이트, 데이터소스 프로토콜 등...)
   - ex) 타겟메서드 : 컨트롤러에 타겟 메서드를 지정 후 뷰가 동작 시 메서드가 동작하는 방식으로 소통 가능
   - ex) 델리게이트 : 스크롤뷰 등의 did, will, should Delegate 메서드 등을 컨트롤러에서 등록하여 사용할 수 있다.(뷰-뷰컨트롤러 간 블라인드 소통 가능)
   - ex) 테이블 뷰 등의 스크롤 시 셀 갯수 등을 UITableViewDataSource Protocol로 지정하고 상황에 따라 필요한 만큼의 데이터만 모델에 요청하여 유저에게 보여줄 수 있다.
 ### ◼︎ Model : 뷰에 표현 될 데이터모델
 - View와 Model은 서로 절대 소통 불가능
 - Contorller에 사용자에게 보여져야 할 데이터를 제공한다.
 - Controller와 직접적으로는 소통하지 못한다.
   - Notification, KVO(Key Value Observing), KVC(Key value Coding), SingleTon 방식 등으로 컨트롤러와 소통할 수 있다. 
   - -> 라디오방송국을 예시로 생각하면 이해하기 좋다.

### ◼︎ 클래스(Class)가 아닌 구조체(Struct)를 사용하는 이유??
 - 사실 스위프트의 클래스와 구조체는 대부분이 유사하다. 하지만 두가지 큰 차이가 있다.
   - 구조체는 값타입(Call by Value)이다. vs 클래스는 참조타입(Call by Reference)이다.
   - 구조체는 상속성을 가지고 있지않다. vs **클래스는 상속성을 가지고 있다.**
     - 프로토콜 채택은 구조체와 클래스 전부 가능하다. 
   - **구조체는 모든 멤버변수를 초기화할 수 있는 자동 생성자(Free Initializer)가 존재**한다. vs 클래스는 이러한 자동 생성자가 존재하지 않는다.

### ➣  2강 용어정리 
 * API란? : Application Programming Interface(인스턴스 리스트)의 약자
 * lazy : lazy를 사용하면 해당 객체가 실제 사용되기 전까진 초기화 하지 않는다. 누군가 사용하려 할때 비로소 초기화(메모리 할당) 된다.
   - lazy를 사용하면 프로퍼티 옵저버(Property Obserber, 프로퍼티 감시자)로서의 역할은 불가능하다.
   - 특정 객체의 작업 부하가 비교적 크거나, 사용빈도가 적은 경우 상황을 고려해 사용하면 좋다. 
 * 배열.indices : 특정 Sequence의 계수가능 범위를 배열로 자동 리턴해준다.
   - for문 등에 사용하면 유용하다.
   - indices 사용 예 : for index in emojiCardButtons.indices {}
 * 배열.shuffle() : 컬렉션 요소를 랜덤하게 섞어준다.
   - shuffle 사용 예 : emojiCardButtons.shuffle()

### ➣  2강 구현결과
<div>
 <img width="250" src="https://user-images.githubusercontent.com/4410021/63637283-f26b2880-c6b5-11e9-9967-775e9b80fc14.png">&nbsp;
 <img width="250" src="https://user-images.githubusercontent.com/4410021/63637222-27c34680-c6b5-11e9-9af0-6935c3027674.png">&nbsp;
 <img width="250" src="https://user-images.githubusercontent.com/4410021/63637223-298d0a00-c6b5-11e9-9358-420d8d4e3675.png">
</div>

<br>

## ♣︎ 총 정리
- MVC(Model-View-Controller)패턴의 개념 이해
  - Model, View, Controller의 각자 역할
- 집중력게임의 MVC 디자인패턴 적용연습
- 클래스(Class) vs 구조체(Struct) 특징

<br>
<br>

# Lecture 3) 
## ♣︎ Swift 기초문법

### **앞서 강의에서 배운 내용 간략정리**
- 타겟/액션, IBOutlet, IBOutletCollection
- 메서드와 프로퍼티 사용
- 프로퍼티옵저버(didSet, willSet)
- 배열 Array<Element>, [Element]
- 딕셔너리 Dictionary<Key, Value>
  - -> 키(Hashable, Equatable)와 값(Any)으로 이루어진 해쉬타입 구조체
- for _ in 반복문
  - 시퀀스(sequence) 성질이 있는 요소 순회탐색에 사용 가능
  - forEach와 달리 도중 break 를 통해 반복문을 빠져나갈 수 있음
- 문자열(String), 배열(Array), 딕셔너리(Dictionary), Set 등
- MVC(Model-View-Controller) 패턴
- 값타입 Struct, 참조타입 class
- 초기화함수, 생성자(initializers)
- 실제 실행 시 초기화 되는 lazy 프로퍼티(사용 시 프로퍼티옵저버 역할 불가능)
- 타입변환 
  - ex) UInt32(Int)
- nil이 될 수도 있는 옵셔널, 옵셔널바인딩방법 "if let" (+ guard let)

* **오토레이아웃을 적용하지 않은 집중력게임앱 가로모드 실행화면**
<div>
 <img width="500" src="https://user-images.githubusercontent.com/4410021/63637755-88ee1880-c6bb-11e9-90cb-7c47b704ebbf.png">
</div>

- 지금까지 만든 집중력게임, 세로모드에선 문제 없어보이지만.. 만약 가로모드(landscape 상태)가 된다면?? 
  - -> 컨텐츠가 전부 보이지 않는 어설픈 레이아웃 상태...
  - ✭ **문제 해결을 위해서 오토레이아웃 구현이 필요하다.**

 ### UIStackView
 - 다양한 UI객체를 묶어 관리할 수 있다.
 - 여러개의 UI를 선택 
   - -> 인터페이스 빌더 하단 "embed in View" 로 스택뷰 처리가능
 - 스택뷰 프로퍼티
   - distribution : 스택뷰 내 서브뷰의 배치 설정 
   - fill, fillEqually, fillProportionally... 등의 옵션이 있다.
   - alignment : 스택뷰 정렬 기준 설정
     - center ... 

 ### Stride(from:,through:,by:)
 - *Float 등의 부동소수점을 반복문으로 돌릴 수 없을까?*
   - Swift에서는 stride 전역함수를 이용하여 구현할 수 있다.
   - 부동소수점 이외에 문자열의 인수 등도 셀 수 있다.

 ~~~ swift
 // for (i = 0.5; i<=15.25; i+=0.3) 과 같은 동작의 stride 사용 예
 for i in stride(from: 0.5, through: 15.25, by: 0.3) {

 }
 ~~~

 ### Tuple
 - 튜플은 무엇일까? 
   - **메소드나 변수가 없는 소형 구조체**, 값만 들어가 있는 다른 언어의 구조체와 유사하다.
 - 가볍기 때문에 한 줄만으로 표현할 수 있다.
 - 여러 요소의 이름을 유연하게 설정할 수 있다.
 - 함수 내에서 하나 이상의 값을 리턴할때 유용하다.
    - ex) (weight: Double, height: Double)로 신장(height)+체중(weight) 값 리턴
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
 - 쓰기, 읽기 시 사전 정의한 get, set 대로 계산되는 프로퍼티
 - 계산프로퍼티는 프로퍼티감시자(property Observer)와 혼용해서 사용할 수 없다.
     - 둘 중 하나만 선택해서 사용할 수 있다. 
 - 저장프로퍼티와 달리 쓰기/읽기 시 마다 set, get 블럭 내용을 실행한다.
 - **get(읽기)과 달리 set(쓰기)은 필수 구현요소가 아니다.**
    - -> **읽기/쓰기(get/set) or 읽기(get) 상태로 구현 가능**
    - get 만 사용한다면 get 명시 없이 return <값> 로 구현할 수도 있다.
 - 상황에 따라 계산되는 속성으로 코드는 훨씬 간결해지고, 직관적이게 된다. 일어난 상황에따라 반응하기 때문이다.
 - 특정 행위를 할 때마다 변경 혹은 읽기가 필요한 경우 유용할 수 있다.
 - **저장프로퍼티, 계산프로퍼티의 특성을 살릴 만한 상황을 잘 판단하여 사용하는 것이 좋다.**
    - ex) indexOfOneAndOnlyFaceUpCard: Int? -> 카드를 뒤집을때 카드의 상태에 따라 다른 처리가 필요한 변수
    
 ~~~ swift 
 // 계산프로퍼티 사용 예)
 var foo: Double {
    get {
        // return the calculated value of foo
        return <계산된 foo의 값>
    }

    set(newValue) {
        // do something based on the fact that foo has changed to newValue
        // 새로운 값으로 변경이 될 때 해당 블럭이 실행 된다.
    }
 }
 ~~~

<br>

## ♣︎ **접근제어 Access Control**
 - 외부로부터 코드 내부를 접근하는 기준을 지정할 수 있다.
#### ◼︎ open : 해당 프레임워크 이외의 모듈에서도 읽기 + 할당, 서브클래싱(상속), 오버라이딩 까지 전부 가능하다. 

- 즉 전체 모듈에 대하여 완전개방 상태이다.
- 현재 모듈 뿐 만 아니라 다른 모듈에서도 읽기, 서브클래싱(상속), 오버라이딩, 할당 모두 가능한 완전개방 상태이다.
#### ◼︎ public : 해당 프레임워크 이외의 모듈에서는 읽기만 가능하다. 
- 선언된 내부 모듈에서는 읽기, 상속, 오버라이딩 등이 모두 가능하다. 
  - 다른 모듈에서 불러와 읽기가 가능하다. 
  - 하지만 다른 모듈에서의 서브클래싱(상속), 할당, 오버라이딩은 불가능하다. 
#### ◼︎ Internal : default 접근제어, Internal일 경우, 모듈 내에 서는 읽기, 상속, 오버라이딩이 가능하다.
- 어떠한 접근제어 명시를 안했을 때 적용되는 Default Access Control 상태
- 모듈 내에서는 읽기, 서브클래스(상속), 오버라이딩, 할당 모두 가능하다.
  - 하지만 다른 모듈에서의 읽기, 서브클래식(상속), 할당, 오버라이딩을 불가능하다. 
#### ◼︎ Private : 해당 지정된 블록 내에서만 접근 가능, 다른 객체로부터 접근 비공개상태
- 현재 정의된 블록 이외의 영역에서는 접근할 수 없다. 
- 블록 내에서만 쓰기등이 가능하다. 
#### ◼︎ Private(set) : 다른 객체에서 읽기가 가능하지만 할당은 불가능 하다. 지정 된 내부에서만 읽기, 쓰기 가능.
- **정의 된 블록 내에서만 서브클래싱(상속), 오버라이딩, 할당이 가능**하다. 
- **현재 정의 된 블록 이외의 영역에서는 읽기만 가능**하다.
- **public private(set)과 동일한 표현**
#### ◼︎ fileprivate : 파일 이내에서는 지정 된 메서드, 프로퍼티에 대해서 읽기, 쓰기 및 할당 가능
- **현재 정의 된 파일 영역 읽기, 오버라이딩, 서브클래싱(상속), 할당 등의 접근이 가능**하다.
- 정의 된 파일 영역 이외에서는 접근할 수 없다. 

<br>

## ♣︎ 확장 Extension
 - extension <객체이름> {} 과 같은 식으로 사용할 수 있다.
 - **extension(확장)은 iOS에서 매우 강력한 도구**이다. 비유하자면, 마치 **"조심스럽게 다루는 무기"와 같다.**
 - **extension은 저장공간이 있는 변수는 아니다.**
 - **extension은 간편하여 쉽게 남용 될 수 있다.**
   - 그러므로 **확장 사용 시 불필요한 기능인지 고려할 필요**가 있다.

<br>

## ♣︎ 옵셔널
- Optional "옵셔널도 enum이다."
- **nil일 수도 있음을 의미.** Optional, The Enumeration
- 옵셔널의 정의 형태) enum + 배열과 같은 제네릭 형태로 되어있다.

~~~ swift
// Optional의 코드 형태
 enum Optional<T> {
    case none // 설정되어있지 않은 상태
    case some(<T>) // 그 이외 데이터타입 'T'와 관련된 상태
 }
~~~

- 옵셔널의 구조가 매우 단순해 보이지만, **Optional은 다른 타입들은 가지고 있지 않은 많은 특별한 구문(syntax)들을 갖고 있다.**

~~~ swift
// 만약 값이 없는 옵셔널을 강제바인딩 '!' 처리 한다면???)
 let hello: String?
 print(hello!)
~~~

~~~ swift
 // 위에서 강제바인딩(!)으로 출력실행한 hello 상수에 대한 동작과정
 switch hello {
    case .none: // 예외 발생(강제 바인딩을 했으나 값이 없으므로 오류발생), 안전한 바인딩 시 해당 상황 시 옵셔널 바인딩의 else 부분이 실행 되고 Crash를 면할 수 있다.
    case .some: // 만약 강제 바인딩 시 값이 존재했다면 오류없이 해당 데이터(연동자료)를 출력 했을 것이다.
 }
~~~

#### ◼︎ 옵셔널 체이닝
 - 옵셔널 체이닝은 수차례의 옵셔널 검사(?.)를 하며 값을 접근하는 방법이다.

~~~ swift
// 옵셔널 체이닝 사용 예시)
// 전부 이상없이 접근이 되었다면 z를 리턴한다.
// 만약 x, foo(), bar를 접근하며 어느 하나라도 값이 nil(switch case .none)이라면 해당 옵셔널 체이닝을 빠져나가 nil을 리턴한다.
 let opt = x?.foo()?.bar?.z
~~~

<br> 

## ♣︎ ARC (Automatic Reference Counting)
 - **iOS의 자동 참조할당 해제 방식**
 - **Class에서만 적용되는 방식**
    - 값참조를 하는 구조체와는 상관없다. 
 - **ARC가 0 이되면 Heap에서 빼내어 할당을 해제**한다.
 - **strong, weak, unowned** 등의 참조 옵션이 존재한다.

#### ◼︎ Strong
- 참조카운팅의 기본 설정값.
- strong으로 설정하고 있는 한 해당 객체는 해제되기 전가지 힙 내에 계속 유지된다.

### ➣  weak
- **weak은 옵셔널 포인터로 참조타입을 가리킨다.**
- 힙 내의 어떤것을 가리키고 있지만, 흥미가 있어야만 사용되는 것
- **weak은 아울렛, 델리게이트 등에 사용될 수 있다.** 그 외에에는 사용을 안하는 편이다.
  - **MVC델리게이션, 클로저 캡쳐링 등의 상황 시 참조순환을 방지 할 수 있다.**
  - **2015 WWDC @IBOutlet 소개 시, @IBOutlet 정의 간 strong의 사용을 권장하고 있다.**
    - 관련하여 @IBOutlet 등에 weak 키워드를 지정하는게 좋을 지 좀더 생각해볼 필요가 있다.

### ➣  unowned
- **"만약 내가 문제가 있으면 오류를 발생시켜라."**
   - 반드시 nil이 아니라고 판단 될때 사용해야 문제가 없다.
- **참조순환(메모리 사이클)을 방지하기 위해 사용한다.**
   - 클로저를 사용하면 캡쳐링 등의 참조순환 문제가 발생할 수 있는데 이를 방지하기 위해 사용하곤 한다.
- 매우 위험한 참조카운팅 방식
- 매우 드물게 사용한다.

<br>

## ✯ Swift 앱개발에 사용되는 자료구조
#### - Class, Struct, Enum, Protocol

## ♣︎ 클래스 Class
- **클래스는 참조타입, 상속을 지원한다.**
- **참조타입으로서 힙(Heap)영역에 존재**하게 된다.
- **참조계산 방식은 앞서 언급한 ARC(Automatic Refernce Counting)로 동작**한다.

## ♣︎ 구조체 Struct
- **구조체는 값타입**, 상속을 지원하지 않는다.
  - Class, Struct 전부 프로토콜 채택은 가능하다.
- **구조체 종류**
  - 배열, 딕셔너리, 문자열, 문자, 정수형 ,Double, UInt32 등... 많은 경우에 구조체가 활용된다. 
- **값 타입이므로 내부적으로 변경이 필요한 메서드를 정의할때 mutating 예약어를 사용**해야 한다. 

## ♣︎ 열거형 Enum
- Struct, Class 등과 함께  데이터 구조 타입의 일종인 열거형.
- struct, class와 비슷하다.
  - 그 중 enum은 구조체(struct)와 동일한 값 타입이다.
- 메서드, 변수를 가질 수 있지만 저장공간을 가지지는 않는다.
  - enum의 저장공간은 연동자료들 각각에 대해서만 존재한다. 그러므로 enum의 값들은 계산된 변수만을 가질 수 있다.
    - enum의 각 case 내 연동자료를 제외한 저장공간은 존재하지 않는다.
- swift enum은 다른 언어의 열거형과 흡사하다. 하지만...
- **다른 언어에 비해 swift의 enum은 매우 강력하다.**
   - **enum 각각의 케이스들이 연동된 데이터 혹은 값을 가질 수 있기 때문이다.**
   - 타입 추론이 가능하지만 좌측 혹은 우측 어느 한곳에는 해당 타입을 명시해주어야 추론이 가능하다.

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

#### ◼︎ default:
- 만약 특정 케이스 이외의 케이스를 한번에 묶어 구분하려면 case로 default:를 사용할 수 있다.

#### ◼︎ case let
- 만약 case 내 정보에 따른 연동자료를 얻고 싶다면 case문 내에 let을 활용할 수 있다.
- let 변수 이름은 enum 요소와 무관하게 지정해도 무방하다.

~~~ swift
// case let 사용 예시)
// drink에 대한 특정 값 부여에 따른 연동자료를 얻을 수 있다.
 var menuItem = FastFoodMenuItem.drink("Coke", ounces: 32)
 switch menuItem {
     case .hamburger(let pattyCount): print("a burger with \(pattyCount) patties!")
     case .fries(let size): print("a \(size) order of fries!")
     case .drink(let brand, let ounces): print("a \(ounces)oz \(brand)")
     case .cookie: print("a cookie!")
 }
~~~

<br>

#### ◼︎ switch self 

- **enum 내에 switch self 를 구성하여 case에 따른 연동자료를 반환시길 수 있다.**
- enum 내부적으로 self를 변경 시킬 수도 있다.
  - 단, **값타입인 enum 타입 내에서는 struct와 같이 내부 쓰기를 위해선 mutating 속성이 부여되어 있어야 가능하다.**
  
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

<br>

## ♣︎ 프로토콜 Protocol

- **문자열, 배열 등 많은 것들이 프로토콜을 사용하며 이들의 기초가 된다.**
- **다중상속과 같은 효과 / Controller-View 간 델리게이션 사용 등을 통한 블라인드 소통기능 등 다양한 역할**을 할 수 있다.
- 4강에서 이어서 알아본다.

<br>

### ♣︎ 3강 용어정리
 * Safe Area : 안전영역 즉, 스크린 주변의 다른 UI와 겹치지 않고 배치할 수 있는 영역
 * Assertion(Assert) : 어떤 것이 참임을 단언하는 함수
   - 만약 Assertion을 통해 단언한 내용이 성립하지 않으면 디버깅단계에서 프로그램 에러를 발생시킨다.
   - 앱스토어 배포단계에서 Assertion은 무관하게 취급한다.
   - API를 보호하기 좋은 수단이다.

### ♣︎ 3강 구현결과 

<div>
 <img width="400" src="https://user-images.githubusercontent.com/4410021/63647522-54329d80-c75d-11e9-93ce-7be2acb2d7a6.png">
 <p><img width="250" src="https://user-images.githubusercontent.com/4410021/63647523-54329d80-c75d-11e9-8774-47b6ab64e86b.png">
</div>
<br>

## ♣︎ 총 정리
- 집중력게임(Concentratino Game)의 오토레이아웃 적용
- Swift 핵심 기초문법 훑어보기
  - ARC, Optional
  - Extension
- Swift의 핵심 자료구조
  - 구조체(Struct), 클래스(Class)
  - 열거형(Enum)
    - 열거형 관련 문법
      - case let, 연동자료 활용
      - default:
      - switch self
  - 프로토콜(Protocol)
  
- 집중력게임 내 계산프로퍼티, extension 적용을 통한 코드 간결화

<br>
<br>

# Lecture 4) 
## ✭ Protocol, Closure, String
- 그 외 mutating 등...

#### Concentration 객체를 class -> struct로 변경!
- 이제 Concentration은 ViewController에 참조되는 포인터가 아닌 하나의 모델이 된다.
- **왜 구조체로 교체할까??**
  - **구조체는 값 복사 타입**이다. 그러므로 **Heap에 존재하지 않고 구조체를 전달 시 계속해서 그 값을 복사**한다.
  - 값이 계속 복사되니 비효율적이라고 생각할 수 있다.
    - 하지만 스위프트는 영리해서 **struct일 지라도 해당 내용이 변경되엇을 때만 값을 복제**한다.

<br>

## ♣︎ Protocol
#### ◼︎ Struct, Class, Enum과 함께 스위프트의 자료구조를 형성하는 네번째 기둥
- **별도의 구현이 없는 메서드와 변수의 리스트**이자 하나의 일급타입
- **프로토콜은 메서드에 대한 기본 구현을 제공**한다.
- **블라인드 커뮤니케이션을 할때 최적의 도구**이다.
  - ex) view - Controller Delegation Pattern
- **프로토콜은 API(Application Programming Interface)에서 원하는 것을 불러오는 방식으로 작동**한다.
- **프로토콜은 코드가 없다. 구현방식이 아닌 순수한 선언이기 때문이다.**
- 만약 **특정 프로토콜이 클래스만 받는 프로토콜 이라면, 프로토콜 뒤에 : class 를 표시** 해주어야 한다.
  - class 선언을 해두면 굳이 mutating 표시를 할 필요가 없다. 
    - struct일 경우에만 mutating 내부 쓰기를 위해 키워드가 필요하다.
  - extension에 protocol을 채택하여 사용할 수도 있다.
- 특정 유사한 기능을 공유하면서도 동일한 클래스로부터 상속받을 필요가 없도록 할 수 있다. 
  - 프로토콜을 통해 "**다중상속과 같은 효과를 낼 수 있음**"

#### ◼︎ 프로토콜의 선언 방식
- 프로토콜의 선언
 - 클래스, 열거형, 구조체 선언과 같은 선언방식
 - 클래스, 구조체 등의 선언방식과 유사

~~~ swift
// 프로토콜 선언 예
// AProtocol을 구현하려면, IngeritedProtocolA, InheritedProtocolB 프로토콜을 충족시켜야 한다.
protocol AProtocol: InheritedProtocolA, InheritedProtocolB {
    var someProperty: Int { get set }
    func aMethod(arg1: Double, anotherArgument: String) -> SomeType
    mutating func changeIt()
    init(arg: Type)
 }
~~~

- 클래스나 구조체, 열거형이 프로토콜의 메서드, 변수를 구성
- 클래스나 구조체, 열거형 등의 구조 내부에 구성
  - 클래스로 프로토콜을 구현하려 한다면 클래스의 init 에 required 예약어를 붙여주어야 만 한다.
    - 서브클래스에서는 더이상 이 프로토콜을 구현하지 않았는데도 사람들은 프로토콜이 서브클래스에서도 가능한것으로 착각할 수 있기 때문이다.
    - 서브클래스의 init이 형성되지 않도록 메인 클래스의 required init 지정을 해준다.

#### ◼︎ 프로토콜 채택방법

~~~ swift
// 프로토콜 채택방법 예시(클래스)
 class SomeClass: SuperClassOfSomeClass, SomeProtocol, AnotherProtocol {
    // 클래스의 구현
    // 채택한 프로토콜, SomeProtocol, AnotherProtocol을 준수해야한다.
 }
// 프로토콜 채택방법 예시(구조체)
 struct SomeStruct: SomeProtocol, AnotherProtocol {
    // 구조체의 구현
    // 채택한 프로토콜, SomeProtocol, AnotherProtocol을 준수해야한다.
 }
~~~

<br>

#### ◼︎ 프로토콜 옵셔널 메서드 (optional func)

- 프로토콜 내 func 앞에 "optional"을 붙여주면 구현 가능하다.
- 프로토콜에서 지정한 옵셔널 메서드는 반드시 선언할 필요가 없다.
- 프로토콜의 메서드를 선택적으로 사용 할 수 있다.

#### ◼︎ mutating
- 내부 객체 자체를 변경시킬 수 있음을 알려주는 예약어
- 값 타입인 Struct 등 만 구현하며, 참조타입인 class등에는 구현할 필요가 없다.
  - ex) Concentration 객체를 class -> struct로 변경하니 내부 오류가 발생한다. 
  - => 이때 내부에서 Concentration 객체 자체를 변경시킬 것임을 mutating을 통해 명시해주어야 한다.

#### ◼︎ 프로토콜 사용 예

~~~ swift
// 프로토콜, Moveable
protocol Moveable {
   mutating func move(to point: CGPoint)
}
// Moveable 프로토콜을 채택한 클래스, Car
class Car: Moveable {
   // Car는 Class이자 참조타입이므로 mutating이 필요없다.
   func move(to point: CGPoint) {...}
   func changeOil()
}

struct Shape: Moveable {
   // Shape는 Struct이다 값타입이므로 mutating을 명시해주어야 한다.
   mutating func move(to point: CGPoint) {...}
   func draw()
}

// Car 인스턴스, prius
let prius: Car = Car()
// Shape 인스턴스, square
let square: Chape = Chape()

// prius를 참조하는 thingToMovem
var thingToMove: Moveable = prius
thingToMove.move(to:...) // prius의 move(to:)가 실행된다.
thingToMove.changeOil() // thingToMove 인스턴스는 Moveable타입이므로 Car의 메서드 실행불가

// prius, square을 Moveable 타입 배열로 받을 수 있다.
// 둘다 Moveable 프로토콜을 준수하는 인스턴스이기 때문이다.
let thingsToMove: [Moveable] = [prius, square]

func slide(slider: Moveable) {
    let positionToSlideTo = ...
    slider.move(to: positionToSlideTo)
}

// prius, square 둘 다 Moveable 프로토콜을 준수하기때문에 들다 slide의 인자값으로 사용할 수 있다.
slide(slider: prius)
slide(slider: square)
~~~

<br>

 ### ◼︎ MVC Delegation

 - Protocol을 사용하면 ViewController에서 데이터 Model에 대해서 몰라도 뷰-모델 간 반응을 시킬 수 있다.

 #### MVC Delegation 사용 순서
- 1) 스크롤뷰, 테이블뷰와 같은 **델리게이션 P 프로토콜을 선언**한다. ex) will, should, did...
~~~ swift
// delegate 변수를 weak으로 설정하는것은 델리게이션 패턴 사용 간 순환참조를 방지하기 위함이다. 
// -> 사용하지 않고, 힙에서 빠져나가려 한다면 nil로 설정하고 더이상 사용하지 않는다.
// delegate 변수 weak 설정 예시) 
weak var delegate: UIScrollViewDelegate?
~~~

- 2) **프로토콜 적용을 할 A뷰 내부에 델리게이트 변수, D를 생성**한다. 이 **D 델리게이트 변수는 공개변수**이며 사용 간 **순환참조를 방지하기 위해 weak속성을 가진다.**
- 3) **A뷰가 will, did, should등의 이벤트를 보내고 싶을때 D변수에 이벤트에 필요한 값들을 전해주면 된다.**
- 4) 이제 **C컨트롤러가 P프로토콜을 채택하여 델리게이션 사용을 준비**한다.
- 5) **C컨트롤러가 A뷰의 P프로토콜 델리게이트 변수인 D를 자기 자신으로 설정**한다.
  - C컨트롤러는 P프로토콜의 D델리게이트를 구현하기로 선언했고, 이로써 A뷰와 C컨트롤러는 서로를 잘 모르지만, C는 뷰에 대한 조작이 가능하다. 
~~~ swift
// in C Controller...
scrollView.delegate = self
~~~

- 6) **C컨트롤러는 P프로토콜을 준수해야한다.** (프로토콜의 모든 필수 메서드를 구현해야 한다. optional func는 선택적으로 사용한다.)
  - 일반적으로 대부분의 델리게이트 메서드는 옵셔널이다. 그렇기에 대부분은 그냥 원하는 델리게이트 메서드만 사용할 수 있다.
- 7) **C컨트롤러가 P프로토콜의 D델리게이트 변수를 자기자신으로 선언 + 델리게이트메서드 구현을 하여 서로 의사소통할 수 있다.**
  - A뷰는 C컨트롤러로 원하는 will, did, should 이벤트 등을 전달 할 수 있게 되었다.
  - **C컨트롤러는 A뷰 클래스에대해 잘 몰라도 뷰와 소통할 수 있게 되었다.**
  - **블라인드 커뮤니케이션이 가능해짐**

<br>

#### ◼︎ 딕셔너리 dictionary

- 키와 값(해쉬가능한 키와 값)으로 이루어진 컬렉션
- 키는 Hashable 프로토콜을 준수해야하면 값은 어떤 값이든 상관없다(Any).
  - **key: Hashable, value: Any**
- 딕셔너리는 Hashable한 즉, 키가 될 수 있어야만 값과 함께 구현이 될 수 있다.
- 딕셔너리의 키를 접근해 얻는 값은 옵셔널형태이다.

~~~ swift
// 딕셔너리의 정의 형태 예시)
Dictionary<Key: Hashable, Value>
var dic = [String: Int]()
var iDic = [Int: String]()
~~~

#### ◼︎ Hashable

- 해쉬가능하다 -> 딕셔너리의 키가 될 수 있다.

~~~ swift
// Hashable의 Protocol 사용 예시)
// Hashable 해시테이블 등에서 고유한 해시같아 보이지만 그것을 보장할 수 없다.
// => 이를 확실히 보장하기 위해 등호를 통해 서로 동일한지 비교가 필요하다. 그래서 Equatable프로토콜을 준수한다.
protocol Hashable: Equatable {
   // 읽기전용 해쉬벨류 변수
   var hashValue: Int { get }
}

protocol Equatable {
   // lhs는 좌변, rhs는 우변을 의미한다.
   // Self는 현재 타입을 의미한다.
   // 좌변, 우변을 비교하고 그 결과를 Boolean으로 반환한다.
   static func == (lhs: Self, rhs: Self) -> Bool
}
~~~

<br>

#### ◼︎ 프로토콜의 다중상속 효과
- 프로토콜은 일일히 중복된 기능을 여럿 정의할 필요없이 한번의 공통 된 구현만으로 여러곳에서 사용이 가능하다.
- 마치 **상속없이도 프로토콜을 통해 다중상속처럼 보이는 효과**를 얻을 수 있는 것이다.
- **그렇다면 이 프로토콜은 어디에 정의해야할까?**
 - => **extension protocol, 프로토콜의 익스텐션에 넣으면 된다.**
 - 하지만 extension은 저장공간이 없기에 조금의 제약이 존재한다.

#### ◼︎ Sequence 프로토콜의 extension protocol 예시
- **Sequence를 통해 사용가능 한 메서드**
  - -> contains(), forEach(), joined(separator:), min(), max(), filter(), map() and so on...
- **실제 배열, 딕셔너리등을 사용할때 위와 같은 메서드들은 함께 자동으로 사용이 가능하다.**
  - **동일한 프로토콜(Sequence)을 채택하고 있기 때문에 가능**
- 좀 더 효율적인 방법이나 기능을 구현하기 위해서 extension을 활용할 수 있다.

~~~ swift
// extension Sequence, extension protocol 사용 예시
extension Sequence {
   // ✭ 하나의 메서드만 구현해도 모든 다른 구현이 공유되어 얻을 수 있다는 것이 프로토콜의 장점이다.
   func contains(_ element: Element) -> Bool { }
   // etc...
}
~~~

#### ◼︎ 다중상속의 효과를 지닌 프로토콜
- ex) **Collection, Sequence, CountableRange...**
- CountableRange : 계수 가능 범위는 많은 프로토콜을 구현한다.(12 ~ 15개의 프로토콜이 존재)
- Sequence : makeIterator
  - for in(수행하는 대상은 수열형태) 등 지원
- Collection
  - subscripting, index(offsetBy:), index(of:), etc...

- ✓ 왜 이런 프로토콜이 필요할까??
  - 배열(Array), 딕셔너리(Dictionary), Set, String들은 각각 하나의 Collection이다.
  - 이들은 또한 Sequence의 특성을 가진다.
  - 이들은 계수가능범위를 표현하는 indices()등의 메서드를 쓰기도 한다.
  - **이처럼 다른 객체 간에도 공통적인 속성, 기능을 사용해야 할때가 있다. 이럴때 프로토콜 유용함을 이용할 수 있다.**

<br>

#### ✭ 함수형 프로그래밍 (Functional Programming)
- **객체지향 프로그래밍의 진화된 형태라고도 한다.**
- 다중상속 등을 보다 쉽게 통제할 수 있다.
- 어떤 것이 어떤 작업을 하는지 증명할 수 있는 등 많은 장점이있다.
- **거의 모든 기초 프레임워크인 딕셔너리, 배열 등이 함수형 프로그래밍으로 만들어져 있다.**
- 프로토콜을 이용한 제약이나 프로토콜의 익스텐션 등은 함수형 프로그래밍을 지원한다.
  - **스위프트는 함수형프로그래밍, 객체지향프로그밍 등을 모두 지원**한다.
  - **스위프트는 프로토콜 & 객체 & 함수형 프로그래밍 등을 전부 지원하는 다중 패러다임 언어**이다.

<br>

## ♣︎ 문자열 String
- 문자열 구조체와 별개로 문자(Character) 구조체가 있다.
- **문자열은 유니코드로 구성**되어있다. ("CAFE" -> 5개의 유니코드로 표현)
  - Character는 unicodeScalars.first!.value / asciiValue! 등을 통해 각각의 ascii 코드값을 얻을 수 있다.
- **문자열은 구조체이자 값 타입**이다.
- **Swift에서는 문자열을 정수로 색인하지 않는다.**
  - 정수형이 아닌 String.Index로 색인
  - **Array는 Array.Index가 정수형으로 정의되어 정수형으로 색인 가능**
    - 쓰기, 읽기 복잡도 O(1)
- **String, Array 전부 rangeReplacableCollection 프로토콜을 준수**한다. (계수범위 지정 가능..)

#### String.Index
- String은 정수 대신 다른 특수한 타입, Stirng.index를 사용하여 문자열을 색인한다.
- **startIndex, endIndex, index(of:) 등을 통해 인덱스를 얻을 수 있다.**
  - **BidirectionalCollection <-> Array는 RandomAccessCollection**
- **문자열(String)의 배열(Array)은 곧 문자(Character)들의 모음 배열**이다.

~~~ swift
let characterArray = Array(str) // Array<Character>
print(characterArray[0]) // Array형으로 변환하면 String.Index 대신 정수값으로 접근이 가능해진다.(O(1))
~~~

~~~ swift
// String.Index 사용 예시)
let pizzaJoint = "cafe pesto"
let firstCharacterIndex = pizzaJoint.startIndex // of type String.Index
let fourthCharacterIndex = pizzaJoint.index(firstCharacterIndex, offsetBy: 3)
let fourthCharater = pizzaJoint[fourthCharacterIndex] // pizzaJoint 네번째 문자열인 'e'

// " "(공백) 이 없다면 인덱스 반환값이 nil일 수도 있으므로 if let 을 사용했다.
if let firstSpace = pizzaJoint.index(of: " ") {
   let secondWordIndex = pizzaJoint.index(firstSpace, offsetBy: 1) // 공백으로부터 1칸 뒷쪽의 문자 인덱스를 반환
   let secondWord = pizzaJoint[secondWordIndex..<pizzaJoint.endIndex] // "pesto"
}
~~~
- ..< 등으로 String.Index의 영역을 지정할 수 있다.

### Range
- Range는 제네릭 타입으로 꼭 Int형으로만 범위를 설정할 필요가 없다. ex) Array.Index 외 String.Index의 사용...

### String 제공 기능

- **components(separatedBy:)**
~~~ swift
// components 사용 예)
pizzaJoint.components(separatedBy: " ")[1] // pizzaJoint를 공백 단위로 쪼갠 뒤 그 중 (인덱스 1)2번째의 값을 반환한다.
~~~

- **insert(contentOf:,at:)**
~~~ swift
// insert 사용 예)
var s = pizzaJoint // String은 구조체이자 값타입이므로 값복사를 한다.
s.insert(contentOf: " foo", at: s.index(of: " ")!) // "cafe foo pesto" or Crashed(because of '!')
~~~

- **replaceSubrange(,with:)**
~~~ swift
// replaceSubrange 사용 예시
// * ..< 로 좌변을 구체적으로 명시 안해도 스위프트는 영리하게 startIndex로 인식하여 계산한다.
s.replaceSubrange(..<s.endIndex, with: "new Contents") // Change Strings with "new Contents"
~~~

- **remove(at:)**
~~~ swift
// remove 사용 예시
emojiChoices.remove(at: randomStringIndex)
~~~

### NSAttributedString
- **각각의 문자가 속성을 지닌 문자열**
- **여러 문자의 범위 내에서 하나의 딕셔너리를 사용**한다.
- 속성 문자 별로 다양한 폰트나 문자 색상의 부여, UI라벨 글자설정, UI버튼 설정 등에 활용가능

~~~ swift
// NSAttributedString 사용 예시)
let attribText = NSAttributedString(string: "Flips: 0", attributes: attributes)
filpCountLabel.attributedText = attribText // UIButton은 attributedText라는 프로퍼티를 가지고 있습니다.
~~~

- NSAttributedString의 특징
  - **NS가 붙어있다. -> 해당 접두어(NS)를 통해 objc때부터 사용 된 오래된 API임을 유추할 수 있다.**
  - NSAttributedString은 class 구조이며 내부에 var를 사용하여 가변변수(variables)를 만들 수는 없다.

## ♣︎ Any
- 어떤 구조체나 클래스던 모두 들어갈 수 있음을 의미
- 강타입의 Swift답지 않은 표현이다. (Objective-C와의 호환을 위해 사용한다.)
- **가능하면 절대 자료구조에 Any를 쓰지 말자**

<br>

## ♣︎ 함수타입 (Function Types)
- **Swift의 함수는 1급 객체이다.**
  - 1급객체란 어떤 변수로서 할당 될 수 있고 / 매개변수로 전달될 수 있고 / 반환될 수 있는 객체를 의미합니다.
- 함수는 타입이 가지는 모든 것을 가질 수 있다.
- 어떤 것이던 함수 타입으로 선언하고 인자값, 반환값을 지정하면 된다.
- **클로져를 활용하면 보다 가독성있고 간결한 코드를 구성할 수 있다.**

~~~ swift
// 함수의 사용 예시)
func changeSign(operand: Double) -> Double { return -operand }

// Double형 인자값을 받아 Double형 을 반환하는 함수 명, operation
var operation: (Double) -> Double
operation = sqrt // sqrt 와 동일한 형태의 클로져 변수(Double) -> Double)이므로 대입할 수 있다.

// 실제로 operation을 사용해도 sqrt와 같은 동작을 얻을 수 있다.
let result = operation(4.0)

operation = changeSign
result = operation(4.0) // 결과 값 -4.0
~~~

<br>

## ✭ 익명함수 Closure
- Closure는 인라인 함수이다.

#### ◼︎ 클로져의 사용 형태

~~~ swift
// Closure 사용 에시)
var operation: (Double) -> Double
// Closure의 operation 대입
// * 함수를 일일히 정의해서 사용할 필용 없이 바로 대입순간 클로저형태로 정의하여 사용할 수 있다.
operation = { (operand: Double) -> Double in return -operand }
// 스위프트는 타입추론을 지원하기 때문에 리턴값을 생략해도 알아서 판단할 수 있다.
operation = { (operand: Double) in return -operand }
// operation의 리털타입 이외에도 피연산자도 알고 있다.
operation = { (operand) in return -operand }
// return 명시를 안해도 어떤 타입을 리턴할지를 알고 있으므로 return을 생략할 수도 있다.
operation = { (operand) in -operand }
// operand라는 피연산자 값을 $0로 변경할 수 있다. 그렇게 되면 in 예약어도 필요없어진다.
// * 여러개 인자값이 있다면 인자값 순서대로 $0, $1, $2...
operation = { -$0 }
let result = operation(4.0) // 결과 값 -4.0로 동일
~~~

<br>

- 만약 필요하다면 초기화를 위해 이름없는 클로저, ()를 사용할 수도 있다.
  - **lazy 등의 지연프로퍼티 등에 클로져 사용 시 멋지게 작동 할 수 있다.**

~~~ swift
// lazy에서의 이름없는 클로저 사용 예
var someProperty: type = {
    // someProperty에 대한 정의를 구현한다.
    return //<정의 된 값의 반환>
}()
~~~
- 이처럼 이름없는 클로저, ()의 사용으로 lazy 프로퍼티 등에 유용하게 사용가능하다.

### 고차함수 
- 클로저의 일부인 고차함수
- **다른 함수를 전달인자로 받거나 or 함수 실행을 통해 다른 함수값을 반환하는 함수**
- **filter, map(flatMap, compactMap), reduce, joined 등... 많은 고차함수가 존재**
  
- **filter**
  - 특정 조건을 충족하는 요소들의 시퀀스를 반환한다.
- 클로저 내에서는 Element를 인자로 받아 Bool를 반환한다. (true인 경우의 시퀀스 요소만 필터링)
  
- **map**
  - **배열을 받아 각각의 요소에 특정 적용을 시킨 후 새로운 배열을 반환**한다.

~~~ swift
//map 사용예시
let primes = [2.0, 3.0, 5.0, 7.0, 11.0]
let negativePrimes = primes.map({ -$0 }) // [-2.0, -3.0, -5.0, -7.0, -11.0]
// * 받는 인자의 마지막일 경우, 아래와 같이 블록을 따로 빼서 구현할 수 있다. 이 형태를 후행클로져(Trailing Closure 라고 한다.)
let negativePrimes = primes.map() { 1.0 / $0 } // [0.5, 0.333, 0.2, ...]
// * 받는 인자가 단 하나라면, ()도 생략할 수 있다.
let primeStrings = primes.map { String($0) } // ["2.0", "3.0", "5.0", "7.0", "11.0"]
~~~

<br>

### ◼︎ 클로저 사용 시 주의사항

- 클로저 캡쳐링 Closure Capturing
  - 클로저는 클래스와 같은 주소참조타입일 경우에 캡쳐링이 발생할 수 있다.
  - 클로저는 Heap안에 들어가 있다. 가령 배열 안에 클로저가 사용 되면 배열이 클로저의 포인터를 가지고 있게 된다.
  - 주변코드로부터 클로저에서 변수를 받게 되면, 해당 변수들도 Heap내에 위치하게 된다.

~~~ swift 
// 캡쳐링 Capturing 예시)
var ltuae = 42
operation = { ltuae * $0 } // 클로저 내에서 ltuae가 캡쳐링 된다. 참조타입인 클로저 내에 ltuae를 사용해야하기 때문이다.
arrayOfOperations.append(operation)
~~~

- 위와 같이 연산의 배열이 있는 클래스를 받을 때, **메모리 사이클(Memory Cycle)**이 발생할 수 있다.
- 연산이 있는 배열의 클래스를 받게 되면 클로저가 그 클래스를 힙(Heap) 안에 넣는다.
- + 배열의 클래스가 또 클로저를 힙에 넣게 된다.
- (arrayOfOperations, operation...) 클로저는 클래스를, 클래스는 클로저를 담는 메모리 사이클이 발생하게 된다.
  - **클로저 블럭 맨 앞에 [weak self] / [unowned self] 등을 붙여 메모리 사이클을 방지**할 수 있다. 

#### ◼︎ 4강 용어정리
* peculiarity : 특질 이라는 뜻

#### ◼︎ 4강 구현결과
- 집중력게임(Concentration Game) 내 계산프로퍼티, indexOfTheOneAndOnlyFaceUpCard의 클로저, 익스텐션 활용 예시
- **클로져(Closure)와 익스텐션 등을 활용하여 훨씬 간결하고 직관적인 코드가 되었다.**
<div>
<img width="500" src="https://user-images.githubusercontent.com/4410021/63854110-54d66880-c9d7-11e9-9676-d0abb9bbb372.png">
</div>

<br>

## ♣︎ 총 정리
- Protocol의 역할과 사용방법
- Closure의 역할과 사용방법, 사용 시 주의사항
- Class vs Struct
  - mutating 역할 및 사용 유무
- Extension의 활용
- String
  - Array, String 인덱스의 차이점
- MVC Delegation패턴의 작동방식, 적용 예

<br>
<br>
<br>

# Lecture 5)
## 5강에서 배울 내용
- UIView의 초기화, 내부 프로퍼티
- Core Graphics 
  - CGPoint, CGFloat, CGSize, CGRect
- 열거형(enum)의 사용
- Any & AnyObject
- throws, try/do-catch 에러처리

### 에러 예외처리 방법, Thrown Errors
  - 예상 치 못한 에러를 어떻게 처리해야 할까?
- throws : 에러의 여지가 있음을 알려주는 키워드
  - 실행 중 에러의 여지가 있는 메서드의 경우 throws 키워드를 붙여 정의할 수 있다.
  - 사용 예시 ▼
~~~ Swift
func save() throws {
    //...
}

/// do 블럭 내에 error여지가 있는 작업에 try 실행을 한 후 예외 발 생 시 throw error를 실행
do {
    // try : 지금 작업은 오류가 날 여지가 있으니 try 해보자.
    try context.save()
       1) try! 를 사용 시 문제 없다면 정상적 값을 리턴 / 실행 간 문제 발생 시 앱이 강제종료 된다.
       try! context.save()
       2) try? 를 사용 시 문제 없다면 정상적 값을 리턴 / 실행 간 문제 발생해도 앱 종료 대신 nil반환으로 무시하고 넘어간다.
       try? context.save()
} catch let error {
       에러 발생 시 error는 Error 프로토콜인 NSError등이 적용 될 수 있다.
    throw error
}
~~~

<br>
<br>

## ♣︎ Any & AnyObject
- 사실 강타입언어인 Swift와 Any & AnyObject타입은 어울리지 않음
- **Any & AnyObject는 Objective-C, Swift 간 호환을 위해 존재**
  - 즉, Objective-C와의 하위호환을 위해 존재

<br>

#### ◼︎ Any
  - 어떠한 타입도 될 수 있음(클래스, 구조체, 열거형 등... 뭐든 가능, 어떤 타입일 지 알 수 없음)
  - Any 가 사용되는 메서드 예시 ▼
~~~ swift
// 스토리보드 UIViewController 세그 화면전환 전 실행 되는 메서드, prepare(for segue:,sender:)
// prepare 메서드를 발생시키는 존재가 어떤 객체인지 모르기 때문에 Any? 타입을 sender parameter로 사용
func prepare(for segue: UIStoryboardSegue, sender: Any?)
~~~
- **본 강의에서는 하위호환 API 호출을 제외하고 Any타입을 사용할 일이 없다.**

<br>

#### ◼︎ AnyObject
  - "클래스 타입에 한해서" 사용할 수 있는 Any타입

<br>

#### ◼︎ Any타입 변환 방법
- as?, as! 등을 통해 타입을 변경시킬 수 있다.

~~~ swift
let unknown: Any = ... // 현재 타입을 알 수 없기 때문에 사용이 불가능
// 옵셔널 바인딩을 통해 캐스팅이 되는지 확인
if let foo = unknown as? MyType {
    // MyType으로 타입 변환이 성공하면 해당 블럭을 실행할 수 있다.
}
// MyType으로 타입 변환이 실패하면 해당 블럭 실행하지 않는다.
~~~

<br>

~~~ swift
// ConcentrationViewController() 를 UIViewController로 할당해도 문제는 없다.
// ConcentrationViewController()는 UIViewController 를 상속한 객체이기 때문이다.
let vc: UIViewController = ConcentrationViewController()
// => 다만 ConcentrationViewController()의 기능인 flipCard() 등은 사용할 수가 없다.
//   => flipCard() 등을 사용하기 위해선 ConcentrationViewController 타입으로 변환하여 할당해야 한다.
if let cvc = vc as? ConcentrationViewController {
    // ConcentrationViewController타입으로서 실행되므로 ConcentrationViewController 프로퍼티 메서드인 flipCard() 사용이 가능
    cvc.flipCard(...) // Done.
}
~~~

<br>

#### ◼︎ NSObject
- **Objective-C 모든 클래스의 루트클래스**
- 해당 클래스를 상속해야 KVC(Key Value Coding), KVO(Key Value Observing)등의 Objective-C Runtime 기능 사용이 가능
- UIViewController등이 속한 **UIKit 내 모든 객체는 Objective-C에서 개발 -> NSObject을 루트클래스로 상속하고 있다.**
- 몇몇 API는 NSObject클래스를 요구하곤 한다.
- Swift의 Concentration과 같은 객체는 NSObject를 상속하지 않는다.

<br>

#### ◼︎ NSNumber
- 소수나 정수, Boolean 등 모든 숫자를 표현할 수 있는 클래스
- NSNumber 사용예시 ▼
~~~ swift
let num = NSNumber(35.5)
let num2: NSNumber = 35.5
// NSNumber타입은 intValue, doubleValue, boolValue 등 다양한 타입 변환 가능
let intified: Int = num.intValue
~~~

<br>

#### ◼︎ Date
- 1970년 기준 얼마나 흘렀는지, Date 데이터를 제공한다.
- 시간을 1/1,000,0000 단위로 측정
- 나라마다 표현하는 시간방식, 체계가 다르기 때문에 Date만으로 세부날짜를 표현하기는 힘들다.
  - 관련 클래스와 함께 사용하여 이 문제를 해결할 수 있다.
- 관련 클래스
  - Calendar
  - DateFormatter
  - DateComponents

<br>

#### ◼︎ Data
- URL등을 통해 얻어온 JSON, 이미지 등 데이터의 비트가방 역할을 한다.

<br>
<br>

## ♣︎ Views
- 좌표계로 구성되는 직사각형의 영역, UIView
- View들은 ViewController의 수많은 졸병과 같다.
- 최상위의 UIView는 UIViewController의 var view: UIView 이다.

~~~ swift
func setup() {
    //...
}

// UIView 초기화 방법
override init(frame: CGRect)

// 코드를 통해 UIView를 초기화 할때 사용
override init(frame: CGRect) {
    super.init(frame: frame)
    // ...
}
~~~

<br>
    
~~~ swift
// 외부 InterfaceBuilder의 스토리보드를 통해 UIView를 초기화 할때 사용
// coder는 UIView가 NSCoder 프로토콜을 구현하는데 필요하다.
required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    // ...
    setup()
}
~~~

<br>
    
- awakefromNib()
  - InterfaceBuilder file에서 나온 모든 객체들에게 보내진다.
  - InterfaceBuilder file에서 나온 View로 초기화 하는 방법 ex) Nib 파일 등...
  - * Nib은 Interface Builder 파일의 옛날 이름

<br>

### UIView 프로퍼티 변수
~~~ swift
// 현재 뷰의 상위 뷰를 반환한다. (상위뷰는 없을 수 있으므로 옵셔널 타입이다.)
var superView: UIView?

// 현재 뷰의 서브뷰들을 반환한다. (서브뷰는 여러개 있을 수 있으므로 배열타입이다.)
// * 배열의 첫번째 서브뷰가 제일 뒤에 있는 서브뷰이다.
var subViews: [UIView]

// 불투명 여부를 설정한다. 기본적으로 불투명(true)으로 설정되어있다.
var opaque: Bool

// 투명도를 설정할 수 있다. 0...1 범위 CGFloat 타입의 값을 지정 가능하다.
var alpha: CGFloat

// isHidden 프로퍼티를 통해 View Hierarchy 와 상관없이 뷰를 숨길 수 있다.(isHidden = true) 
var isHidden: Bool
~~~

<br>
    
    
### UIView 프로퍼티 메서드
~~~ swift
func addSubview(_ view: UIView) // 특정 서브뷰를 추가할 때 사용
func removeFromSuperview() // 슈퍼뷰로부터 뷰를 제거할 때 사용
~~~

<br>

### UIWindow
- iOS의 제일 꼭대기에 존재하는 window 객체
- UIView의 서브 클래스
- 외부 화면에 앱을 띄울때를 제외하고는 사용할 일이 별로 없다.

<br>
<br>

## ♣︎ CG Structures
- **Core Graphics Structures**의 약자.
- **좌표계 체계 데이터 구조 **(Coordinate System Data Structures)
- **코어 그래픽스는 4개의 타입**을 갖고 있다.
  - **CGFloat, CGPoint, CGSize, CGRect**
- CG(Core Graphics) 타입의 종속성
  - **CGFloat < CGPoint < CGSize < CGRect**

<br>

#### ◼︎ CGFloat
- **드로잉을 할 지점이 모두 부동 소수점으로 표현되는데, 이때 사용되는 타입이 CGFloat**이다.
- 드로잉 간 부동 소수점 좌표는 나타내는 기본 타입

~~~ swift
let cgFloat = CGFloat(aDouble)
~~~

<br>

#### ◼︎ CGPoint
- **두개의 CGFloat 기반 x, y를 구성**하는 구조체 타입
- **CGFloat기반으로 점의 위치를 나타내는데 사용**한다.
~~~ swift
// CGPoint는 x, y 두개의 CGFloat 타입 parameter 인자값을 받아 초기화 한다.
var point = CGPoint(x: 18.0, y: 36.0)
point.x += 20.0
point.y -= 16.0
~~~

<br>

#### ◼︎ CGSize
- **두개의 CGFloat 기반 width, height를 구성하는 구조체 타입**
- **크기(높이, 너비)를 나타내는데 사용**한다.
~~~ swift
// CGSize는 width, height 두개의 CGFloat 타입 parameter 인자값을 받아 초기화 한다.
var cgSize = CGSize(width: 120.0, height: 130.0)
cgSize.width += 42.5
cgSize.height = += 76.3
~~~

<br>

#### ◼︎ CGRect
- 점과 크기를 조합한 구조체 타입
  - **CGPoint, CGSize를 동시에 갖는다.**
~~~ swift
struct CGRect {
    var origin: CGPoint
    var size: CGSize
}

// CGPoint, CGSize타입의 두개 인자를 이용해 점과 크기 정보를 갖는 CGRect를 초기화 한다.
let rect = CGRect(origin: <CGPoint>, size: <CGSize>)
~~~

<br>

- CGRect 프로퍼티
~~~ swift
let rect = CGRect(origin: <CGPoint>, size: <CGSize>)
var minX: CGFloat // left 끝 x좌표를 반환
var midY: CGFloat // CGRect의 중간 y좌표를 반환
rect.intersects(CGRect) -> Bool // 특정 CGRect와 교차하고 있는지 여부를 반환
rect.intersect(CGRect) // 특정 CGRect와 겹치는 부분의 직사각형을 반환
rect.contains(CGPoint) -> Bool // 현재 CGRect가 인자값(parameter)로 받는 CGPoint를 포함하는지 여부를 반환
~~~

<br>
<br>

## ♣︎ 뷰 좌표계 시스템 View Coordinate System
- Origin은 좌측 상단에서 시작한다. (Origin is upper left)
- **좌표계의 단위는 CGPoint이다.**
  - 픽셀 단위가 아닌 소수점 단위 표현을 하는 CGPoint가 기준이다.
    - -> 픽셀단위보다 보다 섬세한 표현이 가능하다.(레티나 디스플레이 등에 사용 시 확연한 차이)
  - ✓ contentScaleFactor: CGFloat : 현재 사용중인 장치의 포인트 당 픽셀 수를 반환한다.
- frame, bounds
  - 뷰의 위치 기준을 설정할 때 사용한다.
  - UIView의 frame, bounds는 서로 크기가 다를 수 있다.
    - ex) UIView가 회전된 상태이면 bound < frame이 될 수 있음
  - 즉, 동 UIView의 frame, bounds가 서로 같을 필요는 없다.
<br>
<br>

#### ◼︎ bounds
- 현재 사용중인 뷰의 드로잉 좌표계 원점과 높이, 너비 등을 제공한다.
- **현재 뷰 기준의 좌표 기준, 액자틀**로 생각하면 이해하기 쉽다.

~~~ swift
var bounds: CGRect
~~~

<br>

#### ◼︎ frame
- **슈퍼뷰 기준으로 서브뷰가 어디에 위치하는지**를 제공한다.

~~~ swift
var frame: CGRect
~~~

<br>
<br>

## ♣︎ 뷰 그리기 Drawing View
- **뷰를 그리기 위해선 UIView 서브클래스와 override draw(CGRect)를 생성**하면 된다.
- **절대 draw(CGRect)를 직접 호출하지 않는다.**
  - ✓ draw를 사용하기 위해 대신 사용 가능한 메서드
    - **setNeedsDisplay()**
    - **setNeedsDisplay(_ rect: CGRect)**
      - 인자값(parameter)로 받는 CGRect는 최적화를 위해 쓰이는 사각형이다.(**현재의 사각형만 새로 드로잉 할 수 있도록**)

<br>
<br>

#### ◼︎ Core Graphics 적용 개념
- 1) 뷰에 그릴 내용을 얻는다.
- 2) 경로를 그린다. (외곽선, 상자(arc) 등...)
- 3) 드로잉 속성을 설정한다. (색상, 폰트, 텍스쳐, 선두께 등...)
- 4) 설정한 속성에 맞게 선과 색상을 드로잉한다.

<br>

#### ◼︎ UIBezierPath
- 선 굵기를 지정하거나, 테두리 그리기/채워넣기 등을 지원한다.
- **드로잉 과정은 draw(rect) 메서드 내에서 처리**한다.
- 1) 경로를 정의하기, Defining a KeyPath ▼
~~~ swift
// UIBezierPath 인스턴스를 생성한다.
let path = UIBezierPath()

// 경로를 움직인다.
path.move(to: CGPoint(80,50))
path.addLine(to: CGPoint(140,150))
path.addLine(to: CGPoint(10,150))

// 경로를 닫는다.
path.close()
~~~

<br>

- 2) 경로 설정 후 선과 색 속성을 설정한다. ▼
~~~ swift
// setFill(), setStroke() 메서드는 UIColor를 통해 사용한다.
// * green, red, blue, gray, loghtGray 등은 UIColor의 정적 변수이다.
UIColor.green.setFill()
UIColor.red.setStroke()

// UIBezierPath에서 선굵기를 설정한다.
path.linewidth = 3.0

// 테두리 션을 제외한 내부 색상을 드로잉한다.
path.fill()
// 설정한 테두리 선까리 드로잉한다.
path.stroke()
~~~

<br>

- UIBezierPath 기능
  - addClip() : 현재 뷰를 자르는데 사용한다.
- contains(_ point: CGPoint) -> Bool // 특정 point가 경로 내에 포함되는지 확인

<br>

#### ◼︎ UIColor
- UIColor를 통해 색상을 설정할 수 있다.
- UIColor또한 코어그래픽스 레이어 위에 좋어있기 때문에 CGColor를 반환하는 cgColor 프로퍼티를 지닌다.
- UIColor 사용 예시) ▼

~~~ swift
// green색상의 객체 할당
let green = UIColor.green
~~~

<br>

- UIColor 프로퍼티
  - yellow, red, green, blue, gray, lightGray 등의 색상 타입프로퍼티
    - withAlphaComponent(<알파값 0...1>) : 색상 타입프로퍼티에 다시 접근하여 알파값을 설정할 수 있다.
      - * 일반적으로 뷰는 Opacue(불투명) 으로 설정이 된다.
        - -> 투명하게 하려면 UIView의 프로퍼티인 var opaque = false 처리해야 한다. (인터페이스 빌더 설정가능)
  
- UIView 내 UIColor 프로퍼티
~~~ swift
// 해당 프로퍼티는 Concentration button에 적용한 적이 있다.
var backgroundColor: UIColor
~~~

<br>

## ♣︎ Layer
- **UIView의 애니메이션, 그림자효과, 테두리 등 많은 기능을 제공**하는 객체
- **UIView에서 사용하는 레이어 객체 클래스 명은 CALayer**

<br>

#### ◼︎ 텍스트 그리기 
- 일반적으로 텍스트를 화면에 띄울때 UILabel을 사용한다. 
- NSAttributedString
  - UIView의 draw(CGRect)에서 텍스트를 그리기 위해서 NSAttributedString을 사용한다. 
~~~ swift
let text = NSAttributedString(string: "hello") // 문자내용 이외의 세부 속성을 설정할 수 있다.
text.draw(at: aCGPoint)
let textSize: CGSize = text.size
~~~
<br>
  - 문자열 특정 영역의 문자 속성을 변경할 수 있다. 
    - NSRange값을 설정한 후 addAttribute(_, value:, range:) 메서드로 속성 설정

~~~ swift 
let pizzaJoint = "Cafe Pesto"
var attributedString = NSMutableAttributedString(string: pizzaJoint)

// NSRange 를 설정해 특정 영역의 문자를 설정할 준비를 한다. 
let firstWordRange = pizzaJoint.startIndex ..< pizzaJoint.indexOf(" ")!

// Range<String.Index> -> NSRange 변환 작업
let nsrange = NSRange(firstWordRange, in: pizzaJoint) 

// 원하는 영역(NSRange)의 문자 속성을 변경한다. 
attributedString.addAttribute(.strokeColor, value: UIColor.orange, range: nsrange)
~~~

<br>

#### ◼︎ UIFont
- UILabel, UIButton 등 UI에 사용가능한 폰트객체
- 제목 / 본문 / 각주 / 캡션폰트... 약 10가지의 폰트 종류를 제공한다.
~~~ swift
let font = UIFont(name: "Helvetica", size: 36.0)

// Now get metrics for the text style you want and scale font to the user's desired size ...
let metrics = UIFontMetrics(forTextStyle: .body) // or UIFontMetrics.default
let fontToUse = metrics.scaleFont(for: font)
~~~

<br>

- 시스템 폰트 System fonts
  - 버튼 같은 곳에서 주로 사용하는 폰트
~~~ swift
static func systemFont(ofSize: CGFloat) -> UIFont
static func boldSystemFont(ofSize: CGFloat) -> UIFont
~~~

<br>

  - **단, 사용자의 콘텐츠로 systemFont를 사용하는 것은 권장하지 않는다. 가급적이면 선호 폰트(preferred fonts)를 사용해라.**

<br>

#### ◼︎ 이미지 그리기
- UIImageView 
  - text를 담는 UILabel이 있었다면 image를 담는 UIImageView가 존재한다.
- UIImage
  - UIImageView에 담을 수 있는 이미지 객체
    - 불러온 이미지가 비트가방에 존재하는 지 확인 후 불러온다. (Optioanl Type)
  - 이미지 파일명으로 가져올 수 있다. 
~~~ swift
let image: UIImage? = UIImage(named: "foo") // Optional로 초기화, -> 해당 이미지데이터가 없으면 NIL
~~~

<br>

  - 파일 시스템에서 jpg, png... 등의 파일을 가져올수 있다.  

~~~ swift 
let image: UIImage? = UIImage(contentsOfFile: pathString)
let image: UIImage? = UIImage(data: aData) // raw jpg, png, tiff, etc... -> from image data 
~~~

<br>

- draw(CGRect) 에서 Image를 그리는 방법

~~~ swift
let image: UIImage = ... // the upper left corner put at aCGPoint
image.draw(at point: aCGPoint) // scales the image to fit aCGRect
image.drawAsPattern(in rect: aCGRect) // tiles the image into aCGRect
~~~

<br>

#### ◼︎ bounds 값이 바뀌었을때 다시 그려주나?
- 화면 회전 등으로 경계값이 바뀌었을 때 다시 그려주지 않는다. 
- 오토레이아웃 AutoLayout을 사용하면 되지만, 만약 오토레이아웃을  사용하지 않는다면??
- 다행히도, UIView 프로퍼티, contentMode로 이를 제어할 수 있다. 
- **UIViewContentMode**

~~~ swift
var contentMode: UIViewContentMode
~~~
<br>

  - 일부 비트 크기만 배치하는 방식 (비선호)
    - .left / .right / .top / .bottom / .topRight / .topLeft / .bottomRight / .bottomLeft / .center ...
  - 전체적인 비트 크기를 설정하는 방식 
    - 기본값은 scaleToFill, 새로운 공간에 상황에 따라 맞춘다. 
    - .scaleToFill / .scaleAspectFill / .scaleAspectFit / .scaleToFill ...
  - 리드로잉 Redrawing

  <br>

  #### ◼︎ layoutSubviews
  - **뷰의 경계가 바뀔 때 layoutSubviews() 메서드가 호출**된다. 
  - 오토레이아웃(Autolayout)을 사용하지 않을때 layoutSubviews() 를 사용한다. 

~~~ swift 
override func layoutSubviews() {
    super.layoutSubviews()
    // 새로운 경계값(new bounds)에 맞게 서브뷰의 frame들을 재배치할 수 있다.
}
~~~

<br>

#### ◼︎ enum(열거형) 활용 데모
- CustomStringConvertible 
  - 콘솔에서 문자열을 출력할 때 활용할 수 있는 프로토콜
<br>
<br>

## ♣︎ 5강 용어정리
* CustomStringConvertible : 콘솔의 특정 값 문자열을 보다 깔끔하게 출력하도록 지원하는 프로토콜
* opaque : 불투명한

<br>
<br>

## ♣︎ 5강 구현결과
<div>
 <img width=600 src="https://user-images.githubusercontent.com/4410021/64927100-472b3a80-d841-11e9-9376-c49825bed2b4.png"> 
 &nbsp  <img width=600 src="https://user-images.githubusercontent.com/4410021/64927101-47c3d100-d841-11e9-8713-32356812087c.png">
</div>

<br>

#### ◼︎ 열거형(enum)을 사용한 카드 덱 출력 예시
- 카드덱 정보 출력 시 CustomStringConvertible 프로토콜 적용 유무에 따른 콘솔 출력 차이를 보여준다. 
  - * CustomStringConvertible : 콘솔의 특정 값 문자열을 보다 깔끔하게 출력하도록 지원하는 프로토콜

<br>
<br>

## ♣︎ 총 정리
- Any & AnyObject 의미와 타입캐스팅을 통한 변수사용
  - Objc 간 호환을 위해 사용 
- throws, try/do-catch 에러처리
- UIView의 초기화방법, 프로퍼티 활용방법
- Core Graphics
  - **CGFloat, CGPoint, CGSize, CGRect**
- CGLayer
- View Drawing
  - setNeedsDisplay 
    - draw() 함수 호출이 필요할 때 사용
  - layoutIfNeeded
    - 뷰 윤곽이 변경될 때 호출
  - UIImage, NSAttributedString, UIFont...
- 열거형을 통한 카드 덱 출력 연습

<br>
<br>
