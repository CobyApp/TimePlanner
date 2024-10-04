//
//  ToDoListItemView.swift
//  TimePlanner
//
//  Created by Coby on 9/25/24.
//

import UIKit

import SnapKit
import Then

final class ToDoListItemView: UIView, BaseViewType {
    
    // MARK: - ui component
    
    private let checkBoxImageView = UIImageView(image: UIImage.Button.checkboxOff.resize(to: CGSize(width: 16, height: 16)))
    
    private let toDoContentLabel = UILabel().then {
        $0.text = "할 일입니다."
        $0.font = .font(size: 14, weight: .regular)
        $0.textColor = .labelNeutral
    }

    // MARK: - init

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.baseInit()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - func

    func setupLayout() {
        self.addSubviews(
            self.checkBoxImageView,
            self.toDoContentLabel
        )
        
        self.checkBoxImageView.snp.makeConstraints {
            $0.centerY.leading.equalToSuperview()
        }
        
        self.toDoContentLabel.snp.makeConstraints {
            $0.centerY.trailing.equalToSuperview()
            $0.leading.equalTo(self.checkBoxImageView.snp.trailing).offset(12)
        }
    }

    func configureUI() {
        self.backgroundColor = .backgroundNormalNormal
    }
}
