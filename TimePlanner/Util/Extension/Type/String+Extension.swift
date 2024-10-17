//
//  String+Extension.swift
//  TimePlanner
//
//  Created by Coby on 10/17/24.
//

import UIKit

// MARK: - String Extension for Height Calculation
extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
}
