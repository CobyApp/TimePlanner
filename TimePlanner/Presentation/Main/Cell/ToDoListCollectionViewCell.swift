//
//  ToDoListCollectionViewCell.swift
//  TimePlanner
//
//  Created by Coby on 10/8/24.
//

import Combine
import UIKit

import SnapKit
import Then

final class ToDoListCollectionViewCell: UICollectionViewCell, BaseViewType {
    
    private enum Size {
        static let cellWidth: CGFloat = SizeLiteral.fullWidth
        static let cellHeight: CGFloat = 80
    }
    
    // MARK: - ui component
    
    private let toDoListCategoryLabel = UILabel().then {
        $0.text = "공부 +"
        $0.font = .font(size: 17, weight: .semibold)
        $0.textColor = .labelNormal
        $0.textAlignment = .left
    }
    
    private lazy var toDoListItemStackView: UIStackView = UIStackView(arrangedSubviews: [ToDoListItemView(), ToDoListItemView()]).then {
        $0.axis = .vertical
        $0.distribution = .fill
        $0.spacing = 4
    }
    
    // MARK: - property
    
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
            self.toDoListCategoryLabel,
            self.toDoListItemStackView
        )
        
        self.toDoListCategoryLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        self.toDoListItemStackView.snp.makeConstraints {
            $0.top.equalTo(self.toDoListCategoryLabel.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func configureUI() {
        self.backgroundColor = .backgroundNormalNormal
    }
}
