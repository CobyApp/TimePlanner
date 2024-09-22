//
//  UIView+Extension.swift
//  TimePlanner
//
//  Created by Coby on 9/20/24.
//

import UIKit

extension UIView {
    
    @discardableResult
    func makeShadow(
        color: UIColor,
        opacity: Float,
        offset: CGSize,
        radius: CGFloat
    ) -> Self {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        return self
    }
    
    @discardableResult
    func makeBorderLayer(color: UIColor) -> Self {
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = color.cgColor
        return self
    }
    
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}
