//
//  Keyboardable.swift
//  TimePlanner
//
//  Created by Coby on 10/15/24.
//

import UIKit

protocol Keyboardable {
    func setupKeyboardGesture()
}

extension Keyboardable where Self: UIViewController {
    func setupKeyboardGesture() {
        self.hidekeyboardWhenTappedAround()
    }
}
