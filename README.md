# iOS With Stanford
iOS Study with Stanford
<br>
## Lecture 1)
 * 개발자 문서 내 자주사용하는 클래스의 OverView는 전부 읽어보도록 하자.
 * 프로젝트를 만들때 필요한 것 : 프로젝트명, 팀명, 기관명, 기관식별자
### Xcode Interface 요소
 - 네비게이터 : 좌측 창 영역은 네비게이터라고 한다. 검색/디버깅/파일목록 등을 볼 수 있다. (CMD+0)
 - 유틸리티창 : 우측 창 영역 (OPT+CMD+0)
 - 콘솔창 : 디버깅 출력 등에 사용하는 하단창 (CMD+SHIFT+Y)
 - Simulator : 실 기기로 무/유선 디버깅이 되지만 시뮬레이터를 통한 디버깅도 지원하고 있다.
 - 인터페이스빌더 : InterfaceBuilder, 스토리보드 등으로 뷰요소를 시각적으로 구성할 수 있으며 IBOutlet, IBAction 등으로 뷰 ~ 컨트롤러 간 소통할 수 있게 해준다.

<br>* 인터페이스빌더 내 확대/축소 : Alt+Scroll, 핀치동작으로 가능하다.
<br>* 메서드의 인자이름 지정 방법 : withEmoji emoji 처럼 외/내부 인자이름을 설명할 수 있다. 물론 외/내부 인자이름 동일하게 emogi 하나만 지정할 수도 있다.
<br>
## Lecture 2)
 ## MVC 패턴 : Medel + View + Controller 의 모델-뷰-컨트롤러로 구성하는 디자인패턴 기법
 ### Controller : UIViewController 등의 컨트롤러 요소
 - 모델과 원하는대로 얘기 하며 사용자에게 보여져야 할 데이터를 받는다.(특히 공개적인 데이터와는 무제한적으로 대화가능)
 - Outlet을 통해 view와 소통한다.
 ### View : 스토리보드... UILabel, UIImageView, UIView... and so on...
 - 모델과 절대 소통 불가능
 - 뷰는 컨트롤러와 블라인드상태로 소통해야한다. 뷰는 컨트롤러가 집중력게임 컨트롤러인이 어떤 컨트롤러인지 알지 못한다. 소통 시 컨트롤러에서 뷰에 대한 정의를 구조적으로 지정하고 교류할 수 있다.(타겟메서드, 델리게이트, 데이터소스 프로토콜 등...)
 ex) 컨트롤러에 타겟 메서드를 지정 후 뷰가 동작 시 메서드가 동작하는 방식으로 소통 가능
 ex) 스크롤뷰 등의 did, will, should Delegate 메서드 등을 컨트롤러에서 등록하여 사용할 수 있다.
 ex) 테이블 뷰 등의 스트롤 시 셀 갯수 등을 UITableViewDataSource Protocol로 지정하고 상황에 따라 필요한 만큼의 데이터만 모델에 요청하여 유저에게 보여줄 수 있다.
 ### Model : 뷰에 표현 될 데이터모델
 - View와 절대 소통 불가능
 - Contorller에 사용자에게 보여져야 할 데이터를 제공한다.
 - Controller와 직접적으로는 소통하지 못한다.
 - Notification, KVO(Key Value Observing) 방식으로 컨트롤러와 소통할 수 있다. -> 라디오방송국으로 생각하면 이해하기 좋다.

 ### 클래스가 아닌 struct를 사용하는 이유??
 - 사실 스위프트의 클래스와 구조체는 대부분이 유사하다. 하지만 두가지 큰 차이가 있다.
   - 구조체는 값타입이다. vs 클래스는 참조타입이다.
   - 구조체는 상속성을 가지고 있지않다. vs 클래스는 상속성을 가지고 있다.
   - 구조체는 모든 멤버변수를 초기화할 수 있는 공짜 이니셜라이저가 존재한다. vs 클래스는 이러한 공짜 이니셜라이저가 존재하지 않는다.

 <br>* API란? : Application Programming Interface(인스턴스 리스트)의 약자
 <br>* lazy : lazy를 사용하면 실제 사용하기 전까진 초기화 하지 않는다.누군가 game을 사용하려 할때 비로소 초기화 된다.
 lazy를 사용하면 프로퍼티 옵저버(Property Obserber, 프로퍼티 감시자)로서의 역할은 불가능하다.
 <br>* 배열.indices : 계수가능 범위를 배열로 리턴해준다.
 indices 사용 예 : for index in emojiCardButtons.indices {}

