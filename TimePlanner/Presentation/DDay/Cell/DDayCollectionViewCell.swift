//
//  DDayCollectionViewCell.swift
//  TimePlanner
//
//  Created by Coby on 9/24/24.
//

import UIKit

import SnapKit
import Then

final class DDayCollectionViewCell: UICollectionViewCell, BaseViewType {
    
    // MARK: - ui component
    
    private let dDayTitleLabel = UILabel().then {
        $0.text = "디데이 제목"
        $0.font = .font(size: 16, weight: .medium)
        $0.textColor = .labelNormal
        $0.numberOfLines = 0
    }
    
    private let dDayDateLabel = UILabel().then {
        $0.text = "2024.09.25(수)"
        $0.font = .font(size: 14, weight: .regular)
        $0.textColor = .labelNeutral
    }
    
    private let dDayCountLabel = UILabel().then {
        $0.text = "D - 10"
        $0.font = .font(size: 20, weight: .semibold)
        $0.textColor = .labelNeutral
    }
    
    private lazy var moreVertbutton = MoreVertButton().then {
        let action1 = UIAction(title: "편집") { [weak self] _ in
        }
        let action2 = UIAction(title: "삭제") { [weak self] _ in
        }
        let menu = UIMenu(children: [action1, action2])
        $0.menu = menu
        $0.showsMenuAsPrimaryAction = true
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
        self.contentView.addSubviews(
            self.dDayTitleLabel,
            self.dDayDateLabel,
            self.dDayCountLabel,
            self.moreVertbutton
        )
        
        self.dDayTitleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(14)
            $0.trailing.equalTo(self.moreVertbutton.snp.leading).offset(12)
        }
        
        self.moreVertbutton.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(12)
        }
        
        self.dDayDateLabel.snp.makeConstraints {
            $0.bottom.leading.equalToSuperview().inset(14)
        }
        
        self.dDayCountLabel.snp.makeConstraints {
            $0.bottom.trailing.equalToSuperview().inset(12)
        }
    }

    func configureUI() {
        self.backgroundColor = .backgroundNormalNormal
        self.clipsToBounds = true
        self.makeBorderLayer(color: .lineNormalNormal)
    }
}
