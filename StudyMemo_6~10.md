# iOS With Stanford

iOS Study with Stanford Lection Study 6~10

<br>
<br>

# 목차

## [Lecture 6](https://github.com/applebuddy/iOSWithStanford#lecture-6-1)
## [Lecture 7](https://github.com/applebuddy/iOSWithStanford#lecture-7-1)

<br>
<br>
<br>

# Lecture 6) 

## ♣︎ 멀티터치, 제스쳐

- 오토레이아웃을 통한 뷰 갱신 원리
  - setNeedsDisplay
  - setNeedsLayout

- 멀티터치 및 제스처에 대한 CoreGraphic 동작 이해

- IBDesignable, IBInspectable 노테이션의 기능

 

### ▪︎ 멀티터치 Multi Touch

## Lecture6) Multi Touch

 우리는 모든 움직임을 감지할 수 있다. 스와이프, 확대/축소/ 이동, 탭 등의 감지를 말이다.

 iOS가 나타내는 제스처는 UIGestureRecognizer 객체와 관련이 있다.

 뷰에게 확대/축소나 탭을 인식하라고 부탁할 수 있다.

 스토리보드에서도 많이 사용하며, 필요 시 뷰 자체가 뷰 자신에게 인식을 요청할 수도 있다.

 일반적으로 UIView에 제스처 인식기를 추가해서 사용한다. 

<br>

### UIPanGestureRecognizer

 ~~~ swift
// iOS가 이동 제스처의 아울렛을 묶어서 뷰에 전달할 때 아울렛의 UIView를 전달하는데 이때 해당 UIView의 didSet이 작동한다.
// * panGestureRecognizer는 손가락을 떼지않고, 화면을 드래그하는 것을 의미한다. 
@IBOutlet weak var pannableView: UIView {

  didSet {

    // 특정 panGestureRecognizer를 정의하고 관련 이벤트 메서드를 지정한다.
    let panGestureRecognizer = UIPanGestureRecognizer(
            // 해당 팬 이벤트를 감지했을때 호출할 메서드를 정의한다.
      // * 이때의 타겟메서드는 Objc의 동적 특성을 이용하므로 @objc 키워드를 명시해서 지정해야 한다. 
      target: self, action: #selector(ViewController.pan(recognizer:))

    )
    // 그 후 실질적인 panGestureRecognizer를 사용하기 위해 addestureRecognizer를 통해 해당 뷰에 제스쳐 인식기를 등록해야 한다.
    pannableView.addGestureRecognizer(panGestureRecognizer)

  }

 }

 ~~~



 - UIPanGestureRecognizer에서 제공하는 3가지 메소드

~~~ swift

// tanslation(in:) : 이동제스처가 어디서 일어나고 있는지를 반환한다.

func translation(in: UIView?) -> CGPoint


// velocity : 이동 제스처의 속도를 반환한다.

func velocity(in: UIView?) -> CGPoint


// setTranslation : 이동이 가장 마지막 일어난 지점에서 얼마나 움직였는지를 반호나한다.

func setTraslation(CGPoint, in: UIView?)

~~~



 <br>



#### 제스쳐 인식에 따른 상태 확인

- .possible(시작 전) .began(시작할때), .changed(연속적 제스쳐에 대해 변화할때), .ended(동작이 끝났을 때), .recognized(스와이프 등의 동작이 감지될때), .failed, .calcelled(동작 중 드래그, 드롭이벤트가 발생할 때 취소 이벤트가 자주 발생) 등의 상태를 알려준다.

~~~ swift
var state: UIGestureRecognizerState { get }
~~~

 ~~~ swift
// 제스쳐 상태에 따른 switch-case 문 사용 예시

func pan(recognizer: UIPanGestureRecognizer) {

  switch recognizer.state {
     // .changed 상태가 바뀌었을 때
  case .changed: fallthrough
    // .ended 이벤트가 종료되었을 때 
  case .ended:
    let translation = recognizer.translation(in: pannableView)

    // update anything that dependes on the pan gesture using translation.x and .y

    recognizer.setTranslation(CGPoint.zero, in: pannableView)

  default: break
  }
 }

 ~~~

 <br>

- 상태에 따른 UI 처리 예시

~~~ swift
/// Tap Gesture Recognizer 의 IBAction 메서드를 지정하여 사용할 수 있다.
    @IBAction func flipCard(_ sender: UITapGestureRecognizer) {
        // 한번 카드를 터치하면 카드가 앞면->뒷면 or 뒷면->앞면으로 뒤집힌다.
        // 이때 sender의 상태에 따른 세부 설정을 sender.state를 통해 할 수 있는 것이다.
        switch sender.state {
        // 탭 제스쳐 인식기가 끝나는 시점에 카드가 뒤집어 진다.
        case .ended:
          // playingCardView.isFaceUp은 프로퍼티 감시자로써, 값이 변경되면 상태에따라 didSet 블럭에서 UI를 변경 시킨다. 
            playingCardView.isFaceUp = !playingCardView.isFaceUp
        default: break
        }
    }

/// -> playingCardView.isFaceUp 값 변경에 따른 설정 구현 예시)
@IBOutlet var playingCardView: PlayingCardView! {
        didSet {
            // * target 메서드의 경우 obcj기반으로 되어있으므로 @objc를 표시해 주어야 문제없이 사용이 가능하다.
            // swift에서 구성하더라도 objc는 함께 돌아가고 있다. swift에서 objc로 타겟 메서드를 전달하기 위해 @objc가 필요한 것이다.
            let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(nextCard))
            swipeGestureRecognizer.direction = [.left, .right]
            // 정의한 제스져 인식기를 playingCardView 뷰에 등록한다.
            playingCardView.addGestureRecognizer(swipeGestureRecognizer)

            // 핀치 제스쳐에 대한 인식기, 셀렉터를 설정한다.
            let pinchGestureRecognizer = UIPinchGestureRecognizer(target: playingCardView, action: #selector(PlayingCardView.adjustFaceCardScale(byHandlingGestureRecognizedBy:)))
            playingCardView.addGestureRecognizer(pinchGestureRecognizer) œ
        }
    }
~~~







 ### UIPinchGestureRecognizer

 - **두 손가락으로 벌리고 줄이는 등의 동작 인식**에 사용하는 객체

 - UIPinchGestureRecognizer의 프로퍼티

 ~~~ swift
// 원본 위치 대비 몇배로 줄이거나 확대했는지를 담는 프로퍼티

var scale: CGFloat

// 1초당 속도를 반환하는 프로퍼티

var velocity: CGFloat { **get** }

 ~~~



 <br>



 ### UIRotationGestureRecognizer

 - 두손가락으로 회전하는 제스쳐 인식에 사용하는 객체

 ~~~ swift
// UIRotationGestureRecognizer
// 원본대비 회전 값을 리디안으로 반환한다.
var rotation: CGFloat

// 초당 회전속도를 반환한다.
var velocity: CGFloat { get }

 ~~~



 <br>



 ### UISwipeGestureRecognizer

 - 스외아프 동작 제스쳐 인식에 사용하는 객체

 - 스와이프 동작이 시작하면 기존의 제스쳐는 .ended 상태가 된다.

 ~~~ swift
// UISwipeGestureRecognizer
// 스왑하고자하는 스와이프 위치를 담는다.
 var direction: UISwipeGestureRecognizerDirection

// 허용하는 손가락 갯수를 지정한다.(별도 설정)
 var numberOfTouchesRequired: Int

 ~~~



 ### UITapGestureRecognizer

 - 단순 터치에 반응하는 제스쳐 인식에 사용하는 제스쳐 객체

 ~~~ swift
// 몇개의 탭이 요구되는지를 지정

var numberOfTapsRequired: Int

// 손가락 갯수 지정

var numberOfTouchesRequired: Int

 ~~~



 ### UILongPressRecognizer

 - 길게 눌렀을때 반응하는 제스쳐 인식기 객체

 - 설정에 따라 누르는 동안 약간 움직여도 되게 할 수 있다.

 - 드래그 & 드롭도 LongPress를 사용한다.



 ~~~ swift
// 얼마나 잡고 있어야 인식하는지를 지정

var minimumPressDuration: TimeInterval

// 손가락 몇개로 인식 시켜야 하는지를 지정

var numberOfTouchesRequired: Int

// 길게 누르는 동안 허용하는 이동범위를 지정

var allowableMovement: CGFloat

 ~~~

 <br>



## @IB Notation 종류 

 ### **@IBDesignable**

 - 인터페이스 빌더에서 @Idesignable을 통해 디자인을 미리 확인할 수 있다.
 - 앱실형을 굳이 하지 않고 빌드만 해도 인터페이스빌더에서 그 결과를 확인할 수 있다.

- @IBDesignable 사용예시)

~~~ swift
@IBDesignable
class PlayingCardView: UIView {
  /// PlayingCardView 코드 구현...
  /// -> 빌드 시 InterfaceBuilder에서 시각적인 결과를 확인 할 수 있음
}
~~~



<br>



### @IBInspectable

- 인터페이스 빌더의 우측 Atribute Inspecteor에서 변수를 커스텀으로 조작할 수 있게 해주는 노테이션, 
- @IBInspectable 사용예시)

~~~ swift
// - 인터페이스 빌더의 우측 Atribute Inspecteor에서 변수를 커스텀으로 조작할 수 있게 해주는 노테이션, @IBInspectable
    @IBInspectable 
// 카드의 랭크, 이미지에 따른 레이아웃 변경을 정의하고 있다. (setNeedsDisplay(), setNeedsLayout())
    var rank: Int = 11 { didSet { setNeedsDisplay(); setNeedsLayout() } }
    @IBInspectable
    var suit: String = "❤️" { didSet { setNeedsDisplay(); setNeedsLayout() } }

    // 카드가 뒷면일 경우 별도의 드로잉은 필요가 없다.
    @IBInspectable
    var isFaceUp: Bool = true { didSet { setNeedsDisplay(); setNeedsLayout() } }
~~~

<br>

### 뷰 갱신

- setNeedsDisplay() -> 시스템이 UIView의 draw() 메서드를 호출하여 뷰를 다시 그린다. 
- setNeedsLayout() -> 시스템이 UIView의 layoutSubviews()를 호출하여 뷰를 다시 그린다.
- layoutSubviews() -> 뷰가 갱신될 때 호출되는 메서드 

<br>

### Transform(Affine) 변환

- transform은 아핀(affine) 변환이라고도 한다.
  - 비트 단위의 변환을 하며, Affine은 크기, 평행이동, 회전 등을 나타낸다.
  - CGAffineTransform.identity.rotated를 통해 절반 회전시키면 위 아래의 라벨을 평행회전으로 뒤집어 배치할 수 있다.
    * CGFloat.pi를 사용해 회전하기 제한되는 이유 -> 회전축이 최 좌상단에 있기 때문
    * -> translatedBy + rotated 조합으로 회전축을 우측하단으로 위치조정(translatedBy) 후, 해결 가능

~~~ swift
// CGAffineTransform, CGPoint 조절로 이미지을 뒤집어 배치하는 예시 
lowerRightCornerLabel.transform = CGAffineTransform.identity
            .translatedBy(x: lowerRightCornerLabel.frame.size.width, y: lowerRightCornerLabel.frame.size.height)
            .rotated(by: CGFloat.pi)
        lowerRightCornerLabel.frame.origin = CGPoint(x: bounds.maxX, y: bounds.maxY).offsetBy(dx: -cornerOffset, dy: -cornerOffset)
            .offsetBy(dx: -lowerRightCornerLabel.frame.size.width, dy: -lowerRightCornerLabel.frame.size.height)
~~~

<br>


### - 6강 용어정리



<br>



### - 6강 구현결과

<div>


</div>



<br>



## ♣︎ 총 정리

- 멀티터치, 핀치, 패닝, 탭 제스쳐 등의 동작 원리 이해 
- UIView의 갱신 그려지는 원리
  - layoutSubviews
  - setNeedsDisplay
  - setNeedsLayout


<br>
<br>


# Lecture 7) 

## ♣︎ 멀티 MVC, 타이머, 애니메이션

- 



## Multiple MVCs

- 텝바(TabBar), 네비게이션(Navigation) & 스플릿(Split) 뷰 컨트롤러

## 함께 작동하는 MVC들

- 앱 상에서는 수많은 Model, View, Controller 들이 함께 교류하며 작동한다. 
- 이번에는 **다른 MVC가 뷰가 되는 MVC를 만드는 방법에 대해 이야기** 한다. 
- 99%의 경우 아래의 세가지 컨트롤러 중 하나를 사용하게 될 것이다. 
  - UITabBarController
  - UISplitViewController
  - UINavigationController

### UITabBarController

- MVCs 에서 가장 간단한, 쉬운 형태의 ViewController
- 각 탭을 선택하면 그에 맞는 뷰가 나타난다. 
  - 이 때의 각각의 뷰는 각각의 MVC라고 할 수 있다. 
- 각각의 텝은 각각의 다른 MVC를 작동시키는 것이다. 
- 일반적으로 TabBarController에는 다섯 개 이상의 MVC를 사용하지 않는 것이 좋다.
  - 최대 5개까지가 적당한 UI배치를 이룰 수 있다. 

## UISplitViewController

- 두개의 MVC로 이루어져 있는 ViewController
- 왼쪽의 작은 MVC를 Master, 좌측을 Detail이라고 부른다. 
- iPad, iPhone Plus 등에서 작동한다. 
- 세로 모드(Land scape)에서는 Detail만 나타나고, Master MVC는 옵션으로 밀어내기 식으로 좌측에서 나오게 할 수 있다. 
- iPad에서만 완벽하게 동작할 수 있는것이 UISplitViewController 이다.



## UINavigationController

- **MVC 중 가장 유연하고 강력한 MVC**
- 가장 초기의 ViewController를 rootViewController 라고 부른다. 
- iOS앱에서 가장 자주 볼 수 있는 MVCs
- **카드 스택방식**으로 **MVC를 push, pop하며 화면을 구성**한다. 
  - 새로운 뷰로 전환되면 이전의 뷰를 새로운 뷰가 덮는 구조
- 각종 타이틀, 버튼을 가진 navigationItem, toolBarItem을 갖고 있다.

~~~ swift
// visibleViewController로 가장 위에 나타난 UIViewController를 알아낼 수 있다. 
~~~





<br>



### Sub-MVCs에 접근하기

- MVCs의 viewControllers 프로퍼티에 접근 해서 세부 viewController에 접근할 수 있다. 

  

~~~ swift
var viewController: [UIViewController]? { get set } // 옵셔널상태일 수 있음
// 보통 left to right 배열 구조로 구성되어 있음

// UIViewController는 다양한 프로퍼티를 통해 어떤 MVCs 컨테이너에 속하는지 확인할 수도 있다.
// 실질적으로 해당 ViewController가 어디에 속하는지에 상관없이 아래의 프로퍼티를 전부 활용할 수 있다. 
var tabBarController: UITabBarController? { get }
var splitViewController: UISplitViewController? { get }
var navigationController: UINavigationController? { get }

// 옵셔널 체이닝 접근을 통한 특정 컨테이너의 뷰컨트롤러 유무 확인 예시)
if let defail: UIViewController? = splitViewController?.viewControllers[1] { ... }


~~~

<br>



### MVCs를 묶기

- 여러가지 MVCs 컨테이너를 선택해서 스토리보드에서 사용할 수 있다. 
  - *단축키 : 쉬프트+커맨드+L*
- 아니면 기존의 UIViewController를 선택 후 Xcode 상단 바의 Editor -> Embed in -> 을 통해 MVCs를 선택적으로 묶을 수 있다.
- 이때 embed in 처리 된 UIViewController는 rootViewController 가 된다. 

~

<br>

## Timer

<br>

## Animation




### - 6강 용어정리



<br>



### - 6강 구현결과

<div>



</div>



<br>



## ♣︎ 총 평

- 멀티터치, 핀치, 패닝, 탭 제스쳐 등의 동작 원리 이해 
- UIView의 갱신 그려지는 원리
  - layoutSubviews
  - setNeedsDisplay
  - setNeedsLayout

<br>
<br>
