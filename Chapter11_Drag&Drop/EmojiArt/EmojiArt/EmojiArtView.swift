//
//  EmojiArtView.swift
//  EmojiArt
//
//  Created by Kim Taeseon on 2018. 6. 10..
//  Copyright © 2018년 connect.foundation.sr9872. All rights reserved.
//

import UIKit

class EmojiArtView: UIView {
    // 이미지를 설정할 때마다 draw메서드에서 사용하기 위해 didSet 블럭에 setNeedsDisplay()메서드를 실행하도록 설정한다.
    var backgroundImage: UIImage? { didSet { setNeedsDisplay() } }

    override func draw(_: CGRect) {
        // backgroundImage가 경계선 안 쪽에 그려지도록 지정한다.
        backgroundImage?.draw(in: bounds)
    }
}

// class EmojiArtView: UIView
// {
////    [C1-1]
////    backgroundImage의 값이 바뀌면 호출 되는 Computed Property를 넣습니다. 이미지를 그리도록 setNeedsDisplay() 메소드를 호출하도록 합니다.
//    var backgroundImage: UIImage? { didSet { setNeedsDisplay() }}
//
//    override func draw(_ rect: CGRect) {
////       [C1-2]
////        backgroundImage를 그림을 그리게 되는 사이즈에 맞춰 그립니다.
//        backgroundImage?.draw(in: bounds)
//    }
// }
