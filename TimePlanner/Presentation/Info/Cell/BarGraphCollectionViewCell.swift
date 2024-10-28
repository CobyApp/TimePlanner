//
//  BarGraphCollectionViewCell.swift
//  TimePlanner
//
//  Created by Coby on 10/28/24.
//

import UIKit

import SnapKit
import Then

final class BarGraphCollectionViewCell: UICollectionViewCell, BaseViewType {
    
    // MARK: - ui component
    
    private let categoryItemView = CategoryItemView()
    
    private let countLabel = UILabel().then {
        $0.font = UIFont.font(size: 16, weight: .regular)
        $0.textColor = .labelNeutral
    }
    
    private let progressBar = ProgressBarView()
    
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
        self.contentView.addSubviews(
            self.categoryItemView,
            self.countLabel,
            self.progressBar
        )
        
        self.categoryItemView.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
        
        self.countLabel.snp.makeConstraints {
            $0.top.trailing.equalToSuperview()
            $0.leading.equalTo(self.categoryItemView.snp.trailing).offset(8)
        }
        
        self.progressBar.snp.makeConstraints {
            $0.bottom.equalTo(self.categoryItemView.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
        }
    }

    func configureUI() {
    }
}

extension BarGraphCollectionViewCell {
    
    func configure(_ category: CategoryModel) {
        self.categoryItemView.configure(category)
        self.countLabel.text = "\(category.items.checkedToDo)/\(category.items.totalToDo)"
        self.progressBar.configure(
            completionRate: category.items.completionRate,
            completedColor: category.color.color
        )
    }
}
