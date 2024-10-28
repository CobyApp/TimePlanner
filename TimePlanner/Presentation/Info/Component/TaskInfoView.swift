//
//  TaskInfoView.swift
//  TimePlanner
//
//  Created by Coby on 10/28/24.
//

import UIKit

import SnapKit

final class TaskInfoView: UIView, BaseViewType {
    
    // MARK: - Properties
    
    private let titleLabel = UILabel().then {
        $0.font = .font(size: 18, weight: .semibold)
        $0.textColor = .labelNormal
        $0.textAlignment = .center
    }
    
    private let countLabel = UILabel().then {
        $0.font = .font(size: 16, weight: .regular)
        $0.textColor = .labelNeutral
        $0.textAlignment = .center
    }
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.titleLabel, self.countLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 8
        return stackView
    }()
    
    // MARK: - Initializer
    
    init(title: String, countText: String) {
        super.init(frame: .zero)
        self.titleLabel.text = title
        self.countLabel.text = countText
        self.baseInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    func setupLayout() {
        self.addSubviews(self.stackView)
        
        self.stackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }
    }
    
    func configureUI() {
        self.backgroundColor = .backgroundNormalNormal
        self.layer.cornerRadius = 16
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lineNormalNormal.cgColor
        self.layer.masksToBounds = true
    }
    
    // MARK: - Update Method
    
    func updateCountText(_ text: String) {
        self.countLabel.text = text
    }
}
