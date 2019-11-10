//
//  PlayingCardView.swift
//  PlayingCard
//
//  Created by MinKyeongTae on 10/11/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

class PlayingCardView: UIView {
    
    override func draw(_ rect: CGRect) {
        // fraw 메서드에서 활용할 수 있는 UIGraphicsGetCurrentContext 메서드
        // -> 현재 그래픽 내용을 반환
        // context가 draw메서드 내에서 nil을 반환할일은 없지만 그냥 if let 옵셔널 바인딩 처리
        // bezierPath 적용 예시 1) BezierPath를 그릴때 경로가 보존되지 않으므로 fillPath가 적용 될 수 없다.
//        if let context = UIGraphicsGetCurrentContext() {
//            context.addArc(center: CGPoint(x: bounds.midX, y: bounds.midY), radius: 100.0, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true)
//            context.setLineWidth(5.0)
//            UIColor.green.setFill()
//            UIColor.red.setStroke()
//            context.strokePath()
//            context.fillPath()
//        }
        
        // bezierPath 적용 예시 2) BezierPath를 그릴때 경로가 그대로 보존되게 되어 fillPath가 적용 될 수 있다.
        let path = UIBezierPath()
        path.addArc(withCenter: CGPoint(x: bounds.midX, y: bounds.midY), radius: 100.0, startAngle: 0, endAngle: CGFloat.pi*2, clockwise: true)
        path.lineWidth = 5.0
        UIColor.green.setFill()
        UIColor.red.setStroke()
        path.stroke()
        path.fill()
        
        
        
        
        
    }

    
    

}
