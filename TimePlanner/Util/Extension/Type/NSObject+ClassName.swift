//
//  NSObject+ClassName.swift
//  TimePlanner
//
//  Created by Coby on 9/20/24.
//

import Foundation

extension NSObject {
    static var className: String {
        return String(describing: self)
    }
}
