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
        $0.font = .font(size: 18, weight: .semibold)
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
        $0.font = .font(size: 20, weight: .bold)
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
        self.contentView.addSubviews(
            self.dDayTitleLabel,
            self.dDayDateLabel,
            self.dDayCountLabel
        )
        
        self.dDayTitleLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(14)
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
