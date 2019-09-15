//
//  ViewController.swift
//  PlayingCard
//
//  Created by MinKyeongTae on 16/09/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var deck = PlayingCardDeck()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        for _ in 1 ... 10 {
            if let card = deck.draw() {
                print("\(card)")
            }
        }
    }
}
