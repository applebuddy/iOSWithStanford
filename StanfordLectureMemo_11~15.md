# iOS With Stanford

- **iOS Study with Stanford Lection Study 6~10**

<br>
<br>

# 목차

## [Lecture 11](https://github.com/applebuddy/iOSWithStanford/blob/master/StudyMemo_11~15.md#lecture-11-1)


<br>
<br>
<br>

# Lecture 11) 

## ♣︎ Drag/Drop, UITable/UICollectionView

- **Drag and Drop**
  - **드래그 & 드롭**
- **UITableView and UICollectionView**
  - **테이블뷰 & 컬렉션뷰**

 

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

  

- **Xcode Tip**
  - **Interface Builder의 Document Outline**
    - **스토리보드에서 포커싱하기 어려운 세부 뷰의 경우** **좌측의 Document Outline의 뷰 계층 목록을 활용하면 쉽게 해당 뷰에 대한 작업**을 할 수 있다.
      - **ex) 여러개의 뷰 케층에 묻여있는 세뷰 뷰들, 쉽게 커서로 포커싱 하기 어려운 뷰들**
    - **Document Outline의 목록에서 control을 눌러 에디터에 드래그하면 스토리보드와 마찬가지로 @IBOutlet, @IBAction등의 메서드를 생성할 수 있다.** 

~~~ swift
import UIKit

class EmojiArtViewController: UIViewController, UIDropInteractionDelegate {
  	// dropZone UIView에 Interaction을 추가한다.
    // addInteraction 메서드 사용을 위해서는 UIDropInteractionDelegate 프로토콜을 채택해야 한다. 
  	@IBOutlet weak var dropZone: UIView! {
      	dropZone.addInteraction(UIDropInteraction(delegate: self))
    }
  
  	// NSURL타입과 UIImage타입을 모두 얻을 수 있으면 true, 없으면 false를 반환하는 canHandle Delegate Method
  	func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
				return session.canLoadObjects(ofClas: NSURL.self) && session.canLoadObjects(ofClass: UIImage.self)
    }

  	// session이 업데이트 되었을때 드롭 시 결정을 .copy로 설정하여 드롭 아이템을 복사하도록 설정한다. 
  	func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
      	return UIDropProposal(operation: .copy)
    }

  	// 드래그를 통해 설정에 따라 원하는 데이터를 받아오고 드롭을 했을때 해당 메서드가 호출 된다. 
    // 처리를 원하는 타입은 NSURL, UIImage 두가지 이므로 두가지에 대한 loadObjects 클로저를 처리한다. 
  	func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
      	imageFetcher = ImageFatcher() { (url, image) in 
        		// 해당 부분은 메인큐에 존재하는 영역이 아님      
						DispatchQueue.main.async {
              	self.emojiArtView.backgroundImage = image 
            }
				}
      
        // NSURL type에 대한 loadObjects Closure
      	session.loadObjects(ofClass: NSURL.self) { nsUrls in 
						if let url = nsUrls.first as? URL {
                selfimageFetcher.fetch(url)              
            }

				}
      
      	// UIImage type에 대한 loadObjects Closure
      	session.loadObjects(ofClass: UIImage.self) { images in 
						if let image = images.first as? UIImage {
              	self.imageFetcher.backup = image 
            }
				}
    } 	
  
  	@IBOutlet weak var emojiArtView: EmojiArtView!
}
~~~

<br>



## UITableView & UICollectionView

- 테이블뷰와 컬렉션뷰
- **UIScrollView는 바운딩 되지 않는 범위에서 정보를 확대/축소하여 보여주었었다.**
- **테이블뷰, 컬렉션 뷰는 UIScrollView와는 다른 방식으로 정보를 표현**한다.
  - **하지만 테이블뷰, 컬렉션 뷰가 사용하는 API는 매우 유사**하다. 

<br>

## UITableView

- **정보를 섹션과 행 등으로 이루어진 긴 리스트를 통해 제공하는 View**
- **리스트는 섹션과 행으로 나뉠 수 있다.**
  - **행은 섹션별로 나뉘어 각각의 그룹으로 나뉘어 표현될 수 있다.**
- **테이블 뷰는 간단한 4가지 스타일이 존재**한다.
  - 컬렉션뷰는 이러한 스타일이 존재하지 않는다. 

- **서브 타이틀로 간단한 세부 정보(left detail / right detail)를 추가로 보여줄 수 있다.**
- **테이블 뷰도 커스텀 스타일로 지정하여 사용가능하다.**
  - **ex) 사용자 정의 UITableViewCell**

<br>

### UITableView Styles

- **Grouped**
  - **정적인 형태의 테이블정보를 표현할 때 주로 사용**한다. 
  - **섹션별로 고정적인 정보를 표현**한다. 
- **Plain**
- **Inset Grouped**



<br>



### Static TableView

- **한정된 고정 데이터를 표현할때 Static TableView를 사용**할 수 있다.
  - **ex) 앱 환경설정 기능 등...**
- **AttributeInspector -> Static Cells + Grouped Style로 사용**한다.

- **간단하게 표현**되여 자주 사용된다.
- **각 섹션 별 헤더(Header), 푸터(Footer)를 가질 수 있다.**

- **Static TableView의 섹션 별 행 추가방법**
  - **Document Outline의 섹션을 클릭 후 AttibuteInspector에서 행의 갯수(rows) 설정**



### TableView 세그웨이 사용

- **UITableView의 AttributeInspector -> Assessory -> Detail Disclosure를 선택하면 테이블 셀 우측에 버튼이 생긴다.** 
  - **일반 셀 영역 or Detail Disclosure 영역 등에 세그웨이를 붙어 화면전환에 활용** 할 수 있다.
  - **세그웨이 추가를 원하는 영역을 Control + 클릭 후 드래그 하여 화면전환을 원하는 뷰컨트롤러에 높으면 세그웨이 옵션을 선택 가능**
    - 이후 세그웨이 별 식별자 지정을 하는 등 방식은 기존 세그웨이 구현방식과 동일
- **UIStoryboardSegue 식별자 별 세그웨이 실행 예시 ▼**

~~~ swift
func prepare(for segue: UIStoryboardSegue, sender: Any?) {
  	if let identifier = segue.identifier {
      	switch identifier {
          	case "XyzSegue": // XyzSegue일경우 해당 case가 실행 될 것이다. 
          	case "AbcSegue": //......
            //...
            default: break
        }
    }
}
~~~

<br>

### 특정 셀에 대한 IndexPath값 반환하기

~~~ swift
func prepare(for segue: UIStoryboardSegue, sender: Any?) {
  	if let identifier = segue.identifier {
      	switch identifier {
          	case "XyzSegue": // XyzSegue일경우 해당 case가 실행 될 것이다. 
          	case "AbcSegue": 
          			if let cell = sender as? MyTableViewCell,
                  let indexPath = tableView.indexPath(for: cell) {
                      // 현재 포커스 된 셀의 IndexPath값을 식별해서 해당 셀 위치의 데이터를 다른 곳에 넘겨주는증의 처리가 가능하다. 
                    	let seguedToMVC = segue.destination as? MyVC {
                        	// 선택한 셀의 세그웨이 목적지에 맞는 데이터를 전달할 수 있다. 
                        	seguedToMVC.publicAPI = data[indexPath.section][indexPath.row]
                      }
                  }
            //...
            default: break
        }
    }
}

~~~



<br>

<br>

## UICollectionView

- **보통 2차원적인 방법으로 정보를 보여주 일반적으로 FlowLayout을 이용해 정보를 표현**한다.
  - **FlowLayout은 간단히 텍스트라고 생각하면 된다.**
    - **정보를 나열하다가 공간이 없으면 다음 줄로 물흐르듯 넘어가며 정보를 표현**한다. 
    - **표현되는 정보는 각기 다른 크기와 형태를 보일 수도 있다.**
    - **필요에 따라 커스텀 FlowLayout을 정의하여 컬렉션뷰 레이아웃으로 정의가능** 하다.
- **별도의 스타일이 없으며, 컬렉션뷰의 모든 셀은 전부 커스텀으로 이루어진다.**
- **컬렉션뷰도 섹션을 가질 수 있어 섹션 별로 아이템을 분류하여 표현할 수 있다.** 
- 테이블뷰와 달리 컬렉션뷰의 헤더/푸터뷰는 만들기 좀더 어렵다.
  - **테이블뷰처럼 String(titleForHeaderInSection Method in UITableViewDataSource) 만으로 타이틀을 설정 불가능**



<br>



### CollectionView 세그웨이 사용

- **UICollectionViewDelegate Method의 활용**

~~~ swift
func collectinoView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: IndexPath) {
  	// 이 곳에서 performSegue(withIdentifier:)를 사용하는 방법이 있다. 
  	.... 
}
~~~



<br>

<br>

### UITableView, UICollectionView 생성방법

- **스토리보드에서 Command + Shift + L -> 테이블뷰 or 컬렉션뷰를 드래그하여 스토리보드에 배치 가능**
  - **순수 테이블뷰, 컬렉션뷰에 셀을 추가할 수 있다.**
  - **Prepackaged 테이블뷰 컨트롤러, 컬렉션뷰 컨트롤러를 생성할 수 있다.**
    - **뷰 자체가 테이블뷰, 컬렉션뷰로만 이루어진 MVC가 필요하다면 사용 가능**
- **코드로도 구현가능**하다.

<br>

<br>

## UITableView, UICollectionView 데이터처리

### UITableView, UICollectionView 데이터 표현방법

- **UITableView, UICollectionView는 View이므로 자신이 변수로 데이터를 갖고 있을 수 없다.** 
  - **대신 델리게이션(Delegation) 같은 방식으로 데이터를 요청**하게 된다.
    - **ex) UITableViewDelegate, UITableViewDataSource...**
    - **컬렉션뷰와 테이블뷰에서 어떤 시점에 어떤 데이터가 보여져야하는지 등을 정의할 수 있다.**

- **dataSource & delegate의 설정**

~~~ swift
// MARK: UITableView, UICollectionView의 프로토콜 변수
// In UITableView ...
var dataSource: UITableViewDataSource
var delegate: UITableViewDelegate

// In UICollectionView ...
var dataSource: UICollectionViewDataSource
var delegate: UICollectionViewDelegate
~~~

<br>



### UITableView, UICollectionView UI 데이터 갱신방법

- **reloadData, reloadRows** 등이 이다.
- **reloadData**
  - **테이블뷰/컬렉션뷰가 가지고 있는 모든 데이터를 다시 갱신**한다. 
  - **전체적으로 갱신하므로 비교적 무거운 메서드**
- **reloadRows**
  - **테이블/컬렉션뷰의 특정 row/item에 대해 갱신**한다.

~~~ swift
// reloadData : 테이블뷰가 가지고 있는 모든 데이터를 다시 갱신한다. 
// 비교적 무거운 메서드이다. 
func reloadData()

// reloadRows : 특정 행들에 대해서만 갱신할 수 있는 메서드
func reloadRows(at indexPaths: [IndexPath], with animation: UITableViewRowAnimation)
~~~

<br>

<br>

## UITableView 프로토콜 메서드

- **UITableViewDataSource Method**
  - **numberOfSecions** 
    - **섹션의 갯수를 지정**
  - **numberOfRowsInSection**
    - **섹션 별 행의 갯수를 지정**
  - **titleForHeaderInSection**
    - **섹션 별 헤더뷰 타이틀을 지정**
  - **cellForRowAt**
    - **각 위치의 셀 선택 및 데이터를 지정**

~~~ swift
// 테이블 뷰 섹션의 갯수를 지정한다. default 값은 1
func numberOfSections(in tableView: UITableView) -> Int

// 한개의 섹션에 몇개의 행이 존재하는 지 지정한다. 
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int 

// titleForHeaderInSection : 섹션 별 헤더뷰의 타이틀을 지정
func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?

// cellForRowAt : 각 위치의 셀 별 데이터를 표현하는데 사용한다. 
// cellForRowAt 메서드 사용 예시 ▼
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let myCell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as? MyTableViewCell else { return UITableViewCell() }	
  	myCell.textLabel?.text = food(at: indexPath)
  	myCell.detailTextLabel?.text = emoji(at: indexPath)

  	// myCell.configureCell()
  	return myCell // 설정한 Cell을 반환
}

// ... 이 외에도 다양한 메서드가 존재
~~~

<br>

- **UITableViewDelegate Method**
  - **heightForRowAt**
    - **행의 높이를 지정할 때 해당 델리게이트 메서드를 사용**한다. 
    - **InterfaeBuilder에서 스토리보드로 설정하는 방법도 있다.**
  - estimatedRowHeight
    - 테이블뷰에게 셀이 스크린에 있지 않을때 이정도 크기로 가정하라고 알려주는 것

~~~ swift
// 행의 높이를 지정하는 UITableViewDelegate Method
func tableView(UITableView, estimated/heightForRowAt indexPath: IndexPath) -> CGFloat {
  	return {행의 높이}
}

// ... 이 외에도 다양한 메서드가 존재
~~~



<br>

<br>



## UICollectionview 프로토콜 메서드

- **UICollectionViewDataSource Method**
  - **numberOfSections**
    - **섹션의 갯수를 지정**
  - **numberOfItemsInSection** 
    - **섹션 별 아이템의 갯수를 지정**
    - **테이블뷰(row)와 달리 컬렉션뷰의 셀 단위는 Item**이다.
  - viewForSupplementaryElementOfKind
    - **특정 위치의 헤더 설정 등(SupplementaryElement)에 사용**

~~~ swift
// numberOfSections : 컬렉션 뷰 섹션의 갯수를 지정한다. default 값은 1
func numberOfSecitons(in collectionVIew: UICollectionView) -> Int

// numberOfItemsInSection : 한개의 섹션에 몇개의 아이템이 존재하는 지 지정한다. 
func collectionView(_ collectionView: UIColletionView, numberOfItemsInSection section: Int) -> Int

// viewForSupplementaryElementOfKind : 컬렉션뷰의 헤더뷰 등을 설정할 때 사용
func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView

// ... 이 외에도 다양한 메서드가 존재
~~~

<br>

- **UICollectionViewDelegate Method**
  - **sizeForItemAt**
    - **각 Item 셀 별 크기를 지정**

~~~ swift 
// sizeForItemAt CollectionView는 행의 높이가 아닌 각 item의 사각형의 크기로 셀이 이루어진다.
func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		// 셀의 크기를 CGSize타입으로 설정 후 반환
  	return CGSize(width: 1123, height: 1234)
}

// ... 이 외에도 다양한 메서드가 존재
~~~



<br>

<br>

### Cell의 재사용 (Cell Reuse)

- **만약 테이블뷰의 셀이 몇만개를 갖고 있다고 할때 이를 화면에 전부 보이지도 않는데 전부 생성해서 사용하는 것은 비효율적**이다.
  - **테이블 뷰에서는 화면에 보이는 경우에 대해서만 셀을 생성**한다.
  - **셀들은 각기 자신의 뷰클래스에서 각기 표현되어질 UI요소를 지정**한다.
  - **스크롤을 해서 보이는 셀이 바뀌면 위에 가려진 셀을 다시 재사용해서 새로 보여지는 셀에 재사용** 한다. 
  - **dequeueReusableCell 메소드를 통해 셀은 재사용 되어진다.**
    - 이렇게 재사용되어지는 셀들은 
      - **1) 스토리보드의 identifier설정 된 셀 or 코드로 cellIdentifier등록(register)이 되어있는 프로토타입 셀들을**
      - **2) cellForRowAt 델리게이트 메서드 등에서 dequeueReusableCell 메서드를 사용할 때 식별자 identifier로 불러와 생성**된다.
        - **사용될 커스텀 셀은 아래의 두가지 설정을 한 뒤 사용해야 한다.(스토리보드 기준)**
          - **1) IdentityInspector에 클래스파일과의 연동**
          - **2) AttributeInspector에 identifier 설정**
    - **재사용 되는 셀은 평범한 BasicCell이 될수도, Custom Cell이 될 수도 있다.**

~~~ swift
// cellForRowAt 내 dequeueReusableCell 메서드 사용 예시 ▼
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
  	// 커스텀 UITableViewCell, MyTableViewCell 의 재사용
  	// 만약 타입캐스팅에 실패한다면, Basic TableViewCell인 UITableViewCell()을 반환한다.
  	// 특정 커스텀 셀 클래스로 타입캐스팅을 해야 특정 커스텀 셀의 세부 UI에 접근하여 UI를 설정할 수 있다.
		guard let myCell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as? MyTableViewCell else { return UITableViewCell() }
  
  	return myCell
}
~~~



- **셀들은 재사용 되어지기 때문**에 **비교적 작업 소요가 큰 이미지등이 셀에 들어가게 될 경우 정확한 셀에 이미지가 표현될 수 있도록 신경을 써야한다.** 
  - **그렇지 않으면 재사용 되어지는 셀에 잘못된 이미지가 표현되는 경우가 생길 수 있다.**

<br>

### IndexPath 

- **매주 작은 구조체로 테이블뷰 or 컬렉션 뷰등의 섹션, 아이템, 행 등의 정보를 갖고 있다.** 
  - **변수로 행(row), 아이템(item), 섹션(section)** 등을 갖고 있다.
- **UITableView, UICollectionView 프로토콜을 사용할때 특정 행, 섹션에 따른 설정을 할때 사용**된다.

<br>

<br>

## UITableView Demo

- **FoodForThought App Demo**
- **UITableViewController를 CocoaTouch Class로 생성할 경우 기본적으로 제공하는 DataSource Mehods ▼**

<img width="600" alt="dataSourceExam" src="https://user-images.githubusercontent.com/4410021/70063584-63ae6600-162b-11ea-9364-47caaaf07988.png">

<br>


~~~ swift
class EmojiArtDocumentTableViewController: UITableViewController {
  
    // 테이블뷰에 띄울 데이터를 정의
  	var emojiArtDocuments = ["One", "Two", "Three"] 
  
  	override func numberOfSections(in _: UITableView) -> Int {
      	// 섹션의 갯수를 지정, 현재 앱에서는 1개의 섹션만 있으면 된다.
      	return 1
    }
  
  	override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
				// 행의 갯수는 정의된 emojiArtDocuments 배열의 크기만큼 있으면 된다. 
      	return emojiArtDocuments.count
    }
  
  	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) {
      	let cell = tableView.dequeueReusableCell(withIdentifier: "DocumentCell", for: indexPath)
      	// 여기서 DocumentCell 을 설정한다. 
      	cell.textLabel?.text = emojiArtDocuments[indexPath.row]
      	return cell
    }
  
  	@IBAction func newEmojiArt(_: UIBarButtonItem) {
      	// emojiArtDocuments 배열의 데이터를 추가하고 이를 TableView UI에 갱신하기 위해 tableView.reloadData() 메서드를 실행한다. 
				emojiArtDocuments += ["Untitled".madeUnique(withRespectTo: emojiArtDocuments)]
      	tableView.reloadData()
    }
  
  	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
      	// 만약 삭제동작을 했다면 해당 행을 fade효과를 주며 삭제하고, 해당 행의 데이터를 emojiArtDocuments 배열로부터 제거한다.
      	if editingStyle == .delete {
          	emojiArtDocuments.remove(at: indexPath.row)
          	tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
          	// 새로운 행 생성 시 동작 작성
        }
    }
}
~~~

<br>

- **테이블 뷰의 행 추가 & 삭제 예시)**

<img width="600" alt="Demo" src="https://user-images.githubusercontent.com/4410021/70063583-63ae6600-162b-11ea-8bdb-a6190fa7099c.png">


<br>

<img width="600" alt="Demo2" src="https://user-images.githubusercontent.com/4410021/70063581-627d3900-162b-11ea-8a24-44e2a20ca2f2.png">

<br>
<br>


## ♣︎ 총 정리

- **Drag & Drops**
  - 드래그의 시작
  - 드래그의 추가
  - 드래그의 수용
  - 드래그 세션 업데이트
  - 드롭 시 객체 판별 및 수용
- **UITableView & UICollectionView**
  - 세그웨이의 활용
  - 셀의 재사용 
  - Delegate, DataSource 메서드
  - IndexPath

<br>
