//
//  SettingItemTableViewCell.swift
//  TimePlanner
//
//  Created by Coby on 10/15/24.
//

import UIKit

import SnapKit
import Then

final class SettingItemTableViewCell: UITableViewCell, BaseViewType {
    
    // MARK: - ui component
    
    let menuLabel = UILabel().then {
        $0.textColor = .labelNormal
        $0.font = .font(size: 17, weight: .regular)
        $0.text = "설정"
    }
    
    private let forwardButton = ForwardButton()

    // MARK: - init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.baseInit()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupLayout() {
        self.contentView.addSubviews(self.menuLabel, self.forwardButton)

        self.menuLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(SizeLiteral.horizantalPadding)
            $0.centerY.equalToSuperview()
        }

        self.forwardButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(SizeLiteral.horizantalPadding)
            $0.centerY.equalToSuperview()
        }
    }

    func configureUI() {
        self.backgroundColor = .backgroundNormalNormal
    }
}
