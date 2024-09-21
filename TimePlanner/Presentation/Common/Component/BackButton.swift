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
        super.init(frame: .init(origin: .zero, size: .init(width: 44, height: 44)))
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - func
    
    private func configUI() {
        self.setImage(UIImage.Button.back, for: .normal)
        self.tintColor = .white
    }
}
