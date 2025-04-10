//
//  CutomSegmentedControl.swift
//  kioskapp
//
//  Created by 최안용 on 4/9/25.
//

import UIKit

final class CutomSegmentedControl: UISegmentedControl {
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 0
    }
}

extension CALayer {
    func addBottomBorder(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.frame = CGRect.init(x: 0, y: frame.height + width, width: frame.width, height: width)
        border.backgroundColor = color.cgColor
        self.addSublayer(border)
    }
}
