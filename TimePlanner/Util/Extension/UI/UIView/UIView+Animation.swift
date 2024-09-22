//
//  UIView+Animation.swift
//  TimePlanner
//
//  Created by Coby on 9/20/24.
//

import UIKit

extension UIView {
    func fadeIn(
        duration: TimeInterval = 0.4,
        delay: TimeInterval = 0.0,
        completion: @escaping ((Bool) -> ()) = { (_: Bool) -> () in }
    ) {
        UIView.animate(withDuration: duration,
                       delay: delay,
                       options: .curveEaseIn,
                       animations: {
                        self.alpha = 1.0
                       }, completion: completion)
    }

    func fadeOut(duration: TimeInterval = 0.3) {
        UIView.animate(withDuration: duration) {
            self.alpha = 0.0
        }
    }
}
