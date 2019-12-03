# iOS With Stanford

- **iOS Study with Stanford Lection Study 6~10**

<br>
<br>

# 목차

## [Lecture 6](https://github.com/applebuddy/iOSWithStanford/blob/master/StudyMemo_6~10.md#lecture-6-1)
## [Lecture 7](https://github.com/applebuddy/iOSWithStanford/blob/master/StudyMemo_6~10.md#lecture-7-1)

## [Lecture 8](https://github.com/applebuddy/iOSWithStanford/blob/master/StudyMemo_6~10.md#lecture-8-1)

## [Lecture 9](https://github.com/applebuddy/iOSWithStanford/blob/master/StudyMemo_6~10.md#lecture-9-1)

## [Lecture 10](https://github.com/applebuddy/iOSWithStanford/blob/master/StudyMemo_6~10.md#lecture-10-1)

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

var velocity: CGFloat { get }

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

- MVCs를 구성하는 방법 종류
- 타이머의 사용방법
- UIView, UIViewController등 다양한 애니메이션 종류


### Multiple MVCs

- 텝바(TabBar), 네비게이션(Navigation) & 스플릿(Split) 뷰 컨트롤러

### 함께 작동하는 MVC들

- 앱 상에서는 수많은 Model, View, Controller 들이 함께 교류하며 작동한다. 
- 이번에는 **다른 MVC가 뷰가 되는 MVC를 만드는 방법에 대해 이야기** 한다. 
- 99%의 경우 아래의 세가지 컨트롤러 중 하나를 사용하게 될 것이다. 
  - UITabBarController
  - UISplitViewController
  - UINavigationController

<br>
<br>

## UITabBarController

- MVCs 에서 가장 간단한, 쉬운 형태의 ViewController
- 각 탭을 선택하면 그에 맞는 뷰가 나타난다. 
  - 이 때의 각각의 뷰는 각각의 MVC라고 할 수 있다. 
- 각각의 텝은 각각의 다른 MVC를 작동시키는 것이다. 
- 일반적으로 TabBarController에는 다섯 개 이상의 MVC를 사용하지 않는 것이 좋다.
  - 최대 5개까지가 적당한 UI배치를 이룰 수 있다. 



<br>
<br>


## UISplitViewController

- 두개의 MVC로 이루어져 있는 ViewController
- 왼쪽의 작은 MVC를 Master, 좌측을 Detail이라고 부른다. 
- iPad, iPhone Plus 등에서 작동한다. 
  - iPad, iPhone Plus의 landscape상태에서 masterView, detailView의 형태로 나타낼 수 있다. 
  - 이 중 iPhone Plus는 특히 portrait 상태에서는 detailView만 나오는 아이폰~아이패드 중간의 위치라고 할 수 있다. 
- 세로 모드(Land scape)에서는 Detail만 나타나고, Master MVC는 옵션으로 밀어내기 식으로 좌측에서 나오게 할 수 있다. 
- iPad에서만 완벽하게 동작할 수 있는것이 UISplitViewController 이다.

<br>



### SplitViewController Delegate 활용

- SplitViewController Delegate를 활용해서 초기 실행 시 SplitView의 화면을 masterView 혹은, detailView로 설정할 수 있다.

~~~ swift
// IB객체를 부를때 사용하는 awakeFromNib()
    override func awakeFromNib() {
        // splitViewController 델리게이트를 채택
        splitViewController?.delegate = self
    }
    
    // 만약 splitView의 masterView가 가리는것을 원치 않으면, true를 리턴, 가리는 것을 원한다면 false를 리턴한다.
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        if let concentrationViewController = secondaryViewController as? ConcentrationViewController {
            if concentrationViewController.theme == nil {
                // 만약 splitView가 한번도 설정되지 않은 상태라면, masterView로 덮는다.
                return true
            }
        }
        // 만약 splitView가 설정이 되어잇다면 masterView로 가릴 필요는 없다.
        return false
    }
~~~

<br><br>

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
<br>


## MVCs를 묶기

- 여러가지 MVCs 컨테이너를 선택해서 스토리보드에서 사용할 수 있다. 
  - *단축키 : 쉬프트+커맨드+L*
- 아니면 기존의 UIViewController를 선택 후 Xcode 상단 바의 Editor -> Embed in -> 을 통해 MVCs를 선택적으로 묶을 수 있다.
- 이때 embed in 처리 된 UIViewController는 rootViewController 가 된다. 



<br>
<br>


## Segue

- ViewController 간 화면전환에 사용하는 객체
  - Segue는 IB에서 구현하거나 코드로 구현할 수 있다. 
- **Segue는 항상 새로운 MVC 인스턴스를 만든다.**
  - 전에 사용한 MVC를 재사용하지 않는다.
  - UINavigationController의 NavigationItem 뒤로가기 버튼은 Segue가 아니다. 
    - 하단의 스택 요소로 돌아가는 것일 뿐, 새로운 MVC인스턴스가 생기는 것이 아니기 때문이다!

### Segue Identifier

- 수동으로 특정 Segue를 실행하고자 할때 사용하는 것이 Segue 식별자(Segue Identifier) 이다.
- 식별자는 nil이 되어선 안된다.(사용 시, 반드시 지정해주어야 한다.)

### Preparing For a Segue

- Segue를 실행하기 전 준비해야할 사항을 prepare 메서드에서 구현해 놓을 수 있다. 
- 즉, 새로운 MVC의 생성을 준비하기 위한 작업을 prepare(for segue: UIStoryboardSegue, sender: Any?) 에서 수행한다. 
- prepare 메서드를 통해 생성할 MVC에 특정 객체를 전달할 수도 있다.(sender: Any?)
- performSegue 실행 전 prepare 메서드 사용 예시▼

~~~ swift
func prepare(for segue: UIStoryboardSegue, sender: Any?) {
  if let identifier = segue.identifier {
    switch identifier {
      case "Show Graph":
      // segue.destination 을 통해 현재 준비하는 Segue의 목적지 ViewController를 접근할 수 있다. 
      // 정확한 특정 목적지 ViewController 객체에 전달하기 위해서는 UIViewController -> 특정 ViewController 클래스로 타입 캐스팅 처리를 해주어야 한다. 
      if let vc = segue.destination as? GraphController {
          // 접근한 목적이 ViewController에 특정 값을 전달하는 과정
          vc.property1 = ...
          vc.callMethodToSetItUp(...)
        // ✭ 해당 위치에서 get/set 설정이 되지 않은 목적지 viewController의 @IB 프로퍼티에 접근할 경우 오류가 발생할 수 있다. 
        }
      default: break
    }
  }
}

~~~



<br>



### preventing Perform Segue

- shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool 메서드를 통해 특정 조건이 충족되지 않았을때 Segue의 실행을 방지할 수도 있다. 

~~~ swift
func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool
~~~

<br>


### show Segue

- NavigationController에서 작동하는 Segue

### show Detail Segue

- SplitViewController의 Detail부분을 변경하는 Segue

### Modal

- 화면 전체를 차지, 화면은 MVC로 가득 채우는 Segue
- 앱이 멈춘 것 같은 상태에 빠질 수 있어(스택방식의 전환이 아님) 많이 사용하지는 않는다. 

### PopOver

- Modal과 비슷하지만 전체를 MVC로 꽉 채우는게 아닌 팝업이 뜨게 한다는 특정이 있는 Segue
- 기존의 뷰와 상호작용 할 수 없어 Modal처럼 사용에 주의가 따른다. 

<br>
<br>

## Timer

- 주기적으로 특정 코드를 실행할때 사용하는 타이머 객체

### 타이머의 사용

- scheduledTimer(withTimeInterval:, repeats:) { timer in ... } 의 사용 
  - 일정간격으로 특정 코드를 지정한 만큼 반복해서 실행한다.
- 타이머 변수앞에 weak를 사용하는 이유?
  - 타이머가 실행을 멈췄을 때 nil이 될 수 있다. 이러한 특성을 확인하기 위해 weak 키워드를 앞에 사용한다.

### 타이머의 종료

- invalidate() 를 사용해서 weak var timer 객체를 nil로 설정하면 종료할 수 있다. 

### 타이머 오차범위 설정

- tolerance를 통해 타이머의 오차범위를 설정할 수 있다. 
  - 오차 설정을 통해 타이머 사용 간 무리한 사용을 방지, 배터리 효율성을 증가시킬 수 있다.
- 타이머 자체가 1/10~1/100초 단위의 정확성을 갖고 있기때문에 tolerance를 0으로 설정한다고 정교한 타이머 간격 실행이 되는 것은 아니다. 

~~~ swift
// tolerance 사용예시)
myOneMinuteTimer.tolerance = 10 // in seconds
~~~

<br>

## Animation

### Kinds Of Animation

- ViewController 전환 애니메이션
- UIView 애니메이션에 사용될 수 있는 프로퍼티
  - 부모뷰 상대 좌표/ 중앙좌표, Frame/center
  - 내부 기준좌표, bounds
  - 회전, transform
  - 투명도, alpha(opacity)
  - 배경색, backgoundColor
- 코어 애니메이션(CA, Core Animation) -> 레이어 애니메이션 등 
- OpenGL, Metal과 같은 멋진 Full 3D 애니메이션
- SpriteKit : 슈퍼마리오같은 2.5D애니메이션 에 사용가능한 프레임워크
- Dynamic Animation : 물리기반(속도 탄성, 상호작용 등) 설정, 실행 애니메이션 기능

<br>


### - 7강 용어정리


<br>



### - 7강 구현결과
- 새로운 MVC 인스턴스를 생성하는 performSegue를 사용하지 않고, masterView의 타겟매서드를 이용해 가장 최근의 detailViewController 데이터를 저장, 새로운 masterView의 옵션 선택에도 초기화 없이 다른 테마로 게임을 이어갈 수 있게 된다. 
- 만약 UISplitViewController를 지원하지않는 iPhone+, iPad 이외의 기종은 만약 SplitViewController가 정상 작동 하지 않을경우) 
  - 1. 가장 최근 사용된 detailViewController 이미지 데이터를 masterView 내 concentrationViewController 프로퍼티에 별도 관리
  - 2. 테마가 변경되었을 때 기 저장된 masterViewController의 concentrationViewController.theme 정보를 detailViewController에 전달 
  - 3. navigationViewController의 pushViewController를 통해 해당 뷰에 이동함으로서 테마 변경시에 게임이 초기화되는 문제를 해결

### SplitViewController 지원여부에 따른 Segue 활용 & 데이터 처리 예시

~~~ swift
/// MARK: - Perform Segue
/// Segue의 Identifier를 사용해서 특정 Segue를 실행하여 화면 전환을 할 수 있다.
@IBAction func changeTheme(_ sender: Any) {
    // 스플릿뷰의 디테일 뷰 컨트롤러가 존재하는 지 확인
    if let splitDetailViewController = splitViewDetailConcentrationViewController {
        // 현재 타이틀 이름이 존재하는지 확인
        // 현재 주제에 맞는 배열을 디테일 뷰에 전달
        // ✭ PerformSegue를 통해 새로운 MVC 인스턴스를 생성한 것이 아닌, @IBAction 타겟메서드를 통해 디테일 뷰 컨트롤러에 접근함으로서 게임이 초기화 되지 않고 테마만 변경되게 할 수 있게 된다.
        if let themeName = (sender as? UIButton)?.currentTitle,
            let theme = themes[themeName] {
            splitDetailViewController.theme = theme
        }
    } else if let concentrationViewController = lastSeguedToConcentrationViewController {
        // splitViewController가 정상적으로 활성화 되지 않았을 경우, 캐싱되어있는 징중력게임 뷰컨트롤러가 존재하는지 확인하고 있다면 활용한다.
        if let themeName = (sender as? UIButton)?.currentTitle,
            let theme = themes[themeName] {
            concentrationViewController.theme = theme
        }
        navigationController?.pushViewController(concentrationViewController, animated: true)
    } else {
        // 주제 타이틀을 못할을 경우 예외처리 용으로만 performSegue를 사용하도록 설정한다.
        self.performSegue(withIdentifier: "Choose Theme", sender: sender)
    }
}
~~~

<br>

<div>

<img width="200" src="https://user-images.githubusercontent.com/4410021/68859914-b4692800-072b-11ea-8e9b-237f4e70db00.png"> &nbsp;
<img width="200" src="https://user-images.githubusercontent.com/4410021/68859916-b4692800-072b-11ea-96f1-84ca306911c9.png"> &nbsp;
<img width="200" src="https://user-images.githubusercontent.com/4410021/68859917-b4692800-072b-11ea-92c5-2bbb275bc087.png"> &nbsp;
<img width="200" src="https://user-images.githubusercontent.com/4410021/68859920-b501be80-072b-11ea-8239-7f6f8c77f639.png"> 

</div>



<br>



## ♣︎ 총 정리

- MVCs의 구성방법
  - UINavigationViewController
    - navigationItem
  - UISplitViewController
    - masterView
    - detailView
    - iPad/iPhone+/iPhone기종 별 지원에 따른 UISplitViewControlerDelegate를 통한 대응방법
  - UITabBarController
    - tabBarItem
- MVCs 내의 세부 viewController 접근방법
- Segue
  - Segue 종류
  - Segue 사용방법
- 타이머(Timer)
  - scheduledTimer(withTimeInterval:, repeats:) { timer in ... } 
  - invalidate()
  - tolerance()
  - timer에 weak 키워드를 추가하는 이유
- Animation의 종류
  - UIViewController 애니메이션
  - UIView 애니메이션
  - 애니메이션 프레임워크 종류
  

<br>
<br>



# Lecture 8) 

## ♣︎ 애니메이션 Animation

- UIView Animation
  - Frame / center : 뷰의 위치를 움직이게 하는 프로퍼티
  - bounds : 뷰를 움직이게 할 수 있는 프로퍼티
  - transform : 회전, 크기 변환 등 강력한 효과의 프로퍼티
  - alpha : 투명도 설정 프로퍼티
  - backgroundColor : 배경색 프로퍼티
- 애니메이션을 사용하는 방법
- UIView, UIViewController등 다양한 애니메이션 종류

<br>

### 애니메이션 동작 방식

- 일반적으로 특정 시간동안 어떠한 변환을 줄 지 정의 -> 클로저(UIViewPropertyAnimator)에서 해당 동작을 실행한다. 



## UIView Animation

- 세부 서브 뷰, 혹은 전체적인 뷰를 애니메이션 동작 수행할 수 있다. 



### UIView 애니메이션 구현 예시

- playingCard 뒤집기 애니메이션 동작 예시

~~~ swift
// playingCard 뒤집기 애니메이션 동작 예시
// 0.75초 간 palyingCard의 왼쪽 모서리를 잡고 뒤집는 효과의 애니메이션 수행 
UIView.transition(
  with: myPlayingCardView,
  duration: 0.75,
  options: [.transitionFlipFromLeft],
  animations: { cardIsFaceUp = !cardIsFaceup }
  completion: nil
)
~~~

<br>







<br>





## UIViewPropertyAnimator

- 애니메이션 동작에 사용하는 UIViewPropertyAnimator를 가장 쉽게 사용하는 방법

- **UIViewPropertyAnimator** 구성요소

  - **withDuration: TimeInterval**
    - 얼마나 애니메이션이 지속될지를 정의
  - **Dalay: TimeInterval**
    - 애니메이션 시작 전 얼마나 기다려야 하는지를 정의
  - **Options: UIViewAnimationOptions** 
    - 애니메이션 실행 방법 정의
  - **Animations: () -> Void** 
  - **Completion: ((position: UIViewAnimatingPosition) -> Void)? = nil** 
    - 애니메이션 종료 시점에 실행되는 핸들러
    - 매개변수인 position은 enum형태로 되어있음 (.end, .current 등... )
    - 종료시점은 중간종료, 완전종료 등의 상황이 있다. (보통 특정 속성값을 뒤늦게 바꾸는 애니메이션 쪽 이 우선순위로 동작한다. )

  ~~~ swift
  class func runningPropertyAnimator(
  	withDuration: TimeInterval, // 얼마나 지속될지를 정의
    delay: TimeInterval, // 애니메이션 시작 전 얼마나 기다려야하는지 정의
    options: UIViewAnimationOptions, // 애니메이션 실행 방법 정의
    animations: () -> Void, // animation은 인자를 받지도, 리턴하지도 않음
    completion: ((position: UIViewAnimatingPosition) -> Void)? = nil // 애니메이션 특정 시점에서(실행 완료, 진행중 중단 등) 실행
  )
  ~~~

<br>

- UIView Animation 사용 예시

~~~ swift 
// myView의 투명도가 1.0 이라면, 2초를 기다렸다가 3초간 천천히 투명도를 0.0으로 변화시키는 애니메이션을 실행한다. 
// 애니메이션 동작 중에도 유저 제스쳐 동작등은 허용된다. (options: [.allowUserInteraction])
// 애니메이션이 종료하면 myView를 슈퍼뷰로부터 제거한다. (myView.removeFromSuperview)
if myView.alpha == 1.0 {
  UIViewPropertyAnimator.runningPropertyAnimator(
  	withDuration: 3.0,
    dalay: 2.0,
    options: [.allowUserInteraction],
    animations: { myView.alpha = 0.0 },
    completion: { if $0 == .end { myView.removeFromSuperview() } }
  )
  print("alpha = \(myView.alpha)") // 애니메이션 실행 후의 값인 0.0을 출력
}
~~~

<br>



### UIViewAnimationOptions

- 애니메이션의 동작 옵션 값 지정 매개변수
- UIViewAnimationOptions 종류 
  - beginFromCurrentState
  - allowUserInteraction
    - 애니메이션 동작 간 유저 제스쳐를 허용
  - layoutSubviews
  - repeat
    - 무한으로 해당 애니메이션을 반복 실행 
  - autoreverse 
    - 순방향, 역방향으로 애니메이션을 실행 
  - overrideInheritedDuration
  - overrideInheritedCurve
  - allowAnimatedContent
  - curveEaseInEaseOut
    - 천천히 ~~ 빠르다가 ~~ 천천히 실행되며 종료
  - curveEaseIn
    - 천천히 시작 .... 점차 빠르게 실행되며 종료
  - curveLinear
    - 일정한 속도로 애니메이션이 실행 



<br>



## Dynamic Animation

- 물리적(밀도, 중력, 충돌 등... ) 애니메이션 수행
- **UIDynamicAnimator**를 사용

~~~ swift
// UIDynamicAnimator 사용방법
var animator = UIDynamicAnimator(referenceView: UIView)
~~~

<br>

### UIDynamicItem protocol

- 애니메이션 가능한 객체라면 채택해 사용할 수 있는 프로토콜

~~~ swift
protocol UIDynamicItem {
  var bounds: CGRect { get } // 아이템 사이즈
  var center: CGPoint { get set } // 아이템 위치
  var transform: CGAffineTRansform { get set } // 보통 회전(변환)
  var colllisionBoundsType: UIDynamicItemCollisionBoundsType { get set }
  var colliisionBoundingPath: UIBezierPath { get set } 
}

/// ... 만약 center나 transform 등을 설정하고자 한다면 UIDynamicAnimator의 아래 메서드를 사용한다. 
func updateItemUsingCurrentState(item: UIDynamicItem)
~~~

<br>

### Dynamic Animation Behaviors

- **UIGravityBehavior**

  - 실제 중력 값에 따라 작동하도록 가능하다.

  ~~~swift
  var angle: CGFloat // 각도, 라디안 기준, 0부터해서 시계방향으로 표현
  var magnitude: CGFloat // 규모, 1.0은 1000포인트/초/초
  ~~~

<br>

- UIAttachmentBehavior**

  - 부착 동작 행위
  - 쇠막대기 하나가 두 아이템 사이에 연결(부착)되어 있을때 막대기가 두 마이템을 연결하는 효과와 같음.
  - 만약 떨어져 바닥에 충돌하면 탄력있는 진자운동과 같은 효과를 낼 수 있음.

  ~~~ swift
  var length: CGFloat // 
  var anchorPoint: CGPoint // 
  ~~~

<br>

- UICollisionBehavior**

  - 경계선 충돌 동작 행위
  - 튀게 하는 등의 동작 효과 
  - 충돌 여부를 한 프레임에 한 번씩 확인한다. 
  - 충돌 상황을 감지하는 Delegate 가 존재한다. 

  ~~~ swift
  var translatesReferenceBoundsIntoBoundary: Bool //
  ~~~

<br>

- UISnapBehavior**

  - 동적 애니메이션을 사용할 때 어떻게 움직일지 결정할때 사용
  - 화면상 움직이다 멈추는 동작 보다 자연스럽게 설정할 수 있다.  

  ~~~ swift
  var damping: CGFloat // damping을 조절할 수 있음
  ~~~

<br>

- **UIPushBehavior**

  - 객체를 미는 동작 효과 구현에 사용 
  - 미는 동작의 크기, 각도 등을 조절할 수 있다. 

  ~~~ swift
  var mode: UIPushBehaviorMode // .continuous or .instantaneous
  var pushDirection: CGVector
  //.... ...
  var angle: CGFloat // 각도, 시계방향
  var magnitude: CGFloa // 규모, 1.0 -> 100 pts/s/s 
  ~~~

<br>

- UIDynamicItemBehavior

  - 메타 동작으로서 마찰, 탄성 ,회전 등의 동작을 지정할 수 있다.
  - colllisionBehavior나 gravityBehavior 같은 동작들을 모아서 한 동작으로 쓰일때 사용한다.  

  ~~~ swift
  var allowsRotation: Bool
  var frictino: CGFloat
  var elasticity: CGFloat
  var dynamicAnimator: UIDynamicAnimator? { get } // 애니메이션을 수행하는 객체 
  var action: (() -> Void)? // 해당 클로져는 UIDynamicBehavior가 작동할 때 항상 실행된다.
  // -> 애니메이션 속성에 따라 많은 호출이 있을 수 있으므로, action 클로저에 복잡한 코드를 넣을때는 주의가 필요하다. 
  ~~~

<br>

### 애니메이터의 정지 (Stasis)

- 애니메이션이 중단될 때를 UIDynamicAnimator's 델리게이트가 감지할 수 있다. 
- 

### 애니메이션 간 메모리 사이클의 방지

- removeBehavior()를 사용했을 때 메모리 사이클이 생길 수 있는 경우 예시▼

~~~ swift
if let pushBehavior = UIPushBehavior(items: [...], mode: .instantaneous) {
  pushBehavior.magnitude = ...
  pushBehavior.angle = ...
  pushBehavior.action = {
    // behavior 동작 자체를 제거
    pushBehavior.dynamicAnimator!.removeBehavior(pushBehavior)
  }
  animator.addBehavior(pushBehavior) // will push right away
}
// pushBehavior는 closure를 가리키고 있고, 
// closure는 또다시 pushBehavior를 가리키고 있기때문에 메모리 사이클이 발생한다. 
// 둘다 힙을 가리리고 힙에 머물러 있게 된다. 
~~~

<br>

### 클로저 캡쳐링 (Closure Capturing) 

- 클로저 내에서 메모리 사이클이 발생하는 현상을 말한다. 

#### 클로저 캡쳐링의 예)

~~~ swift
class Zerg {
	private var foo = {
    self.bar()
  }
  
  private func bar() { ... }
}
// Zerg는 foo 클로저를 메모리 안에 가지고 있는데 foo는 Zerg의 self 를 접근하고 있어 메모리 순환이 일어난다. 
~~~

<br>

#### 해결방법

- 클로저 시작점에 지역변수를 두어 활용할 수 있음 그때 앞에 "weak" 키워드를 넣어서 옵셔널로서 활용 가능
- weak으로 지정 된 변수는 heap에 저장되지 않기 때문에 메모리 순환을 방지할 수 있다. 
- weak 대신 unowned로 선언해서 메모리 캡쳐링을 대비할 수 있다.(대신 크래시가 날 수 있음)
  - 이로서 strong포인터가 self를 가리키지 않으므로, 힙에서 이를 잡아두지않는다.  그렇게 클로저 캡쳐링문제를 방지할 수 있는 것이다. 
    - weak, unowned 지정된 변수들은 ARC에서 관리하지 않음
    - weak는 옵셔널로서 존재하지 않을경우 실행을 하지 않는 식으로 클로져 캡쳐링 방지
    - unowned는 힙에 해당 멤버가 반드시 존재한다고 가정, 만약 힙에 해당 멤버가 없으면 크래시를 발생시킴으로서 클로져 캡쳐링 방지
- 클로저 내부 맨 처음에  **[weak self = self], [weak self] 등을 지정하면 메모리 순환을 방지할 수 있음**

~~~ swift
class Zerg {
  private var foo = { [weak weakSelf = self] in 
    // heap에서 weakSelf를 잡아두지 않는다. weak, unowned로 지정된 변수들은 힙에 저장하지 않는다. 
    weakSelf?.bar() // weakSelf는 Optional이기때문에 옵셔널 체이닝을 통해 접근한다. 
  }
  private func bar() { ... }
}
~~~

<br>

~~~ swift
var foo = { [weak x = someInstanceOfaClass, y = "hello"] in 
          	// x, y를 여기서 사용하면 됨.
          }
~~~

<br>

#### Weak, unowned의 용도

- weak나 unowned 지정 변수는 지역 변수가 아니더라도 힙에 저장되지 않는다.(힙에서 소유하지 않음) 

<br><br>

## PlayingCard Game Demo 

- 앱이 실행되면 자동으로 카드를 날리며 돌린다.  -> 도착하면 멈친다. 
- 새로운 카드를 돌리면 기존의 카드는 작아지고 아랫 여백에 카드가 추가된다. 
- 3개의 카드를 선택하면 카드가 뒤집히고 날라다니며 바뀐다. -> 새로운 카드로 바뀐다.






### - 8강 용어정리


<br>



### - 8강 구현결과

- 

<br>



## ♣︎ 총 정리

- **Animation**
- **Closure Capturing**



<br><br>



# Lecture 9) 

## ♣︎ 뷰 컨트롤러 생애주기, 스크롤뷰

- **ViewControlller LifeCycle, ScrollView**

<br>

## 뷰 컨트롤러 생애주기

- **ViewController LifeCycle**
  - **뷰컨트롤러의 생성 ~ 소멸 까지의 단계를 의미**
  - **생애주기 중 메모리가 부족할 경우 메모리를 비우라는 경고 신호가 호출**되기도 한다.

- **대부분의 뷰컨트롤러는 스토리보드를 통해 생성**된다. 
  - 그 이후 ViewController의 세그웨이, IBOutlet, IBAction 설정 등... 살을 붙인다. 
- **뷰컨트롤러 생애주기 메서드** (**볼드체가 ViewController 생애주기**, **일반적인 생성 -> 소멸 시 메서드 호출순서**)
  - **init(coder:)** - created via InterfaceBuilder
  - (awakeFromNib) -> 스토리보드로부터 UI객체 불러와 쓸 때 사용
  - **loadView** -> 코드로 구현 시 view를 지정해줄 수 있는 메서드
  - **viewDidLoad**
  - **viewWillAppear**
  - (viewWillLayoutSubviews / viewDidLayoutSubviews)
  - **viewDidAppear**
  - **viewWillDisppear**
  - (viewWillLayoutSubviews / viewDidLayoutSubviews)
  - **viewDidDisappear**
  - viewWillUnload / viewDidUnload 
    - **-> 둘다 필요없게 되면서 deprecated 처리 됨**
- **기하변경 등 작업 메서드 (layoutSubviews 호출 전/후 시점)** 
  - **viewWillLayoutSubviews**
  - **viewDidLayoutSubviews**
- **메모리 부족 시 호출 메서드**
  - **didReceiveMemoryWarning**
- **화면 전환 시 호출 메서드**
  - **viewWillTransition**

<br>



### loadView()

- **뷰컨트롤러 최상위 뷰의 load 메서드**
- **스토리보드 없이 코드로만 구현할 때, 커스텀 뷰를 이곳에서 지정해서 사용**할 수 있다. 

<br>

### viewDidLoad()

- **뷰컨트롤러의 프로퍼티 등을 초기화하기 좋은 생애주기 메서드**
- **각 뷰컨트롤러 일생에서 단 한번만 불리게 되는 메서드**
  - loadView() -> viewDidLoad()
  - 뷰컨트롤러가 메모리에 올라온 뒤에 호출** 된다.
- viewDidLoad()가 실행될때 아직 경계는 지정되지 않는다.**
  - **그러므로 화면의 크기와 관련된 것들을 해당 메소드에서 정의하면 안된다.** 
  - 그러므로 기하변경 관련 기능은 viewDidLoad()에 넣으면 안된다.
- **사용 시 super.viewDidLoad()를 붙여야 한다.** 

<br>

### viewWillAppear()

- **뷰컨트롤러의 뷰가 곧 화면에 나타날 시점에 호출되는 생애주기 메서드**
- **하지만 아직 뷰가 계층구조로 쌓이진 않은 시점**이다.
- **사용 시 super.viewWillAppear()를 불러야 한다.** 

<br>

### viewDidAppear()

- **뷰가 화면에 나타난 뒤에 호출되는 생애주기 메서드**
  - **표현할 뷰가 게층구조로 쌓이고 화면에 보여진 뒤 호출**되는 메서드
  - **뷰가 표시된 이후이므로 애니메이션, 타이머시작, 관찰 시작 등의 기능을 해당 메서드에서 구현**할 수 있다.
  - **뷰가 나타났으므로 이전 생애주기보다 비용이 비교적 큰 작업을 설정**할 수 있다. 
    - **네트워크 작업을 통한 뷰와의 교류작업 등의 고비용 작업 가능**

<br>

### viewWillDisappear()

- **뷰가 화면에서 사라지기 직전에 호출되는 생애주기 메서드**

<br>

### viewWillLayoutSubviews()

- **viewController의 최상위 뷰, self.view의 layoutSubviews 가 실행되기 직전에 호출**
  - **서브뷰가 이동하거나 경계가 바뀌는 등의 상황에서 layoutSubviews를 받게 된다.**
  - 기하변경 관련 기능을 적용하기 좋은 시점의 메서드

<br>

### viewDidLayoutSubviews()

- **viewController의 최상위 뷰, self.view의 layoutSubviews 가 실행된 이후 호출**
- 기하변경 관련 기능을 적용하기 좋은 시점의 메서드



- → 하지만, **viewWillLayoutSubview(), viewDidLayoutSubviews()는 많이 쓰이지 않는다. AutoLayout이 생겨서 따로 대체할 수단이 생겼기 떄문**이다.
  - **AutoLayout을 통해 설정하면 최상위 뷰의 layoutSubviews에서 자동으로 작업을 진행하기 때문**이다. 
  - 만약 **AutoLayout 대신 컨트롤러에서 기하변경 작업을 하고 싶다면, viewWillLayoutSubviews(), viewDidLayoutSubviews()를 사용**하면 된다.
- **viewWillLayoutSubviews(), viewDidLayoutSubviews()** 두개의 메서드는 **불필요한 호출이 많을 수 있으니 주의하여 사용해야하는 메서드**이다.
  - viewWillLayoutSubviews / viewDidLayoutSubviews 메서드의 경우 **뷰의 경계등이 그대로인데도 여러번 호출되는 경우가 발생 할 수 있다.**

<br>

### viewDidDisappear()

- **뷰가 화면에서 완전히 사라진 뒤 호출되는 생애주기 메서드**
- **MVC를 정리하기에 좋은 시점**

<br>

### didReceiveMemoryWarning()

- **대용량 메모리 누수 등으로 인해 메모리가 부족하게 되면 해당 메서드가 호출**될 수 있다.
- 해당 메서드에서 불필요한 메모리가 필요시 힙에서 해제할 수 있도록 작업을 설정할 수 있다.
  - **제대로 관리가 되지 않고, 메모리 누수가 지속되면 iOS는 앱을 강제로 종료시킬 수 있다! (물론 거의 일어날일은 없지만)**

<br>

### awakeFromNib()

- **super.awakeFromNib()을 붙혀 실행해야 한다.**

- **엄밀히 말하면 해당 메서드는 생애주기 메서드는 아님**
- **스토리보드로부터 UI 객체(뷰, 뷰컨트롤러 등...)를 불러올 때 사용하는 메서드**

- **아울렛 연결 전에 호출**된다.

<br>

### AutoRotation 

- **iOS에서는 자동회전기능을 제공**한다. 
  - 하지만 이에 따라 세부적인 레이아웃의 변경이 필요할 경우 커스텀 정의가 필요할 수 있다. 
- **viewWillTransition() 메서드를 통해 회전했을 때의 작업을 커스텀 정의를 할 수 있다.**

<br>

## ViewController LifeCycle Demo

- VCLLoggingViewControlller(Custom ViewController)를 대신 상속 후 ConcentrationGame의 뷰 컨틀롤러를 재설정
  - **뷰컨트롤러의 생애주기 로그 출력 연습**
  - **ViewController LifeCycle 출력 예시 ▼**

- **세그웨이 전환 시 이전 뷰는 이동한 뷰컨트롤러의 viewDidLoad() 메서드 호출 전에 Heap에서 제거**된다.
- **ViewController LifeCycle 로그 출력 예시 ▼**

<div> 
<img width=500 src="https://user-images.githubusercontent.com/4410021/69900906-9c94d380-13bc-11ea-8b82-aa96cacfef99.png"> 
</div>


<br>
<br>



## 스크롤뷰 ScrollView

### **ScrollView**

- **ScrollView는 매우 유용하게 사용될 수 있는 View**이다.
- **ScrollView는 안전 영역(Safe Area)에 대해 매우 똑똑한 UI**이다.
- **손가락으로 스크롤하고 확대/축소 등이 가능한 뷰**
- **ScrollView는 contentSize를 지정**해서 사용한다. 

~~~ swift
// 스크롤뷰의 contentSize를 지정하고 addSubview를 통해 subview를 추가할 수 있다.
scrollView.contentSize = CGSize(width: 3000, height: 2000)
logo.frame = CGRect(x: 2700, y: 50, width: 120, height: 180)
scrollView.addSubview(logo)
~~~

<br>

- contentOffset.x / contentOffset.y를 통해 contentSize 내의 스크롤뷰 위치를 알 수 있다. 

<br>

### ScrollView를 만드는 방법

- **Storyboard에서 UIView처럼 드래그해서 생성**할 수 있다. 
- **Embed In -> Scroll View 를 통해 생성**할 수 있다. 
- **addSubview를 통해 subViews를 ScrollView에 추가**할 수 있다.
  - **ScrollView에 addSubview를 해도 contentSize를 지정하지 않으면 화면에 보이지 않을 수 있다.** 
  - **contentSize가 지정이 제대로 되지 않으면 width=0, height=0의 공간에서 스크롤를 하는 꼴이 되기 때문**이다.
  - **이미지 or 뷰가 보이지만 이동이나 축소/확대 작업에 제한이 생긴다면 contentSize가 제대로 설정되어있지 않을 가능성**이 크다!

<br>

### **현재 ScrollView의 직사각형 화면 정보를 알 수 있는 방법**

~~~ swift
// 스크롤뷰에서 현재 보이는 화면의 CGRect값을 확인 할 수 있다.
// aerial.convert(scrollView.bounds, from: scrollView)
let visibleRect: CGRect = aerial.convert(scrollView.bounds, from: scrollView)
~~~

<br>

### 코드로 스크롤링 설정하기 

- **Scrolling Programmatically**

~~~ swift
// 스크롤뷰에서 특정 CGRect 위치를 보이도록 설정하는 코드 + 애니메이션 설정도 가능하다.
func scrollrectToVisible(CGRect, animated: Bool)
~~~

<br>

### 스크롤뷰 확대/축소하기

- **최소 ~ 최대 확대 범위 제약을 주는 방법 How Set Zooming Range**

~~~  swift
// minimumZoomScale, maximumZoomScale을 통해 ZoomIn / ZoomOut의 한도를 지정할 수 있다.
scrollView.minimumZoomScale = 0.5 // 0.5는 원본 사이즈의 절반 크기를 의미한다. 
scrollView.maximumZoomScale = 2.0 // 2.0은 원본 사이즈의 2배 크기를 의미한다. 
~~~

<br>

- **zoomToRect를 통해서도 특정 직사각형에 맞게 화면을 맞추며 축소 / 확대가 가능**하다.

<br>

### viewForZooming

- 스크롤뷰 내 특정 뷰 확대/축소 여부 설정하기

- viewForZooming(in scrollView: UIScrollView) -> UIView 를 사용한다.
  - 스크롤뷰의 의  delegate 지정을 한 뒤에 컨트롤러에서 사용 가능하다.
  - viewForZooming의 설정에 따라 확대/축소하는 뷰가 달라질 수 있다. 

~~~ swift
// viewForZooming 사용 예시
// Part of UIScrollViewDelegate Method
func viewForZooming(in scrollView: UIScrollView) -> UIView
~~~

<br>

### scrollViewDidEndZooming

- 스크롤 뷰 의 스크롤이 끝났을때를 감지하는 델리게이트 메서드
- 가령 **확대 or 축소 후에 Zooming이 끝나면 현재 보이는 화면을 선명하게 만드는 등의 처리를 scrollViewDidEndZooming에서 처리**할 수 있을 것이다.

~~~ swift
// Part of UIScrollViewDelegate Method
func scrollViewDidEndZooming(UIScrollView, with view: UIView, atScale: CGFloat)
~~~

<br>



## ScrollView Demo

- **ScrollView의 설정 예시**

~~~ swift
@IBOutlet var scrollView: UIScrollView! {
		didSet {
				scrollView.minimumZoomScale = 1 / 25 // 최소 축소는 1/25 크기까지 가능 
      	scrollView.maximumZoomScale = 1.0 // 최대 확대는 원본크기까지만 가능
      	scrollView.delegate = self // UIScrollViewDelegate 메서드 사용을 위해 델리게이트를 설정 (viewController 자기 자신, self가 scrollView의 델리게이트로 설정 됨)
      	scrollView.addSubview(imageView) // 스크롤뷰의 subView로 imageView를 추가
    }
}
~~~

- **MVC가 화면에 표시됐는지 확인하는 방법**
  - **view.window가 존재하는 지 확인한다.**

~~~ swift
// view.window를 체크하여 MVC가 화면에 보이는지 확인 하는 방법 예시)
/// 프로퍼티 감시자, imageURL
var imageURL: URL? {
  	didSet {
      	imageView.image = nil
      	// 현재 MVC가 화면에 표시되는지 확인하기 위해 view.window가 nil인지 체크한다. 
      	if view.window != nil {
          	// view.window가 nil이 아니라면 화면에 해당 MVC가 보임을 의미한다. 
          	fetchImage()
        }
    }
}

// MARK: - Life Cycle
override func viewDidAppear(_ animated: Bool) {
  	super.viewDidAppear(animated)
  	if imageView.image == nil {
      	// 만약 현재 이미지가 설정되어있지 않으면 fetchImage()메서드를 실행하여 이미지를 설정한다. 
      	fetchImage()
    }
}

override func viewDidLoad() {
  	super.viewDidLoad() {
      	if imageURL == nil {
						// url 설정이 되어있지않다면, stanford 이미지 관련 이미지의 URL을 불러와 할당한다.
          	imageURL = DemoURLs.stanford
        }
    }
}


private func fetchImage() {
  	if let url = imageURL {
      	// url이 정상적으로 존재하면, URL을 통해 데이터를 가져와 이미지를 설정한다. 
        // Data(contentsOf: URL)은 throws가 추가 정의되어 있으므로 try를 통해 접근한다. 
      	// Data 처리 시 오류가 발생하면...?)
           // 1) do + try + catch let 블럭을 통해 예외처리를 하거나...
           // 2) if let ... + try? 를 사용해서 nil을 할당하거나 예외 처리를 한다. 
            if let imageData = try? Data(contentsOf: url) {
              	imageView.image = UIImage(data: imageData)
            }
    }
  	
}
~~~

<br>

- **이미지 상태에 따른 스크롤뷰의  ContentSize 설정 예시)**

~~~  swift

// url은 셋팅이 되면 해당 url에 맞는 image를 fetchImage()를 통해 설정하도록 감시 프로퍼티로 정의된다.
var imageURL: URL? {
  	didSet {
      	imageView.image = nil
      	scrollView.contentSize = imageView.frame.size
      	if view.window != nil {
						fetchImage()
        }
    }
}

// UIImage 계산 프로퍼티, image
private var image: UIImage? {
  	get {
      	return imageView.image
    }
  
  	set {
      	imageView.image = newValue
        // 이미지를 셋팅할때마다 그에 맞게 imageView와 scrollView의 크기를 조정한다. 
      	imageView.sizeToFit() // imageView를 설정에 맞게 IntrinsicContentSize를 설정한다. 
      	scrollView.contentSize = imageView.frame.size // 갱신된 imageView Size에 맞게 스크롤뷰도 contentSize를 설정한다.
    }
}

private func fetchImage() {
  	if let url = imageURL {
      	let urlContents = try? Data(contentsOf: url)
      	if let imageData = urlContents {
          	image = UIImage(data: imageData)
        }
    }
}
~~~

<br>



- **viewForZooming(in scrollView:) 사용예시**

~~~swift
func viewForZooming(in scrollView: UIScrollView) -> UIView? {
    // scrollView의 subview인 imageView가 scrollView 확대, 축소기능의 적용대상이 된다.
		return imageView	
}
~~~

<br>





### 추가 iOS팁

- **UILabel, Button, Switch, TextField 등은 width, height에 대한 고유의 사이즈, Intrinsic Content Size가 존재**한다. 
  - **imageView, TextView 등은  content에 따라 content Size가 변화**한다.
  - **UIView는 Intrinsic Content Size를 갖고 있지 않는다.**
  - **Slider는 width 값만  Intrinsic Content Size를 갖는다.**
- **ImageView의 Intrinsic Content Size를 PlaceHolder로 커스텀 설정하며 이미지가 비어있을때 크기를 설정 하여 InterfaceBuilder가 ImageView의 크기를 인지하도록**할 수 있다. 

- **SizeToFit**
  - **sizeToFit은 스스로를  Intrinsic Content Size(고유 크기)로 지정하는 메서드**이다. 

<br>



### - 9강 구현결과
<div> 
<img width=500 src="https://user-images.githubusercontent.com/4410021/69900903-9bfc3d00-13bc-11ea-8954-46eab58ab2f9.png"> &nbsp;
<img width=250 src="https://user-images.githubusercontent.com/4410021/69900904-9c94d380-13bc-11ea-9f36-54aa12e3f81d.png"> 
</div>

<br>



## ♣︎ 총 정리

- **ViewController의 LifeCycle**
  - Init
  - **loadView, viewDidLoad, viewWillAppear, viewDidAppear, viewWillDisappear, viewDidDisappear**
- **상황에 따라 활용할 수 있는 주기 메서드**
  - **awakeFromNib : 스토리보드로부터 불러와 사용할 때** 
  - **viewWillTransition : 화면전환 시 호출되는 메서드**
  - **최상위 self.view의 layoutSubviews가 호출 되기 전/후 호출되는 메서드**
    - **viewWillLayoutSubviews / viewDidLayoutSubviews**
      - **기하변겅 등이 필요할 때 사용가능**하지만, **스토리보드의  AutoLayout이 생긴 뒤로 자주 쓰진 않는 메서드**
  - **메모리 부족 시 호출되는 메서드**
    - **didReceiveMemoryWarning**
    - **viewWillUnload / viewDidUnload의 deprecated **
      - **-> iOS6 이후로 시스템이 임의로 뷰의 헤제 등에 관여하지 않음**
- **ScrollView**
  - **contentSize**
  - **확대 / 축소가 가능한 뷰**
  - **생성 및 사용방법**
  - **ScrollViewDelegate**



<br><br>



# Lecture 10) 

## ♣︎ 멀티스레딩, 오토레이아웃

<br>

## 멀티스레딩

- **Multithrading**
- **iOS 앱 개발에서 매우 중요한 부분을 차지하는 기능**

<br>

## 스레드 (Thread)

- **iOS에서의 스레드는 실행스레드**를 말한다.
- **근본적으로 코드를 실행할 기회를 의미**한다.
- **멀티프로세서 or 멀티코어프로세서를 사용한다면, 병렬로 작동시키는 것이 가능**하다. 

<br>

## 디스패치 큐 (DispatchQueue)

- **iOS에서 멀티스레딩은 큐를 이용해 작동**한다. 
  - **여기서 말하는 큐는  FIFO방식의  큐(Queue)를 말하는 것**이다.


- **큐의 종류**
  - **직렬 큐 (Serial Queue)**
    - **하나의 큐 작업이 끝날때까지 기다리고 그 다음 다음 큐의 작업을 순차적으로 실행**한다. 
  - **병렬 큐 (Concurrent Queue)**
    - **큐에 접근해서 스레드를 꺼내어 실행**하는데 이때 **이미 다른 큐 작업이 진행중일때도 다른 다수의 작업을 동시에 실행**한다.

<br>

### 메인 큐 (Main Queue)

- **메인큐는 Serial Queue**이다.
  - **Serial Queue이므로 모두 하나의 스레드에서 실행**된다.
- **메인큐는 메인스레드 (Main Thread)에서 실행**된다.
- **UI를 실행하는 코드블록은 전부 메인큐에만 저장되어 처리**된다.
  - **UI를 처리하는 경우에는 반드시 메인 큐에서 작동되어야 한다.**

<br>

### 메인 큐 사용방법

~~~ swift
// DispatchQueue는 main이라는 정적 변수를 갖고 있다.
// main큐 사용 방식
let mainQueue = DispatchQueue.main

// * URLSession dataTask 처리등을 할때의 결과를 받는 블럭은 background에서 작동하므로 이곳에서 UI를 처리하기 위해서는 메인큐를 사용해야 한다. 
let session = URLSession(configuration: .default)  
if let url = URL(string: "http://stanford.edu/...") { // ► 0번째 순서 행
  	let task = session.dataTask(with: url) { (data: Data?, response, error) in  // ► 1번째 순서 행
    		
        // BACKGROUND TASK // ► 4번째 순서 행
        // 이곳은 background 이므로 UI처리를 위해서는 main 스레드에서 작동하도록 해야한다!!
				DispatchQueue.main.async { // ► 5번째 순서 행
          	// do UI stuff her // ► 7번째 순서 행
        }
				print("Did some stuff with the data, but UI part hasn't happened yet") // ► 6번째 순서 행
		}
    task.resume() // ► 2번째 순서 행
}

print("dont firing off the request for the url's contents") // ► 3번째 순서 행

// MARK: - Code 실행순서
// 1) take = session.dataTask... 가 바로 반환됨
// 2) task.resume()이 실행 -> 네트워크를 통해 URL 데이터를 전송 (Background에서 진행)
// 3) 맨 밑의 print("dont firing off the request for the url's contents") 행이 실행
// 4) 이 후, "// BACKGROUND TASK..." 행이 실행
// 5) BACKGROUND TASK 중 DispatchQueue.main.async { ... } 행이 실행 
      // but, 아직 Background이므로 메인큐 동작은 진행 안됨
// 6) print("Did some stuff with the data, but UI part hasn't happened yet") 행이 실행
// 7) ★ Background 동작이 실행되고, 메인큐가 여유롭게 되면 마지막으로 DispatchQueue.main.async의 코드블럭이 실행
// 단, 이 순서는 환경에 따라 바뀔 수 있음. 
~~~



<br>



### 글로벌 큐 (Global Queue)

- **Main큐 이외의 큐**
- **UI를 건드리지 않는 작업이면 글로벌 큐로 처리**할 수 있다.

<br>

### 글로벌 큐 사용방법

- **글로벌 큐는 다양한 서비스 품질 옵션(QoS, Quility Of Service)을 갖고 있다.**

~~~ swift
// 특정 qos옵선의 global 큐를 선언하는 방식
let backgroundQueue = DispatchQueue.global(qos: DispatchQos)

// QoS(Quility Of Service 종류)
DispatchQoS.userInteractive // 거의 사용하지 않음, 작은 작업을 짧고 빠르게 무언가 동작시키고자 할 때 사용
DispatchQoS.userInitiated // 가장 흔하게 사용함, 유자가 바로 요청하는 가능한 빨리 동작해야하는 작업들에 대해 사용
DispatchQoS.background // 유저가 바로 요청한 것은 아니지만, 가능할 빨리 완료되는 좋은 작업들에 사용
DispatchQoS.utility // 앱 아키텍쳐의 일부분으로서 실행되는 작업에 사용 (DB 작업 등)

~~~

<br>

### Queue 블록코드 사용방법

- **Async / Sync 를 통해 블록코드를 실행**시킬 수 있다.
- **Main Queue는 도중에 멈춰지는걸 원치 않으므로, main.sync는 사용하면 안된다!**

~~~ swift
queue.async { ... } // 비동기로 작동하는 async, 현재 진행중인 다른 동작과 함께 동작한다. 
queue.sync { ... } // 동기로 작동하는 sync, 큐에 블록을 넣으면 현재까지의 다른 동작은 해당 블럭이 실행될때까지 정지한다.
~~~



<br>

## Operation, OperationQueue

- **많은 병렬 프로세싱일 필요한 작업에 OperationQueue를 사용할 수 있다.**
- **병렬작업들은 서로 의존되는 경우가 많은데 Operation은 이러한 의존성을 설정해줄 수 있다.**

<br>

## MultiThreading Demo

- 멀티 스레딩 데모
- **DispatchQueue 사용 예시**

~~~ swift 
// DispatchQueue의 mainQueue / globalQueue 사용 예시
private func fetchImage() {
  	if let url = imageURL {
        // DispatchQueue 처리 과정에서 힙이 self 요소를 쓸데없이 붙잡고 메모리 사이클이 일어나는 것을 방지하기 위해 
        // [weak self]를 클로저 맨 앞에 정의하여 메모리사이클 요소를 사전 제거한다.
				DispatchQueue.global(qos: .userInitiated).async { [weak self] in 
						// UI요소가 아닌 데이터는 Global 큐에서 Background 처리가 가능하다.
        		let urlContents = try? Data(contentOf: url) 
						DispatchQueue.main.async {
                // UI요소는 메인스레드에서만 동작해야 한다.
                // url에 맞는 정확한 이미지 컨텐츠 설정을 위해 url와 imageData를 함께 확인한다.
              	if let imageData = urlContents, url == self?.imageURL {
                  	self?.image = UIImage(data: imageData)
                }
            }
 				}
    }
}
~~~

<br>

- **segue prepare 메서드에서 특정 목적지 뷰컨트롤러를 접근하는 방법**

~~~ swift
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
  	if let identifier = segue.identifier {
      	if let url = DemoURLs.NANA[identifier] {
          	if let imageVC = segue.destination.contents as? ImageViewController {
              	imageVC.imageURL = url
              	imageVC.title (sender as? UIButton)?.currentTitle
            }
        }
    }
}
~~~

<br>

### Activity Indicator View

- **네트워킹 동작 중 네트워킹 로딩 중임을 나타낼 수 있는 달팽이 동작 (Spinner Animation)**
- **스토리보드에서 Command + Shift + L + ActivityIndicatorView 선택 + 드래그로 꺼내어 사용**할 수 있다.

<br>

## 오토레이아웃 AutoLayout

- 이미 지금까지 스탠포드 강의 중 많은 AutoLayout의 활용을 했다.
- **InterfaceBuilder에서 뷰의 크기, 위치를 조정하고 Size Inspector에서 사이즈와 제약값을 수정 가능**하다.
- **오토레이아웃은 InterfaceBuilder에서 구현할 수 있지만 코드로도 구현 가능**하다.

<br>

### 오토레이아웃에 익숙해지기

- **오토레이아웃을 마스터하는데는 경험이 요구**된다. (Mastering Autolayout requires experience)
- **오토레이아웃은 직적 만지고 결과를 확인해보며 배우는 것이 좋다.**
  - 그렇기에 **Autolayout은 매우 중요한 요소이지만 경험이 필요**하다.

<br>

### **사이즈 클래스 Size Class**

- **기기 별 세로/가로에 대한 크기설정을 어떻게 할 수 있을까?**
  - **Solution? We can vary our UI based on its "size class"**
  - **size class에서 기기별 가로/세로 크기를 compact / regular로 분류**하여 알려준다.
  - **size class 기기의 가로 / 세로 너비에 따라 compact / regular로 분류**한다.

<br>

- **기기 별 Compact / Regular 크기 (알 : Regular, 컴 : Compact)**
  - **아이폰 : (세로)컴알 / (가로)컴컴**
  - **아이폰+ : (세로)컴알 / (가로)알컴**
  - **아이패드 : (세로)알알 / (가로)알알**
    - **다만 MVC환경에 따라 campact가 될 수도 있다.**
      - **ex) splitView's Master**

<br>



### UITraitEnvironment

- **앱에 대한 iOS 인터페이스 환경을 구성해줄 수 있는 메서드의 집합이 정의되어 있는 프로토콜**
- **UIScreen, UIWindow, UIViewController, UIPresentationController, UIView 등이 UITraitEnvironment 프로토콜을 채택해서 사용**한다.



<br>

### 사이즈 클래스의 사용

- **size class에 기반하여 무엇을 할 수 있을까? What can we do based on our size class?**
- **UI의 폰트와 같은 화면에 보여지는 프로퍼티를 크기에 따라 설정** 가능하다.
  - **제약(Constaint)들을 SizeClass와 묶어 설정할 수 있다.** 
    - **SizeClass에 따라 제약값이 다르게 설정 될 수 있는 것**이다.
- **Size Class 정보를 사용하는 방법 예시 ▼**

~~~ swift
// viewController 또한 UITraitEnvironment프로토콜을 채택하므로 
// -> traitCollection 프로퍼티를 접근 하여 SizeClass 정보를 얻을 수 있다.
let myHorizSizeClass: UIUserInterfaceSizeClass = traitCollection.horizontalSizeClass 

// 반환 값은 enum형태로 .compact / .regular (or .unspecified)등이 있다.
~~~

~~~ swift
// SizeClass 값에 따른 String 설정 예시)
// 높이가 .compact 상태일 경우 String text의 Flips, flipCount를 2행으로 표현, .compact 상태가 아닐 경우 1행으로 표현하는 코드 예시)
let attributedString = NSAttributedString(
		string: traitCollection.verticalSizeClass == .compact ? "Flips\n\(flipCount)" : "Flips: \(filpCount)"
)

// 커스텀한 String 속성을 filpCountLabel의 text 속성으로 적용
flipCountLabel.attributedText = attributedString
~~~

<br>

### AutoLayout Demo

- Concentration게임. Portrait 모드로는 문제없어보이지만....
  - **LandScape 상태에서 "Flips: X" 라벨이 보이지 않고, 카드의 길이가 부자연스럽다!**
    - **이 문제를 SizeClass 별 제약 설정으로 해결**해 본다. 
    

<div>
<img width=450 src="https://user-images.githubusercontent.com/4410021/69914041-f233b380-1482-11ea-8543-74940a99ae41.png"> &nbsp;
<img width=225 src="https://user-images.githubusercontent.com/4410021/69914042-f233b380-1482-11ea-8bb5-0f93517e558c.png">
</div>

<br>

- **속성인스펙터, AttributInspector의 속성 별 좌측에 '+' 버튼이 있는 것** 을 볼 수 있다. **이 버튼을 통해 Size 별 설정을 할 수 있다.**
  - **UI 속성들을 SizeClass별로 정의할 수 있는 것**이다.
  - **SizeClass별 속성을 추가하면 wC(width Compact), hC(height Compact), hR(height Regular) 등의 표시와 함게 속성이 추가되는 것을 확인**할수 있다.
    - **이를 통해 세로가 좁을때 일부 카드를 숨기거나, 세로가 넓을 때 추가 카드를 보이게 할수 있다.**

<br>

- **Document Outline을 통해 제약값의 세부 목록을 확인**할 수 있다. 
  - **InterfaceBuilder 좌측 하단에 Document Outline 창 버튼을 눌러 창을 좌측에서 띄울 수 있다.**
  - **현재 스토리보드 상태에 적용되는 제약값이 무엇인지를 목록의 제약값 밝기로 알 수 있다.**
    - **어두운것은 현재 SizeClass 상태에서 적용되지 않는 제약 값**이다.
<div>
<img width=500 src="https://user-images.githubusercontent.com/4410021/69914085-52c2f080-1483-11ea-8cde-ff002f2d33bc.png">
</div>


<br>

- **layoutSubviews가 호출 된 직후 시점인 viewDidLayoutSubviews에서 updateViewFromModel()을 호출하여 모델에 따른 뷰 갱신이 가능**하다.

~~~ swift
// viewDidLayoutSubviews 활용 예시)
override func viewDidLayoutSubviews() {
  	super.viewDidLayoutSubviews()
  	updateViewFromModel()
}
~~~

<br>

- **SizeClass가 변할때는 감지하는 방법**

~~~ swift
// SizeClass가 변할때마다 해당 메서드가 호출된다.
override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
  	super.traitCollectionDidChange(previousTraitCollection) 
  	// SizeClass가 변경될 때마다 이에 맞게 CountLabel의 내용을 갱신한다.
    updateFlipCountLabel()
}
~~~

<br>



### In Next Lecture11...

- **TableView**
- **CollectionView**
- **Drag and Drop**

<br>


### - 10강 구현결과
- **SizeClass 별 제약 설정으로 가로 / 세로 모드에서의 뷰배치가 보다 자연스럽게 되었다!**

<div>
<img width=250 src="https://user-images.githubusercontent.com/4410021/69914104-83a32580-1483-11ea-8faf-724c91b259f8.png"> &nbsp;
<img width=250 src="https://user-images.githubusercontent.com/4410021/69914105-83a32580-1483-11ea-979b-1006c52967d2.png">
</div>



<br>



## ♣︎ 총 정리

- **멀티스레딩 (Multithreading)**
  - **Main Queue**
    - **Main Queue는  Serial Queue**
    - **UI처리는  Main에서 처리해야한다.**
    - **Sync 사용하면 안됨**
    - **Async**
  - **Global Queue**
    - **Serial / Concurrent Queue**
    - **QoS**
      - **userInteractive**
      - **userInitiated**
      - **Background**
      - **Utility**
    - **Sync**
    - **Async**

<br>

- **오토레이아웃 (AutoLayout)**
  - **UITraitEnvironment**
  - **SizeClass**
    - **Compact / Regular로 분류하여 상황에 맞는 제약설정 가능**
    - **traitCollectionDidChange**

<br>
