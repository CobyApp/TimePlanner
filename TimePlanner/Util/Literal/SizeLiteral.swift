//
//  SizeLiteral.swift
//  TimePlanner
//
//  Created by Coby on 9/22/24.
//

import UIKit

enum SizeLiteral {
    
    static let horizantalPadding: CGFloat = 20
    static let verticalPadding: CGFloat = 16
    static let bottomPadding: CGFloat = 10 + bottomAreaPadding
    static let fullWidth: CGFloat = UIScreen.main.bounds.size.width - horizantalPadding * 2
    static let collectionInset = UIEdgeInsets(
        top: verticalPadding,
        left: horizantalPadding,
        bottom: verticalPadding * 2,
        right: horizantalPadding
    )
    static var topAreaPadding: CGFloat {
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        let topPadding = window?.safeAreaInsets.top ?? 0
        return topPadding
    }

    static var bottomAreaPadding: CGFloat {
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        let bottomPadding = window?.safeAreaInsets.bottom ?? 0
        return bottomPadding
    }
}
