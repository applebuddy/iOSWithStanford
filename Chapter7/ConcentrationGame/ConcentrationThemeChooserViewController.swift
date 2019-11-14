//
//  ConcentrationThemeChooserViewController.swift
//  ConcentrationGame
//
//  Created by MinKyeongTae on 2019/11/14.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

class ConcentrationThemeChooserViewController: UIViewController {
    // MARK: - Theme Contents

    let themes = [
        "Sports": "⛹️‍♀️🏊‍♀️🚣‍♀️🏄‍♀️🏄‍♂️🤾‍♂️🏊‍♂️🏌️‍♂️🎱🏐🏅🤺",
        "Animals": "🐂🐃🐄🐅🐆🐇🐈🐉🐋🐌🐎🐏",
        "Faces": "😂😀😃😄😁😅🤣🥰😘😎🤩😰",
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "Choose Theme" {
            if let themeName = (sender as? UIButton)?.currentTitle,
                let theme = themes[themeName] {
                if let viewController = segue.destination as? ConcentrationViewController {
                    viewController.theme = theme
                }
            }
        }
    }
}
