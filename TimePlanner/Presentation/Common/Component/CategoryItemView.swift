//
//  CategoryItemView.swift
//  TimePlanner
//
//  Created by Coby on 10/18/24.
//

import UIKit

import SnapKit
import Then

final class CategoryItemView: UIButton, BaseViewType {
    
    // MARK: - ui component
    
    private let colorView = UIView().then {
        $0.layer.cornerRadius = 4
        $0.layer.masksToBounds = true
    }
    
    private let label = UILabel().then {
        $0.text = "뭉치"
        $0.font = .font(size: 17, weight: .semibold)
        $0.textColor = .labelNormal
        $0.textAlignment = .left
    }
    
    // MARK: - Properties
    
    var createToDoItemTapAction: (() -> Void)?
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.baseInit()
        self.addTarget(self, action: #selector(self.didTap), for: .touchUpInside)
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - life cycle
    
    func setupLayout() {
        self.addSubviews(
            self.colorView,
            self.label
        )
        
        self.colorView.snp.makeConstraints {
            $0.top.bottom.leading.equalToSuperview()
            $0.width.equalTo(8)
        }
        
        self.label.snp.makeConstraints {
            $0.top.bottom.trailing.equalToSuperview()
            $0.leading.equalTo(self.colorView.snp.trailing).offset(8)
        }
        
        self.snp.makeConstraints{
            $0.height.equalTo(self.label.intrinsicContentSize.height)
        }
    }
    
    func configureUI() {
        self.backgroundColor = .clear
    }
}

extension CategoryItemView {
    func configure(_ category: CategoryModel) {
        self.colorView.backgroundColor = category.color.color
        self.label.text = category.name
    }
    
    @objc private func didTap() {
        self.createToDoItemTapAction?()
    }
}
