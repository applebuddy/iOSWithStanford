//
//  ConcentrationThemeChooserViewController.swift
//  ConcentrationGame
//
//  Created by MinKyeongTae on 2019/11/14.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

// MARK: - ThemeChooserViewController -> SplitViewController의 델리게이트로 만들기

//  -> 델리게이트를 활용하여 뷰가 스플릿 뷰에서 가려지는지를 조정할 수 있다.

import UIKit

class ConcentrationThemeChooserViewController: UIViewController, UISplitViewControllerDelegate {
    // MARK: - Theme Contents

    /// 스플릿뷰컨트롤러의 디테일 뷰에 접근하기 위해 사용하는 프로퍼티
    private var splitViewDetailConcentrationViewController: ConcentrationViewController? {
        // splitviewController객체가 있는지? 있다면 해당 스플릿 뷰의 디테일 뷰를 반환한다.
        return splitViewController?.viewControllers.last as? ConcentrationViewController
    }

    /// 가장 최근의 뷰 컨트롤러를 저장하기 위한 ConcentrationViewController 프로퍼티 객체
    private var lastSeguedToConcentrationViewController: ConcentrationViewController?

    let themes = [
        "Sports": "⛹️‍♀️🏊‍♀️🚣‍♀️🏄‍♀️🏄‍♂️🤾‍♂️🏊‍♂️🏌️‍♂️🎱🏐🏅🤺",
        "Animals": "🐂🐃🐄🐅🐆🐇🐈🐉🐋🐌🐎🐏",
        "Faces": "😂😀😃😄😁😅🤣🥰😘😎🤩😰",
    ]

    // IB객체를 부를때 사용하는 awakeFromNib()
    override func awakeFromNib() {
        // super.awakeFromNib()을 반드시 붙여준다.
        super.awakeFromNib()

        // splitViewController 델리게이트를 채택
        splitViewController?.delegate = self
    }

    // 만약 splitView의 masterView가 가리는것을 원치 않으면, true를 리턴, 가리는 것을 원한다면 false를 리턴한다.
    func splitViewController(_: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto _: UIViewController) -> Bool {
        if let concentrationViewController = secondaryViewController as? ConcentrationViewController {
            if concentrationViewController.theme == nil {
                // 만약 splitView가 한번도 설정되지 않은 상태라면, masterView로 덮는다.
                return true
            }
        }
        // 만약 splitView가 설정이 되어잇다면 masterView로 가릴 필요는 없다.
        return false
    }

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
                    // 아래처럼 최근의 뷰컨트롤러 상태를 저장하므로서, 네비게이션 스택에서 사라지더라도 가장 최근의 ConcentrationViewController 데이터를 저장하여 사용할 수 있게 된다.
                    lastSeguedToConcentrationViewController = viewController
                }
            }
        }
    }

    // MARK: - Perform Segue

    /// Segue의 Identifier를 사용해서 특정 Segue를 실행하여 화면 전환을 할 수 있다.
    @IBAction func changeTheme(_ sender: Any) {
        // 스플릿뷰의 디테일 뷰 컨트롤러가 존재하는 지 확인
        if let splitDetailViewController = splitViewDetailConcentrationViewController {
            // 현재 타이틀 이름이 존재하는지 확인
            // 현재 주제에 맞는 배열을 디테일 뷰에 전달
            // ✭ PerformSegue를 통해 새로운 MVC 인스턴스를 생성한 것이 아닌, @IBAction 타겟메서드를 통해 디테일 뷰 컨트롤러에 접근함으로서 게임이 초기화 되지 않고 테마만 변경되게 할 수 있게 된다.
            if let themeName = (sender as? UIButton)?.currentTitle,
                let theme = themes[themeName] {
                splitDetailViewController.theme = theme
            }
        } else if let concentrationViewController = lastSeguedToConcentrationViewController {
            // splitViewController가 정상적으로 활성화 되지 않았을 경우, 캐싱되어있는 징중력게임 뷰컨트롤러가 존재하는지 확인하고 있다면 활용한다.
            if let themeName = (sender as? UIButton)?.currentTitle,
                let theme = themes[themeName] {
                concentrationViewController.theme = theme
            }
            navigationController?.pushViewController(concentrationViewController, animated: true)
        } else {
            // 주제 타이틀을 못할을 경우 예외처리 용으로만 performSegue를 사용하도록 설정한다.
            performSegue(withIdentifier: "Choose Theme", sender: sender)
        }
    }
}
