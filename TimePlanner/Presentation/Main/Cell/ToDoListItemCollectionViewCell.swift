//
//  ToDoListItemCollectionViewCell.swift
//  TimePlanner
//
//  Created by Coby on 9/25/24.
//

import UIKit
import SnapKit
import Then

final class ToDoListItemCollectionViewCell: UICollectionViewCell, BaseViewType {
    
    // MARK: - UI Components
    private let checkBoxImageView = UIImageView(image: UIImage.Button.checkboxOff.resize(to: CGSize(width: 20, height: 20)).withTintColor(.labelNeutral))
    
    let toDoContentLabel = UILabel().then {
        $0.text = "할 일입니다."
        $0.font = .font(size: 16, weight: .regular)
        $0.textColor = .labelNeutral
        $0.numberOfLines = 0
    }
    
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
    var checkTapAction: (() -> Void)?
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
            self.checkBoxImageView,
            self.toDoContentLabel,
            self.smallMoreButton
        )
        
        self.checkBoxImageView.snp.makeConstraints {
            $0.centerY.leading.equalToSuperview()
            $0.height.width.equalTo(20)
        }
        
        self.toDoContentLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(self.checkBoxImageView.snp.trailing).offset(8)
            $0.trailing.equalTo(self.smallMoreButton.snp.leading).offset(-8)
        }
        
        self.smallMoreButton.snp.makeConstraints {
            $0.centerY.trailing.equalToSuperview()
            $0.height.width.equalTo(20)
        }
    }
    
    func configureUI() {
        self.backgroundColor = .backgroundNormalNormal
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.toDoContentLabel.sizeToFit() // 라벨의 크기를 내용에 맞게 조정
    }
}
