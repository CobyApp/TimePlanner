//
//  NoteCollectionViewCell.swift
//  TimePlanner
//
//  Created by Coby on 9/24/24.
//

import UIKit

import SnapKit
import Then

final class NoteCollectionViewCell: UICollectionViewCell, BaseViewType {
    
    // MARK: - ui component
    
    private let noteContentLabel = UILabel().then {
        $0.text = "노트 내용입니다."
        $0.font = .font(size: 16, weight: .regular)
        $0.textColor = .labelNormal
        $0.numberOfLines = 3
    }
    
    private let noteDateLabel = UILabel().then {
        $0.text = "2024.09.25"
        $0.font = .font(size: 14, weight: .regular)
        $0.textColor = .labelNeutral
    }
    
    private lazy var moreVertbutton = MoreVertButton().then {
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
            self.noteContentLabel,
            self.noteDateLabel,
            self.moreVertbutton
        )
        
        self.noteContentLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(14)
        }
        
        self.noteDateLabel.snp.makeConstraints {
            $0.bottom.leading.equalToSuperview().inset(14)
        }
        
        self.moreVertbutton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(6)
            $0.bottom.equalToSuperview().inset(12)
        }
    }

    func configureUI() {
        self.backgroundColor = .backgroundNormalNormal
        self.clipsToBounds = true
        self.makeBorderLayer(color: .lineNormalNormal)
    }
}
