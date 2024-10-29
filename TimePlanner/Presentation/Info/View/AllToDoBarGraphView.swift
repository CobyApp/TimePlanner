//
//  AllToDoBarGraphView.swift
//  TimePlanner
//
//  Created by Coby on 10/29/24.
//

import UIKit

import SnapKit
import Then

final class AllToDoBarGraphView: UIView, BaseViewType {
    
    // MARK: - ui component
    
    private let titleLabel = UILabel().then {
        $0.text = "모든 할일"
        $0.font = .font(size: 17, weight: .semibold)
        $0.textColor = .labelNormal
        $0.textAlignment = .left
    }
    
    private let countLabel = UILabel().then {
        $0.font = UIFont.font(size: 16, weight: .regular)
        $0.textColor = .labelNeutral
    }
    
    private let precentLabel = UILabel().then {
        $0.font = UIFont.font(size: 16, weight: .semibold)
        $0.textColor = .labelNormal
    }
    
    private let progressBar = AllProgressBarView()
    
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
            self.titleLabel,
            self.countLabel,
            self.precentLabel,
            self.progressBar
        )
        
        self.titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
        
        self.countLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalTo(self.titleLabel.snp.trailing).offset(8)
        }
        
        self.precentLabel.snp.makeConstraints {
            $0.top.trailing.equalToSuperview()
        }
        
        self.progressBar.snp.makeConstraints {
            $0.bottom.equalTo(self.titleLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview()
        }
    }

    func configureUI() {
    }
}

extension AllToDoBarGraphView {
    
    func configure(_ categories: [CategoryModel]) {
        self.countLabel.text = "\(categories.checkedToDo) / \(categories.totalToDo)"
        self.precentLabel.text = "\(Int(categories.completionRate * 100))%"
        self.progressBar.configure(with: categories.map { $0.toProgressBarModel() })
    }
}
