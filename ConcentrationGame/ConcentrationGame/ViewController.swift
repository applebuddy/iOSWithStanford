//
//  ViewController.swift
//  ConcentrationGame
//
//  Created by MinKyeongTae on 16/08/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

/// Lecture 1)
/// * 개발자 문서 내 자주사용하는 클래스의 OverView는 전부 읽어보도록 하자.
// 프로젝트를 만들때 필요한 것 : 프로젝트명, 팀명, 기관명, 기관식별자
// 네비게이터 : 좌측 창 영역은 네비게이터라고 한다. 검색/디버깅/파일목록 등을 볼 수 있다. (CMD+0)
// 유틸리티창 : 우측 창 영역 (OPT+CMD+0)
// 콘솔 : 디버깅 출력 등에 사용하는 하단창 (CMD+SHIFT+Y)
// Simulator : 실 기기로 무/유선 디버깅이 되지만 시뮬레이터를 통한 디버깅도 지원하고 있다.

// * 인터페이스빌더 내 확대/축소 : Alt+Scroll, 핀치동작으로 가능하다.

/// Lecture 2)
// ## MVC 패턴 : Medel + View + Controller
// ###Controller :
// -모델과 원하는대로 얘기 하며 사용자에게 보여져야 할 데이터를 받는다.(특히 공개적인 데이터와는 무제한적으로 대화가능)
// - Outlet을 통해 view와 소통한다.
// ###View : 스토리보드... UILabel, UIImageView, UIView... and so on...
// - 모델과 절대 소통 불가능
// - 뷰는 컨트롤러와 블라인드상태로 소통해야한다. 뷰는 컨트롤러가 집중력게임 컨트롤러인이 어떤 컨트롤러인지 알지 못한다. 소통 시 컨트롤러에서 뷰에 대한 정의를 구조적으로 지정하고 교류할 수 있다.(타겟메서드, 델리게이트, 데이터소스 프로토콜 등...)
// ex) 컨트롤러에 타겟 메서드를 지정 후 뷰가 동작 시 메서드가 동작하는 방식으로 소통 가능
// ex) 스크롤뷰 등의 did, will, should Delegate 메서드 등을 컨트롤러에서 등록하여 사용할 수 있다.
// ex) 테이블 뷰 등의 스트롤 시 셀 갯수 등을 UITableViewDataSource Protocol로 지정하고 상황에 따라 필요한 만큼의 데이터만 모델에 요청하여 유저에게 보여줄 수 있다.
// ###Medel
// - View와 절대 소통 불가능
// - Contorller에 사용자에게 보여져야 할 데이터를 제공한다.
// - Controller와 직접적으로는 소통하지 못한다.
// - Notification, KVO(Key Value Observing) 방식으로 컨트롤러와 소통할 수 있다. -> 라이도방송국으로 생각하면 이해하기 좋다.

import UIKit

class ViewController: UIViewController {
    @IBOutlet var flipCountLabel: UILabel!

    // Outlet Collection Property
    @IBOutlet var emojiCardButtons: [UIButton]!

    var emijuChoices = ["👻", "🎃", "🎃", "👻"]
    var flipCount: Int = 0 {
        // didSet은 값이 설정되기 직후에 실행되며, 설정되기 전 값인 oldValue에 접근할 수 있다.
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }

        /// willSet은 값이 설정되기 직전에 실행되며, 새로 설정 된 newValue에 접근할 수 있다.
        willSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    /// * @IBAction은 Xcode에서 추가한 지시문이다. 인터페이스빌더 내 UI객체와 연결이 되어 동작한다.
    @IBAction func ghostEmojCardPressed(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = emojiCardButtons.firstIndex(of: sender) {
            flipEmojCard(withEmoji: emijuChoices[cardNumber], on: sender)
            print("cardNumber = \(cardNumber)")
        } else {
            print("chosen card was not in emojuCardButtons")
        }
    }

    /// * 메서드의 인자이름 지정 방법 : withEmoji emoji 처럼 외/내부 인자이름을 설명할 수 있다. 물론 외/내부 인자이름 동일하게 emogi 하나만 지정할 수도 있다.
    func flipEmojCard(withEmoji emoji: String, on button: UIButton) {
        // 만약 현재 타이틀이 emoji와 동일하면 실행
        // 이모지가 있으면, 주황바탕의 빈 문자열을 보인다.
        print("flipCartWithEmoji: \(emoji)")
        if button.currentTitle == emoji {
            button.setTitle("", for: .normal)
            button.backgroundColor = .orange

            // 이모지가 없으면, 흰바탕의 이모지 문자열을 보인다.
        } else {
            button.setTitle(emoji, for: .normal)
            button.backgroundColor = .white
        }
    }
}
