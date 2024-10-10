//
//  CompleteButton.swift
//  TimePlanner
//
//  Created by Coby on 10/10/24.
//

import UIKit

import SnapKit
import Then

final class CompleteButton: UIButton, BaseViewType {
    
    override var isEnabled: Bool {
        didSet {
            self.alpha = self.isEnabled ? 1.0 : 0.3
        }
    }
    
    // MARK: - ui component

    let label = UILabel().then {
        let label = UILabel()
        $0.textColor = .white
        $0.font = .font(size: 16, weight: .medium)
        $0.text = "완료"
    }

    // MARK: - init

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.baseInit()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - life cycle

    func setupLayout() {
        self.addSubviews(self.label)

        self.label.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    func configureUI() {
        self.isEnabled = false
        self.backgroundColor = .labelNormal
        self.layer.cornerRadius = 12
        self.layer.masksToBounds = false
    }
}
