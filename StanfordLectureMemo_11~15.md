# iOS With Stanford

- **iOS Study with Stanford Lection Study 6~10**

<br>
<br>

# 목차

## [Lecture 11](https://github.com/applebuddy/iOSWithStanford/blob/master/StudyMemo_6~10.md#lecture-11-1)


<br>
<br>
<br>

# Lecture 11) 

## ♣︎ Drag/Drop, UITable/UICollectionView

- **Drag and Drop**
- **UITableView and UICollectionView**

 

## Drag and Drop

- **주변의 데이터를 움직이는데 적합한 상호운용 방식**
- 드래그 드롭은 기기의 동작에 방해받지않으며 수행할 수 있다.
- UIView와 관련되었다. Gesture가 UIView와 관련된 것과 같은 원리이다. 
- **Drag & Drop은 비동기적으로 작동**한다.



### 드래그 시작하기

- **사용자가 드래그 제스쳐를 하면, itemsForBeginning 델리게이트 메서드가 호출**된다. 

~~~ swift
// dragInteraction(itemsForBeginning) 델리게이트 메서드
func dragInteraction(_ interation: UIDragInteraction, itemsForBeginning session: UIDragSession) -> [UIDragItem]
~~~

<br>

- dragInteraction 메서드에서 반환하는 **UIDragItem은 itemProvider를 갖고 있다.**
  - **itemProvider는 드래그 된 데이터를 제공하는 역할**을 한다. 
    - **NSItemProvider를 사용해 DragItem을 생성하여 사용 가능**하다.

~~~ swift
// dragItem은 NSItemProvider를 갖고 있다. 
let dragItem = UIDragItem(itemProvider: NSItemProvider(object: provider))
~~~

<br>

### 드래그의 추가

- **드래그 한 루트 중간에 또다른 드래그가 적용 되면 itemsForAddingTo 델리게이트 메서드가 호출**된다.
  -  **메서드의 반환값은 비어있거나 요소 하나만 존재할 수도 있다.** 
    - **비어있을 경우는 시작, 추가 DragItem 모두 없는 경우, 드래그할 것이 아무것도 없는 경우를 의미한다.**

~~~ swift
// 드래그가 추가되었을 때 호출되는 메서드로 반환되는 배열은 하나만있거나 비어있을 수도 있다. 
func dragInteraction(_ interaction: UIDragInteraction, itemsForAddingTo session: UIDragSession) -> [UIDragItem]
~~~

<br>

### 드래그의 수용

- **드래그를 처리할지에 대한 판단을 하는 canHandle 델리게이트 메서드**

~~~ swift
// Bool값을 반환하며 드래그를 처리할지에 대한 판단을 결정한다. 
func dropInteraction(_ interaction: UIDripInteraction, canHandle session: UIDragSession) -> Bool {
  	return true
}
~~~

- 이때의 드래그 허용 여부 판단을 위해 UIDragSession을 활용해서 특정 객체를 받을 수 있는지를 체크할 수 있다. 

~~~ swift
// NSAttributedString 타입을 제공 받을 수 있나요?
let stringAvailable = session.canLoadObjects(ofClass: NSAttributedString.self)
// UIImage 타입을 제공 받을 수 있나요?
let imageAvailable = session.canLoadObjects(ofClass: UIImage.self)
~~~



### 드래그 세션의 업데이트 감지

- **canHandle 델리게이트 메서드 단계에서 수용이 되었다면 sessionDidUpdate를 통해 UIDragSession값이 업데이트 됨을 감지**할 수 있다. 
- **UIDropProposal 을 반환하며 이 객체는 3가지의 판단을 결정**할 수 있다. 
  - **.copy**
    - **해당 드롭 아이템의 복사**
  - **.move**
    - **해당 드롭 아이템의 이동**
  - **.cancel** 
    - **해당 드롭의 취소**

~~~ swift
// UIDragSession 갱신 시 호출되는 델리게이트 메서드
func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDragSession) -> UIDropProposal {
		return UIDropProposal(operation: .cancel)
}

// UIDropProposal의 3가지 결정 방식
UIPropProposal(operation: .copy/ .move/ .cancel)
~~~

<br>



### 드롭의 수용

- **만약 UIDropProposal로 .cancel을 선택하면, 손가락이 화면에서 떨어질 때 performDrop을 얻는다.**

~~~ swift
// UIDropProposal로 .cancel을 선택 시 손가락이 화면에서 떨어질 때 performDrop을 얻는다. 
func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
}
~~~



### 드롭 시 객체 로드

- **drop을 했을때 받고싶은 클래스를 지정하고 다룰 수 있다.**
  - **AttrubutedString, Color, URL, Image 등 다양한 객체를 다룰 수 있다.** 
  - **이때 전달받는 객체는 Drag Resource로부터 비동기적으로 전달받아 처리**하게 된다.

~~~ swift
session.loadObjects(ofClass: NSAttributedString.self) { theStrings in 
		// 지정한 타입, dropped NSAttributedString에 대해 불어와서 처리를 할 수 있다.
}
~~~

<br>



### Session을 통한 드래그 위치 식별

- **터치 위치를 확인하기 위해서는 session.location(in: view) 를 사용**하면 된다.

~~~ swift
session.location(in: view)
~~~

<br>



## Drag & Drop Demo

- **새로운 앱을 통해 Drag & Drop을 구현 (EmojiArt)**

  - **이모티콘을 선택하고 드롭하고 배치하는 등의 예제 앱**

- **가장 먼저 할 것은 EmojiArt Document Background 생성을 위해 Drag & Drop을 허용하는 것**

  



















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
