
# iOS With Stanford
iOS Study with Stanford Lection Study 6~10

<br>
<br>

# 목차

## [Lecture 6](https://github.com/applebuddy/iOSWithStanford#lecture-6-1)

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

 1) UIView에 제스처 인식기를 추가할 수 있다.

<br>

### UIPangestureRecognizer
 ~~~ swift

// iOS가 이동 제스처의 아울렛을 묶어서 뷰에 전달할 때 아울렛의 UIView를 전달하는데 이때 해당 UIView의 didSet이 작동한다.

 **@IBOutlet** **weak** **var** pannableView: UIView {

  **didSet** {

​    // 특정 gestureRecognizer를 정의하고 관련 이벤트 메서드를 지정한다.

​    **let** panGestureRecognizer = UIPanGestureRecognizer(

​      target: **self**, action: **#selector**(ViewController.pan(recognizer:))

​    )



​    // 그 후 실질적인 gestureRecognizer를 사용하기 위해 addestureRecognizer를 통해 해당 뷰에 제스쳐 인식기를 등록해야 한다.

​    pannableView.addGestureRecognizer(panGestureRecognizer)

  }

 }

 ~~~



 - UIPanGestureRecognizer에서 제공하는 3가지 메소드

~~~ swift

// tanslation(in:) : 이동제스처가 어디서 일어나고 있는지를 반환한다.

 **func** translation(in: UIView?) -> CGPoint



// velocity : 이동 제스처의 속도를 반환한다.

 **func** velocity(in: UIView?) -> CGPoint



// setTranslation : 이동이 가장 마지막 일어난 지점에서 얼마나 움직였는지를 반호나한다.

 **func** setTraslation(CGPoint, in: UIView?)

 ~~~



 <br>



// .possible(시작 전) .began(시작할때), .changed(연속적 제스쳐에 대해 변화할때), .ended(동작이 끝났을 때), .recognized(스와이프 등의 동작이 감지될때), .failed, .calcelled(동작 중 드래그, 드롭이벤트가 발생할 때 취소 이벤트가 자주 발생) 등의 상태를 알려준다.

 **var** state: UIGestureRecognizerState { **get** }



 ~~~ swift

// 제스쳐 상태에 따른 switch-case 문 사용 예시

 **func** pan(recognizer: UIPanGestureRecognizer) {

  **switch** recognizer.state {

  **case** .changed: **fallthrough**

  **case** .ended:

​    **let** translation = recognizer.translation(in: pannableView)

​    // update anything that dependes on the pan gesture using translation.x and .y

​    recognizer.setTranslation(CGPoint.zero, in: pannableView)

  **default**: **break**

  }

 }

 ~~~



 <br>



 ### UIPinchGestureRecognizer

 - 두 손가락으로 벌리고 줄이는 등의 동작 인식에 사용하는 객체

 - UIPinchGestureRecognizer의 프로퍼티

 ~~~ swift

// 원본 위치 대비 몇배로 줄이거나 확대했는지를 담는 프로퍼티

 **var** scale: CGFloat

// 1초당 속도를 반환하는 프로퍼티

 **var** velocity: CGFloat { **get** }

 ~~~



 <br>



 ### UIRotationGestureRecognizer

 - 두손가락으로 회전하는 제스쳐 인식에 사용하는 객체

 ~~~ swift

// UIRotationGestureRecognizer

// 원본대비 회전 값을 리디안으로 반환한다.

 **var** rotation: CGFloat

// 초당 회전속도를 반환한다.

 **var** velocity: CGFloat { **get** }

 ~~~



 <br>



 ### UISwipeGestureRecognizer

 - 스외아프 동작 제스쳐 인식에 사용하는 객체

 - 스와이프 동작이 시작하면 기존의 제스쳐는 .ended 상태가 된다.

 ~~~ swift

// UISwipeGestureRecognizer



// 스왑하고자하는 스와이프 위치를 담는다.

 **var** direction: UISwipeGestureRecognizerDirection

// 허용하는 손가락 갯수를 지정한다.(별도 설정)

 **var** numberOfTouchesRequired: Int

 ~~~



 ### UITapGestureRecognizer

 - 단순 터치에 반응하는 제스쳐 인식에 사용하는 제스쳐 객체

 ~~~ swift

// 몇개의 탭이 요구되는지를 지정

 **var** numberOfTapsRequired: Int

// 손가락 갯수 지정

 **var** numberOfTouchesRequired: Int

 ~~~



 ### UILongPressRecognizer

 - 길게 눌렀을때 반응하는 제스쳐 인식기 객체

 - 설정에 따라 누르는 동안 약간 움직여도 되게 할 수 있다.

 - 드래그 & 드롭도 LongPress를 사용한다.



 ~~~ swift

// 얼마나 잡고 있어야 인식하는지를 지정

 **var** minimumPressDuration: TimeInterval

// 손가락 몇개로 인식 시켜야 하는지를 지정

 **var** numberOfTouchesRequired: Int

// 길게 누르는 동안 허용하는 이동범위를 지정

 **var** allowableMovement: CGFloat

 ~~~



 <br>



<br>



### - 6강 용어정리



<br>



\### - 6강 구현결과

<div>

</div>



<br>



## ♣︎ 총 평

- Xcode 기본 인터페이스, 집중력게임 기본로직 개발



<br>

<br>
