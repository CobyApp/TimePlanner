//
//  SmallMoreButton.swift
//  TimePlanner
//
//  Created by Coby on 10/11/24.
//

import UIKit

final class SmallMoreButton: UIButton {
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: .init(origin: .zero, size: .init(width: 20, height: 20)))
        self.configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - func
    
    private func configUI() {
        self.setImage(UIImage.Button.more.resize(to: CGSize(width: 20, height: 20)), for: .normal)
        self.tintColor = .labelNormal
    }
}
