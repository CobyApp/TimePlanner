//
//  FontSet.swift
//  TimePlanner
//
//  Created by Coby on 9/20/24.
//

import UIKit

enum PretendardWeight: CaseIterable {
    case regular, medium, semibold, bold
    
    public var fontName: String {
        switch self {
        case .regular:
            return "Pretendard-Regular"
        case .medium:
            return "Pretendard-Medium"
        case .semibold:
            return "Pretendard-SemiBold"
        case .bold:
            return "Pretendard-Bold"
        }
    }
}

extension UIFont {
    static func font(size: CGFloat, weight: PretendardWeight = .regular) -> UIFont {
        return UIFont(name: weight.fontName, size: size)!
    }
}
