//
//  UIViewController+Keyboard.swift
//  TimePlanner
//
//  Created by Coby on 9/20/24.
//

import UIKit

extension UIViewController {
    func hidekeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(endEditingView))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func endEditingView() {
        view.endEditing(true)
    }
}
