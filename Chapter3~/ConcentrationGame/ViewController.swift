//
//  ViewController.swift
//  ConcentrationGame
//
//  Created by MinKyeongTae on 16/08/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet private var flipCountLabel: UILabel!

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
    private(set) var flipCount: Int = 0 {
        // didSet은 값이 설정되기 직후에 실행되며, 설정되기 전 값인 oldValue에 접근할 수 있다.
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
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

    // UI를 업데이트하면 UI와 직결되는 메서드이므로 역시 private 처리하는 것이 좋다.
    private func updateViewFromModel() {
        for index in emojiCardButtons.indices {
            let button = emojiCardButtons[index]
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

    private var emojiChoices = ["👻", "🎃", "😱", "🥵", "🥶", "😭", "💀", "👽"]
    private var emoji = [Int: String]()
    private func emoji(for card: Card) -> String {
        // 왜 옵셔널이 들어갈까?? -> 딕셔너리에 없는 값일 수도 있기 때문.
        // * 딕셔너리에서 무언가 찾는다면 옵셔널을 리턴한다는 것을 명심하자.
        // 이모지가 셋팅 안되있고, 선택
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            // * arc4random_uniform은 부호없는 정수형만 취급한다. -> UInt32로 랩핑하면 사용 가능
            // 한번 사용한 이모티콘은 emojiChoices 배열에서 삭제한다.
            emoji[card.identifier] = emojiChoices.remove(at: emojiChoices.count.arc4Random)
        }

        return emoji[card.identifier] ?? "?"
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
