//
//  PlusButton.swift
//  TimePlanner
//
//  Created by Coby on 9/24/24.
//

import UIKit

final class PlusButton: UIButton {
    
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
        self.setImage(UIImage.Button.plus.resize(to: CGSize(width: 24, height: 24)), for: .normal)
        self.tintColor = .labelNormal
    }
}