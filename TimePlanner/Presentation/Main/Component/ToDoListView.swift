//
//  ToDoListView.swift
//  TimePlanner
//
//  Created by Coby on 9/25/24.
//

import Combine
import UIKit

import SnapKit
import Then

final class ToDoListView: UIView, BaseViewType {
    
    // MARK: - ui component
    
    private let toDoListCategoryLabel = UILabel().then {
        $0.text = "공부 +"
        $0.font = .font(size: 17, weight: .semibold)
        $0.textColor = .labelNormal
        $0.textAlignment = .left
    }
    
    lazy var toDoListStackView: UIStackView = UIStackView(arrangedSubviews: [self.toDoListCategoryLabel, ToDoListItemView(), ToDoListItemView()]).then {
        $0.axis = .vertical
        $0.distribution = .fill
        $0.spacing = 4
    }
    
    lazy var toDoListsStackView: UIStackView = UIStackView(arrangedSubviews: [self.toDoListStackView, self.toDoListStackView]).then {
        $0.axis = .vertical
        $0.distribution = .fill
        $0.spacing = 12
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
            self.toDoListsStackView
        )
        
        self.toDoListsStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configureUI() {
        self.backgroundColor = .backgroundNormalNormal
    }
}
