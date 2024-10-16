//
//  CategoryColor.swift
//  TimePlanner
//
//  Created by Coby on 10/14/24.
//

import UIKit

enum CategoryColor: String, CaseIterable, Codable {
    
    case red, orange, lime, green, blue, purple, pink
    
    init?(tag: Int) {
        if let color = CategoryColor.allCases.first(where: { $0.rawValue.hashValue == tag }) {
            self = color
        } else {
            return nil
        }
    }
    
    init?(_ color: String) {
        if let color = CategoryColor(rawValue: color.lowercased()) {
            self = color
        } else {
            return nil
        }
    }
    
    var color: UIColor {
        switch(self) {
        case .red: .redNormal
        case .orange: .orangeNormal
        case .lime: .limeNormal
        case .green: .greenNormal
        case .blue: .blueNormal
        case .purple: .purpleNormal
        case .pink: .pinkNormal
        }
    }
}
