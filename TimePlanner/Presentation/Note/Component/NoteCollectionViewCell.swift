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
        $0.text = ""
        $0.font = .font(size: 16, weight: .semibold)
        $0.textColor = .labelNormal
        $0.numberOfLines = 0
    }
    
    private let noteDateLabel = UILabel().then {
        $0.text = ""
        $0.font = .font(size: 14, weight: .regular)
        $0.textColor = .labelAssistive
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
        self.contentView.addSubviews()
    }

    func configureUI() {
        self.backgroundColor = .backgroundNormalNormal
        self.clipsToBounds = true
        self.makeBorderLayer(color: .lineNormalNormal)
    }
}
