# iOS With Stanford

iOS Study with Stanford Lection Study 6~10

<br>
<br>

# 목차

## [Lecture 6](https://github.com/applebuddy/iOSWithStanford/blob/master/StudyMemo_6~10.md#lecture-6-1)
## [Lecture 7](https://github.com/applebuddy/iOSWithStanford/blob/master/StudyMemo_6~10.md#lecture-7-1)

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



### Dynamic Animation Behaviors

- **UIGravityBehavior**

  - 실제 중력 값에 따라 작동하도록 가능하다.

  ~~~swift
  var angle: CGFloat // 각도, 라디안 기준, 0부터해서 시계방향으로 표현
  var magnitude: CGFloat // 규모, 1.0은 1000포인트/초/초
  ~~~

- **UIAttachmentBehavior**

  - 부착 동작 행위
  - 쇠막대기 하나가 두 아이템 사이에 연결(부착)되어 있을때 막대기가 두 마이템을 연결하는 효과와 같음.
  - 만약 떨어져 바닥에 충돌하면 탄력있는 진자운동과 같은 효과를 낼 수 있음.

  ~~~ swift
  var length: CGFloat // 
  var anchorPoint: CGPoint // 
  ~~~

- **UICollisionBehavior**

  - 경계선 충돌 동작 행위
  - 튀게 하는 등의 동작 효과 
  - 충돌 여부를 한 프레임에 한 번씩 확인한다. 
  - 충돌 상황을 감지하는 Delegate 가 존재한다. 

  ~~~ swift
  var translatesReferenceBoundsIntoBoundary: Bool //
  ~~~

- **UISnapBehavior**

  - 동적 애니메이션을 사용할 때 어떻게 움직일지 결정할때 사용
  - 화면상 움직이다 멈추는 동작 보다 자연스럽게 설정할 수 있다.  

  ~~~ swift
  var damping: CGFloat // damping을 조절할 수 있음
  ~~~

- **UIPushBehavior**

  - 객체를 미는 동작 효과 구현에 사용 

  ~~~ swift
  var mode: UIPushBehaviorMode // .continuous or .instantaneous
  var pushDirection: CGVector
  //.... ...
  var angle: CGFloat // 각도, 시계방향
  var magnitude: CGFloa // 규모, 1.0 -> 100 pts/s/s 
  ~~~

  


### - 7강 용어정리


<br>



### - 7강 구현결과

- 

<br>



## ♣︎ 총 정리

- <br>
  <br>

