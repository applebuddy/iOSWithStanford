# iOS With Stanford

- **iOS Study with Stanford Lection Study 11~12**

<br>
<br>

# 목차

## [Lecture 11](https://github.com/applebuddy/iOSWithStanford/blob/master/StanfordLectureMemo_11~12.md#lecture-11-1)

## [Lecture 12](https://github.com/applebuddy/iOSWithStanford/blob/master/StanfordLectureMemo_11~12.md#lecture-12-1)

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

<br>

<br>



# Lecture 12) 

## ♣︎ UICollectionView, UITextField

- **EmojiArt Demo**
- **UICollectionView**
- **UITextField**

<br>

<br>

## Emoji Art Demo

- **CollectionView의 추가**
  - **CollectionView 내에서의 Drag & Drop**

- **layoutSubviews가 호출되기 전 호출되는 viewWillLayoutSubviews**에서 **splitView의 선호배치모드 (preferredDisplayMode)를 변경 시킬 수 있다.** 

~~~ swift
// layoutSubviews가 호출되기 직전에 splitViewController의 화면 배치를 설정할 수 있다. 
override func viewWillLayoutSubviews() {
      super.viewWillLayoutSubviews()
      if splitViewController?.preferredDisplayMode != .primaryOverlay {
          splitViewController?.preferredDisplayMode = .primaryOverlay
      }
}
~~~

<br>

- 스크롤뷰 등의 서브뷰가 상위뷰 안에만 있도록 constraints의 값을 greater or Equal 설정 할 수 있다. 
  - 이때 제약의 오류는 서브뷰의 높이, 너비를 지정하면 해결된다. 
- 뷰의 제약조건 (Constraints)를 IBOutlet 변수로 가져와 코드로 설정할 수 있다. 

~~~ swift
// 스크롤뷰 높이 너비 제약의 IBOutlet 변수 선언 예시) 
@IBOutlet weak var scrollViewHeight: NSLayoutConstraint!
@IBOutlet weak var scrollViewWidth: NSLayoutConstraint!

// scrollViewDidZoom 델리게이트 메서드 활용 예시)
func scrollViewDidZoom(_ scrollView: UIScrollView) {
  	// 스크롤 뷰가 확대 되었을 때 스크롤 뷰의 너비를 컨텐츠 크기로 설정 한다.
		scrollViewHeight.constant = scrollView.contentSize.height
  	scrollViewWidth.constant = scrollView.contentSize.width
}
~~~

<br>

### CollectionView의 사용

- **스토리보드에서는 컬렉션 뷰를 Command + Shift + L로 드래그하여 추가할 수 있다.**
- **CollectionView IBOutlet 연결 에디터 예시)**

~~~ swift
// IBOutlet 연결과 더불어 컬렉션 뷰가 셋팅 될때 didSet을 지정하여 collectionViewDataSource, collectionViewDelegate를 해당 뷰컨 자기자신이 되도록 설정할 수 있다. 
// self 지정을 위해선 해당 ViewController가 사전에 UIColletionViewDataSource, UICollectionViewDelegate 를 채택한 상태여야 한다. (채택 해주어야 설정 가능)
@IBOutlet weak var emojiCollectionView: UICollcetionView! {
		didSet {
      	emojiCollectionView.dataSource = self
      	emojiCollectionView.delegate = self 
    }
}
~~~

<br>

- **collectionView의 delegate, dataSource, delegateFlowLayout** 설정

  - **delegateFlowLayout** 

    - **텍스트처럼 나열되는 레이아웃 관련 델리게이트 프로토콜**

<br>

<br>

## UICollectionView Protocols

### UICollectionViewDragDelegate

- **CollectionView 드래그 관련 델리게이트 프로토콜**

- **DragDelegate 필수 메서드**

  - **itemsForBeginning**

    ~~~ swift
    // UICollectionViewDragDelegate 필수 메서드
    // indexPath 값에 맞는 dragItem을 반환하는 메서드, dragItems 
    private func dragItems(at indexPath: IndexPath) -> [UIDragItem] {
      	// 특정 indexPath 위치에 맞는 EmojiCollectinViewCell을 접근한다. 
      	if let attributedString = (emojiCollectionView.cellForItem(at: indexPath) as? EmojiCollectionViewCell)?label.attributedText {
          	let dragItem = UIDragItem(itemProvider: NSItemPRovider(object: attributedString))
          	// 지역적으로 드레그를 하는 경우 아래와 같이 localObject를 설정 가능
          	dragItem.localObject = attributedString
          	// indexPath에 맞는 dragItem 정보를 배열에 담아 반환한다. 
          	return [dragItem]
        } else {
          	// 셀을 정상적으로 접근하지 못했다면 빈 배열을 반환한다. 
    				return []
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
      	// 드래그가 시작되면 session.localContext에 collectionView를 넣어준다.
      	session.localContext = collectionView
      	
    		// itemsForBeginning메서드에서 드래그 시작 시의 인덱스 경로(indexPath)를 확인 할 수 있다.
      	return dragItems(at: indexPath)
    }
    
    
    ~~~

- **DragDelegate 선택적 메서드**

  - **itemsForAddingTo**

    ~~~ swift
    func collectionView(_ collectionView: UICollectionView, itemsForAddingTo session: UIDragSession, at indexPath: IndexPath, point: CGPoint) -> [UIDragItem] {
      	return dragItems(at: indexPath)
    }
    ~~~

<br>

### UICollectionViewDropDelegate (37min~)

- **CollectionView Drop 관련 델리게이트 프로토콜**

- **DropDelegate 필수 메서드**

  - **performDropWith** : 드롭 시 행위 지정
  - 매개변수 UICollectionViewDropCoordinator는 destinationIndexPath 등 드롭 시 행위 판단에 사용할 수 있는 정보를 제공한다. 
    - 드롭으로 데이터가 최종적으로 도착할 경우, placeHolder(context)에게 모델을 업데이트 하도록 이를 알려준다.
  
~~~ swift
  // UICollectionViewDropDelegate 필수 메서드
  func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
    	// 만약 존재하지 않는 위치에 드롭이 된다면, 기본 InpaxPath 값으로 적용한다. 
  	let destinationIndexPath = coordinator.destinationIndexPath ?? IndexPath(item: 0, section: 0)
    	
    	for item in coordinator.items {
        	if let sourceIndexPath = item.sourceIndexPath {
            	// item.dragItem을 통해 미리 저장해둔 localObject(NSAttributedString) 값을 얻는다. 
            	if let attributedString = item.dragItem.localObject as? NSAttributedString {
                
                	// ✭ collectionView.performBatchUpdates에서 셀의 이동, 삭제 등을 처리하고 항상 모델과 동기화 시킬 수 있다. 
                	collectionView.performBatchUpdates({
                  // 아래 performDropWith 내 두줄(remove/insert)의 코드로 특정 아이템을 다른 IndexPath 위치로 이동 시킬 수 있다.
                  // -> 드롭 간 이모티콘의 위치를 움직이게 하는 부분
                	emojis.remove(at: sourceIndexPath.item)
                	emojis.insert(attributedString.string, at: destinationIndex.item)
                	collectionView.deleteItems(at: [sourceIndexPath])
                	collectionView.insertItems(at: [destinationIndexPath])
                  }) // 맨 마지막 completion 핸들러는 생략 가능
                
                	// coordinatior.drop을 통해 특정 위치로의 dragItem 드롭 행위를 동작 시킨다.
                	coordinator.drop(item.dragItem, toItemAt: destinationIndexPath)
              }
          } else {
  						// sourceIndexPath가 없다는 것은 앱 외부에서 가져온 것임을 의미한다.
            	let placeHolderContext = coordinator.drop(
                	item.dragItem,
              		to: UICollectionViewDropPlaceholder(insertionIndexPath: destinationIndexPath, reuseIdentifier: "여기에 어떤 종류의 셀인지를 식별자로 지정해야함(DropPlaceholderCell)")) // 마지막 매개변수 생략가능
          }
        	// 아이템을 주는 제공자로, 앱 외부에서 오기 때문에 비동기적으로 처리된다. 
        	// 클로저에서는 제공받은 타입과 error를 참고 가능하다. 
        	item.dragItem.itemProvider.loadObject(ofClass: NSAttributedString.self) { (provider, error) in 
            		// 해당 클로저 내부는 메인스레드에서 동작하지 않으므로, UI를 다루려면 DispatchQueue 등으로 main스레드에서 작동시켜야 한다. 
  							// 외부에서 가져온 경우 해당 타입이 NSAttributedString일 경우 emojis에 해당 값을 추가한다. 
  							DispatchQueue.main.async {
                  	if let attributedString = provider as? NSAttributedString {
                      	placeholderContext.commitInsertion(dataSourceUpdates: { insertionIndexPath in
                            emojis.insert(attributedString.string, at: insertionIndexPath.item)
                        })
                    } else {
                      	// 만약 NSAttributedString 타입에 맞지 않는다면 placeholder는 제거한다.
                      	placeholderContext.deletePlaceholder()
                    }
                }                                                                 
          }
      }
  }
  ~~~
 
<br>
  
- **performDrop 내 앱 내부 아이템에 대한 collectionView.performBatchUpdates 메서드 지정 등... 설정 후 결과 ▼)**
<img width="600"  alt="3" src="https://user-images.githubusercontent.com/4410021/70651052-7cee8c80-1c93-11ea-866b-97ca0cbefff6.png">

<br>

- **performDrop 내 앱 외부 아이템에 대한 placeholderContext 설정 후 결과 ▼)**
  - **외부에서 "bee" 문자열을 드래그 해서 앱 내의 컬렉션뷰에 추가하였다! (emojis 에 추가 됨)**
<img width="600" alt="0" src="https://user-images.githubusercontent.com/4410021/70650932-53cdfc00-1c93-11ea-9338-63590c688430.png">
<br>
<img width="600" alt="1" src="https://user-images.githubusercontent.com/4410021/70650936-54ff2900-1c93-11ea-9e9c-5c51d77f45e1.png">

<br>
<br>

- **DropDelegate 옵션 메서드**
  - **canHandle** : 컬렉션 뷰가 드롭할 수 있는 구체적인 데이터를 지정

  ~~~ swift
  // UICollectionViewDropDelegate 옵션 메서드, canHandle
  func collectionView(_ collectionView: UICollectionView, canHandle session: UIDropSession) -> Bool {
    	// NSAttributedString 타입을 드롭 가능하도록 수용
    	return session.canLoadObjects(ofClass: NSAttributedString.self) 
  }
  ~~~

- **DropSessionDidUpdate** 
  - 드롭상태가 바뀔 때 행위 지정 (.copy, .move, .cancel)
  - 반환하는 UICollectionViewDropProposal의 두번째 생성자에서 intent 매개변수에서는 현재 컬렉션 뷰 사이에 아이템을 삽입하거나 컨텐츠를 넣는 등의 방식 지정을 한다.  

  ~~~ swift
  // UICollectionViewDropDelegate 옵션 메서드, dropSessionDidUpdate
  func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
  		// 현재 드래그 진행 중인 컬렉션뷰와 시작당시 받아온 collectionView가 서로 일치하는지 확인한다.
    	let isSelf = (session.localDragSession?.localContext) as? UICollectionView == collectionView
    	// 3항 연산자를 사용해 컨텍스트가 collectionView이면 .move, 아니면 .copy를 사용한다. 
    	return UICollectionViewDropProposal(operation: isSelf ? .move : .copy, intent: .insertAtDestinationIndexPath)
  }
  ~~~

<br>

### UICollectionViewDelegate

<br>

### UICollectionViewDataSource

- **DataSource 필수  메서드**
  - **numberOfItemsInSection**
    - **Default 값은 1**이다.
    - **각 섹션 별 아이템의 갯수 지정 담당**
  - **cellForItemAt**
    - **아이템 셀의 지정을 담당**

~~~ swift
// UICollectionViewDataSource 활용 예시)
private var font: UIFont {
		return UIFontMetrics(forTextStyle: .body).scaledFont(for: UIFont.preferredFont(forTextStyle: .body).withSize(64.0))
}

func collectionView(_ collectionView: UICollectionvIew, numberOfItemsInSection section: Int) -> Int {
		return emojis.count
}

func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
  	// 재사용 셀 생성 
  	guard let emojiCell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmojiCell", for: indexPath) as? EmojiCollectionViewCell else { return UICollectionViewCell() }
  	// emojiCell의 텍스트 설정 
  	let cellText = NSAttributedString(string: emojis[indexPath.item, attributes: [.font: font])
		emojiCell.label.attributedText = text 
		// 설정한 emojiCell의 반환
		return emojiCell
}
~~~

<br>

- **CollectionView 레이아웃 설정 간 주의사항**
  - **스크롤이 안되는 CollectionView의 셀 크기를 CollectionView 너비보다 크게 설정하면 안된다.**

<br>

- **CollectionView Property, Methods**
  
  - **Scroll Direction**
    
    - **Horizontal, Vertical 설정으로 컬렉션뷰의 스크롤 방향을 설정 가능**
    - **둘을 동시에 설정하는 것은 불가능**
    
  - **PerformBatchUpdates**
  
    - **컬렉션 뷰 셀에 대하여 다수의 수정 (삽입, 삭제 등)을 하면서 모델의 동기화까지 시키고자 할 때 사용**한다. 
  
    ~~~ swift
    // ... in performDropWith Method
    // ✭ collectionView.performBatchUpdates에서 셀의 이동, 삭제 등을 처리하고 항상 모델과 동기화 시킬 수 있다. 
                collectionView.performBatchUpdates({
                      	// 아래 performDropWith 내 두줄(remove/insert)의 코드로 특정 아이템을 다른 IndexPath 위치로 이동 시킬 수 있다.
                  	emojis.remove(at: sourceIndexPath.item)
                  	emojis.insert(attributedString.string, at: destinationIndex.item)
                  	collectionView.deleteItems(at: [sourceIndexPath])
                  	collectionView.insertItems(at: [destinationIndexPath])
                }) // 맨 마지막 completion 핸들러는 생략 가능
    ~~~
  
    

<br>

## EmojiArtView 드롭 이벤트 구현 (60min~)

~~~ swift
import UIKit

class EmojiArtView: UIView, UIDropInteractionDelegate
{
    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
      	// dropInteraction 추가, UIDropInteractionDelegate 를 채택해야 한다.
        addInteraction(UIDropInteraction(delegate: self))
    }
    
    // this var is not in Demo
    private var font: UIFont {
        return
            UIFontMetrics(forTextStyle: .body).scaledFont(for: UIFont.preferredFont(forTextStyle: .body).withSize(64.0))
    }
    
    // MARK: - UIDropInteractionDelegate
    
    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
      	// canHandle 메서드에서 NSAttributedString 타입만 드롭할 대상으로 지정한다. 
        return session.canLoadObjects(ofClass: NSAttributedString.self)
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
      	// 드롭 상태 업데이트 시 .copy를 동작 시킨다. 
        return UIDropProposal(operation: .copy)
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
      	// 현재 드롭 위치에 대하여 NSAttributedString 값이 존재하면 라벨을 추가한다. 
        session.loadObjects(ofClass: NSAttributedString.self) { providers in
            let dropPoint = session.location(in: self)
            for attributedString in providers as? [NSAttributedString] ?? [] {
                self.addLabel(with: attributedString, centeredAt: dropPoint)
            }
        }
    }
    
    private func addLabel(with attributedString: NSAttributedString, centeredAt point: CGPoint) {
        let label = UILabel()
        label.backgroundColor = .clear
        // next row is not in Demo
        label.attributedText = attributedString.font != nil ? attributedString : NSAttributedString(string: attributedString.string,attributes: [.font:self.font])
    //   label.attributedText = attributedString
        label.sizeToFit() // 임의의 크기가 되지 않도록 sizeToFit 처리를 한다. 
        label.center = point
        addEmojiArtGestureRecognizers(to: label) // 각각의 label에 gestureRecognizer를 추가한다. 
        addSubview(label) // self. 의 subview로 추가한다.
    }
    
    // MARK: - Drawing the Background
    
    var backgroundImage: UIImage? { didSet { setNeedsDisplay() } }
    
    override func draw(_ rect: CGRect) {
        backgroundImage?.draw(in: bounds)
    }
}

~~~

<br>

<br>

## UITextField

- **편집이 가능한 UILabel**

- **UITextField는 UIControl**이다.

  - **그러므로 UITextField에 특정 행동에 대한 target/action 메서드를 설정 가능**
  - **그렇기에 delegate 메서드 대신 target methods를 통해 행위에 대한 동작 처리를 하는 경우가 존재**

- **키보드를 띄워주고 텍스트를 입력할 수 있게 해준다.**

  - **이때 키보드가 띄워지는 이유는 어떠한 객체가 becomeFirstResponder의 응답자가 되었기 때문**
    - **becomeFirstResponder는 TextField에 보낼 수 있는 메세지의 일종**
    - **만약 최초 응답자가 되는 것을 멈추고 키보드를 내리려면 resignFirstResponder를 전달**하면 된다.

- **UITextFieldDelegate를 갖고 있다.** 

  ~~~ swift
  // UITextFieldDelegate Methods
  
  // * textFieldShouldReturn : return키를 입력받을 때 호출되는 메서드
  // textFieldShoudReturn 메서드 내에서 resignFirstResponder 메서드를 호출하면 return키를 눌렀을때 키보드가 내려가도록 할 수 있다. 
  func textFieldShouldReturn(sender: UITextField) -> Bool 
  
  // textFieldDidEndEditing : firstResponder에서 풀려났을 때 호출되는 메서드
  // 텍스트필드를 수정하다가 다른 텍스트필드를 누르는 등의 상황에서 해당 메서드가 호출 된다. 
  func textFieldDidEndEditing(sender: UITextField)
  ~~~

  <br>

  - **선택이 바뀌거나 새로운 입력 편집이 있을 때 등을 감지**할 수 있다. 

- 입력, 편집이 가능한 UITextField지만 아이폰 등의 작은휴대기기에서 UITextField를 사용할 때 유저 입장에서 꼭 필요한지 고민해볼 필요가 있다. 

<br>

### UITextField Properties

- **UITextField는 UITextInputTraits 프로토콜을 채택**하고 있다. 

  - **UITextInputTraits는 키보드와 관련된 기능들이 있으며 키보드에 악세서리 뷰를 추가할 수도 있다.** 

  ~~~ swift
  // UITextField Properties
  var autocapitalizationType: UITextAutocapitalizationType // 문장, 단어 등의 타입 지정
  var autocorrectionType: UITextAutocorrectionType // .yes or .no 로 자동완성 지정
  var returnKeyType: UIReturnKeyType // Go, Search, Google, Done, etc... 타입 지정
  var isSecureTextEntry: Bool // 패스워드 등 텍스트 감출때 사용
  var keyboardType: UIKeyboardType // 아스키코드, URL, PhonePad 등의 타입 지정 
  
  var clearsOnBeginEditing: Bool
  var adjustsFontSizeToFitWidth: Bool // 현재 수퍼뷰 크기에 맞게 폰트를 조정하도록 가능
  var minimumFontSize: CGFLoat // adjustsFontSizeToFitWidth를 설정하면 항상 셋팅됨
  var placeholder: String? // placeholder의 default 색상값은 gray
  var background/disabledBackground: UIImage?
  var defaultTextAttributes: [String:Any] // 전체적인 텍스트에 적용되는 Attributes
  
  ~~~

<br>

<br>

## ♣︎ 총 정리

- **EmojiArt Demo (CollectionView Drag & Drop)**
- **UICollectionView**
  - UICollectionView Protocols
    - UICollectionViewDragDelegate
      - itemsForBeginning
      - itemsForAddingTo
    - UICollectionViewDropDelegate
      - canHandle
      - sessionDidUpdate
      - performDrop
    - UICollectionViewDelegate
    - UICollectionViewDataSource
      - numberOfItemsInSection
      - cellForItemAt
- **UITextField**
  - UITextField is UIControl
    - Using Target/Action
  - UITextFieldDelegate
    - textFieldShouldReturn
    - textFieldDidEndEditing
  - UITextField Properties

 <br>

<br>
