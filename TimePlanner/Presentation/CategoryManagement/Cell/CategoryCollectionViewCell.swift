//
//  CategoryCollectionViewCell.swift
//  TimePlanner
//
//  Created by Coby on 10/21/24.
//

import UIKit

import SnapKit
import Then

final class CategoryCollectionViewCell: UICollectionViewCell, BaseViewType {
    
    // MARK: - UI Components
    let categoryItemView: CategoryItemView = CategoryItemView()
    
    private lazy var smallMoreButton = SmallMoreButton().then {
        let action1 = UIAction(title: "편집") { [weak self] _ in
            self?.editTapAction?()
        }
        let action2 = UIAction(title: "삭제") { [weak self] _ in
            self?.deleteTapAction?()
        }
        let menu = UIMenu(children: [action1, action2])
        $0.menu = menu
        $0.showsMenuAsPrimaryAction = true
    }
    
    // MARK: - Properties
    var editTapAction: (() -> Void)?
    var deleteTapAction: (() -> Void)?

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.baseInit()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    func setupLayout() {
        self.addSubviews(
            self.categoryItemView,
            self.smallMoreButton
        )
        
        self.categoryItemView.snp.makeConstraints {
            $0.centerY.leading.equalToSuperview()
            $0.trailing.equalTo(self.smallMoreButton.snp.leading).offset(-10)
        }
        
        self.smallMoreButton.snp.makeConstraints {
            $0.centerY.trailing.equalToSuperview()
            $0.height.width.equalTo(20)
        }
    }
    
    func configureUI() {
        self.backgroundColor = .backgroundNormalNormal
    }
}
