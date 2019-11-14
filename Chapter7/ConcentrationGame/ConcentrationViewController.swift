//
//  ViewController.swift
//  ConcentrationGame
//
//  Created by MinKyeongTae on 16/08/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

// Lecture 7) MVCs로 구성하기 위해 이름은 각각 세부적인 ViewController Name을 부여한다.

import UIKit

class ConcentrationViewController: UIViewController {
    @IBOutlet private var flipCountLabel: UILabel! {
        didSet {
            // 일반 변수와 달리 Outlet변수는 설정될 때 didSet을 불러온다.
            // Outlet의 연결이 만들어질 때 didSet을 불러오는 것이다.
            updateFlipCountLabel()
        }
    }

    // Outlet Collection Property
    @IBOutlet private var emojiCardButtons: [UIButton]!

    // ✭ 실제 UI와 직결될 수 있는 데이터는 private 처리하는 것이 좋다.
    private lazy var game: Concentration = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)

    // * 읽기만 가능한 변수이므로 internal로 두어도 무방하다.
    var numberOfPairsOfCards: Int {
        // get만 있으므로 아래와 같이 return ~~ 방식으로 만 표현할 수 있다.
        return (emojiCardButtons.count + 1) / 2
    }

    // flipCount 또한 UI와 직결되므로, 읽기만 가능하도록 private(set) 설정을 할 수 있다.
    // flipCount의 didSet은 초기화한 당시인 0 값일때는 활성화 되지 않는다.
    private(set) var flipCount: Int = 0 {
        // didSet은 값이 설정되기 직후에 실행되며, 설정되기 전 값인 oldValue에 접근할 수 있다.
        didSet {
            updateFlipCountLabel()
        }

//        /// willSet은 값이 설정되기 직전에 실행되며, 새로 설정 된 newValue에 접근할 수 있다.
//        willSet {
//            flipCountLabel.text = "Flips: \(flipCount)"
//        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    /// * @IBAction은 Xcode에서 추가한 지시문이다. 인터페이스빌더 내 UI객체와 연결이 되어 동작한다.
    @IBAction private func emojCardPressed(_ sender: UIButton) {
        flipCount += 1 // 넘긴 횟수를 1 증가 시킨다.
        if let cardNumber = emojiCardButtons.firstIndex(of: sender) { // 선택한 카드의 인덱스를 확인
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
            print("cardNumber = \(cardNumber)")
        } else {
            print("chosen card was not in emojuCardButtons")
        }
    }

    private func updateFlipCountLabel() {
        let attributes: [NSAttributedString.Key: Any] = [
            .strokeWidth: 5.0,
            .strokeColor: UIColor.red,
        ]
        let attributedString = NSAttributedString(string: "Flips: \(flipCount)", attributes: attributes)
        flipCountLabel.attributedText = attributedString
    }

    // UI를 업데이트하면 UI와 직결되는 메서드이므로 역시 private 처리하는 것이 좋다.
    private func updateViewFromModel() {
        // Segue로 데이터 전달 시 그로인한 사이드 이펙트를 감안해서 데이터 및 데이터타입 옵셔널 처리를 수행해야한다.
        guard let cardButtons = self.emojiCardButtons else { return }
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            // 카드가 앞면인지 뒷면인지에 따라 카드를 처리한다.
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = .white
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? .clear : #colorLiteral(red: 0.476841867, green: 0.5048075914, blue: 1, alpha: 1)
            }
        }
    }

    var theme: String? {
        didSet {
            // emojiChoices의 주제를 설정한다.
            emojiChoices = theme ?? ""
            emoji = [:]
            // 새로운 테마 업데이트 메서드 실행
            updateViewFromModel()
        }
    }

    // String 상태
    private var emojiChoices = "👻🎃😱🥵🥶😭💀👽"
    private var emoji = [Card: String]()

    private func emoji(for card: Card) -> String {
        // 왜 옵셔널이 들어갈까?? -> 딕셔너리에 없는 값일 수도 있기 때문.
        // * 딕셔너리에서 무언가 찾는다면 옵셔널을 리턴한다는 것을 명심하자.
        // 딕셔너리의 키와 값 형태를 활용해보자.
        if emoji[card] == nil, emojiChoices.count > 0 {
            // * arc4random_uniform은 부호없는 정수형만 취급한다. -> UInt32로 랩핑하면 사용 가능
            // 한번 사용한 이모티콘은 emojiChoices 배열에서 삭제한다.
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4Random)
            emoji[card] = String(emojiChoices.remove(at: randomStringIndex))
        }

        return emoji[card] ?? "?"
    }
}

// 확장기능, extension의 사용 예
// extension을 통해 코드를 더욱 간결하게 구현 할 수 있다.
// extension 코드 내 여러가지 입력값에 대비한 코드처리를 했다.
extension Int {
    var arc4Random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
