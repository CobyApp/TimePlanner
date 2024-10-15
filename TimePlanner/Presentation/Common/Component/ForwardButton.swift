//
//  ForwardButton.swift
//  TimePlanner
//
//  Created by Coby on 10/15/24.
//

import UIKit

final class ForwardButton: UIButton {

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
        self.setImage(UIImage.Button.forward.resize(to: CGSize(width: 16, height: 16)), for: .normal)
        self.tintColor = .labelNormal
    }
}
