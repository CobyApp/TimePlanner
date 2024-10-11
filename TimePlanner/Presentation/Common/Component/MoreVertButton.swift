//
//  MoreVertButton.swift
//  TimePlanner
//
//  Created by Coby on 9/25/24.
//

import UIKit

final class MoreVertButton: UIButton {
    
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
        self.setImage(UIImage.Button.moreVert.resize(to: CGSize(width: 20, height: 20)), for: .normal)
        self.tintColor = .labelNormal
    }
}
