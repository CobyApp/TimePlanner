//
//  MoreButton.swift
//  TimePlanner
//
//  Created by Coby on 9/22/24.
//

import UIKit

final class MoreButton: UIButton {
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: .init(origin: .zero, size: .init(width: 44, height: 44)))
        self.configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - func
    
    private func configUI() {
        self.setImage(UIImage.Button.more, for: .normal)
        self.tintColor = .labelNormal
    }
}