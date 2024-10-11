//
//  BackButton.swift
//  TimePlanner
//
//  Created by Coby on 9/20/24.
//

import UIKit

final class BackButton: UIButton {

    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: .init(origin: .zero, size: .init(width: 40, height: 40)))
        self.configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - func
    
    private func configUI() {
        self.setImage(UIImage.Button.back.resize(to: CGSize(width: 24, height: 24)), for: .normal)
        self.tintColor = .labelNormal
    }
}
