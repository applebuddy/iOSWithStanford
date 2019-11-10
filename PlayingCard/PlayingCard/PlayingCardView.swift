//
//  PlayingCardView.swift
//  PlayingCard
//
//  Created by MinKyeongTae on 10/11/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

class PlayingCardView: UIView {
    
    /// MARK: - Properties
    // 내용이 바뀐 때마다 드로잉을 새로 하는 경우에, 프로퍼티에 didSet 프로퍼티 감시자 기능을 정의하여 사용할 수 있다.
    var rank: Int = 5 { didSet { setNeedsDisplay(); setNeedsLayout() }}
    var suit: String = "❤️" { didSet { setNeedsDisplay(); setNeedsLayout() }}
    
    // 카드가 뒷면일 경우 별도의 드로잉은 필요가 없다.
    var isFaceUp: Bool = true { didSet { setNeedsDisplay(); setNeedsLayout() }}
    
    
    
    /// MARK: - Methods
    /// 카드 내 문자열에 사용할 커스텀 문자열 속성을 부여하는 메서드
    private func centeredAttributedString(_ string: String, fontSize: CGFloat) -> NSAttributedString {
        var font = UIFont.preferredFont(forTextStyle: .body).withSize(fontSize)
        // ✭ scaledFont 기능응 활용하여 작은 버튼을 따라 크기를 바꿔줄 수 있다.
        font = UIFontMetrics(forTextStyle: .body).scaledFont(for: font)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        return NSAttributedString(string: string, attributes: [NSAttributedString.Key.paragraphStyle:paragraphStyle, .font:font])
    }
    
    private var cornerString: NSAttributedString {
        return centeredAttributedString(rankString+"\n"+suit, fontSize: 0.0)
    }
    
    private lazy var upperLeftCornerLabel: UILabel = createCornerLabel()
    private lazy var lowerRightCornerLabel: UILabel = createCornerLabel()
    
    // * numberOfLines는 최대 표현 행 수를 설정한다.
    //   - 만약 0으로 설정하면 원하는대로 행이 추가될 수 있음을 의미한다.
    private func createCornerLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        addSubview(label)
        return label
    }
    
    private func configureCornerLabel(_ label: UILabel) {
        label.attributedText = cornerString
        // * sizeToFit() 은 레이블의 크기를 내용에 맞춰준다.
        label.frame.size = CGSize.zero
        label.sizeToFit()
        // 만약 앞면이 아닐 경우 라벨을 숨겨버린다. 뒤집어진 카드의 라벨은 별도의 드로잉 표현이 필요없기 때문이다.
        label.isHidden = !isFaceUp
    }
    
    // * traitCollectionDidChange 메서드는 회전하는지, 가로모드인지 세로모드인지 등의 특성에 관련한 메서드이다.
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        // 화면 회전, 가로모드, 세로모드, 글씨크기 변경 등의 이벤트에 따라 반응하여 레이아웃을 갱신한다. 
        setNeedsDisplay()
        setNeedsLayout()
    }
    
    
    // * 오토레이아웃을 통해 UIView는 서브뷰를 배치한다. 이 배치가 layoutSubviews에서 진행된다.
    // * 만약 직접 원할떄 부르고 싶다면, setNeedsLayout을 사용하면 시스템이 layoutSubviews를 호출할 수 있다.
    // * setNeedsLayout -> layoutSubviews를 시스템이 호출
    // * setNeedsDisplay -> draw를 시스템이 호출
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        configureCornerLabel(upperLeftCornerLabel)
        upperLeftCornerLabel.frame.origin = bounds.origin.offsetBy(dx: cornerOffset, dy: cornerOffset)
        configureCornerLabel(lowerRightCornerLabel)
        
        // * transform은 아핀(affine) 변환이라고도 한다.
        //.  - 비트 단위의 변환을 하며, Affine은 크기, 평행이동, 회전 등을 나타낸다.
        //   - CGAffineTransform.identity.rotated를 통해 절반 회전시키면 위 아래의 라벨을 평행회전으로 뒤집어 배치할 수 있다.
        //  * CGFloat.pi를 사용해 회전하기 제한되는 이유 -> 회전축이 최 좌상단에 있기 때문
        //.   -> translatedBy + rotated 조합으로 회전축을 우측하단으로 위치조정(translatedBy) 후, 해결 가능
        lowerRightCornerLabel.transform = CGAffineTransform.identity
            .translatedBy(x: lowerRightCornerLabel.frame.size.width, y: lowerRightCornerLabel.frame.size.height)
            .rotated(by: CGFloat.pi)
        lowerRightCornerLabel.frame.origin = CGPoint(x: bounds.maxX, y:     bounds.maxY).offsetBy(dx: -cornerOffset, dy: -cornerOffset)
            .offsetBy(dx: -lowerRightCornerLabel.frame.size.width, dy: -lowerRightCornerLabel.frame.size.height)
        
    }
    
    override func draw(_ rect: CGRect) {
        let roundedRect = UIBezierPath(roundedRect: bounds, cornerRadius: 16.0)
        // addClip : rect의 외부는 별도의 드로잉을 하지 않겠다는 설정
        roundedRect.addClip()
        UIColor.white.setFill()
        roundedRect.fill()
        
    }
}

/// MARK: - Extensions

extension PlayingCardView {
    private struct SizeRatio {
        static let cornerFontSizeToBoundsHeight: CGFloat = 0.085
        static let cornerRadiusToBoundsHeight: CGFloat = 0.06
        static let cornerOffsetToCornerRadius: CGFloat = 0.33
        static let faceCardImageSizeToBoundsSize: CGFloat = 0.75
    }
    
    private var cornerRadius: CGFloat {
        return bounds.size.height * SizeRatio.cornerRadiusToBoundsHeight
    }
    
    private var cornerOffset: CGFloat {
        return cornerRadius * SizeRatio.cornerOffsetToCornerRadius
    }
    
    private var cornerFontSize: CGFloat {
        return bounds.size.height * SizeRatio.cornerFontSizeToBoundsHeight
    }
    
    private var rankString: String {
        switch rank {
        case 1: return "A"
        case 2...10: return String(rank)
        case 11: return "J"
        case 12: return "Q"
        case 13: return "K"
        default: return "?"
        }
    }
}

extension CGRect {
    var leftHalf: CGRect {
        return CGRect(x: minX, y: minY, width: width/2, height: height)
    }
    
    var rightHalf: CGRect {
        return CGRect(x: midX, y: minY, width: width/2, height: height)
    }
    
    func inset(by size: CGSize) -> CGRect {
        return insetBy(dx: size.width, dy: size.height)
    }
    
    func zoom(by scale: CGFloat) -> CGRect {
        let newWidth = width * scale
        let newHeight = height * scale
        return insetBy(dx: (width - newWidth) / 2, dy: (height - newHeight) / 2)
    }
}

extension CGPoint {
    func offsetBy(dx: CGFloat, dy: CGFloat) -> CGPoint {
        return CGPoint(x: x+dx, y: y+dy)
    }
}
