//
//  DDayCollectionView.swift
//  TimePlanner
//
//  Created by Coby on 9/25/24.
//

import Combine
import UIKit

import SnapKit
import Then

final class DDayCollectionView: UIView, BaseViewType {
    
    private enum Size {
        static let cellWidth: CGFloat = SizeLiteral.fullWidth
        static let cellHeight: CGFloat = 80
    }
    
    // MARK: - ui component
    
    private let collectionViewFlowLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .vertical
        $0.sectionInset = SizeLiteral.collectionInset
        $0.itemSize = CGSize(width: Size.cellWidth, height: Size.cellHeight)
        $0.minimumLineSpacing = 12
    }
    
    private lazy var listCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout).then {
        $0.dataSource = self
        $0.delegate = self
        $0.showsVerticalScrollIndicator = false
        $0.register(DDayCollectionViewCell.self, forCellWithReuseIdentifier: DDayCollectionViewCell.className)
        $0.backgroundColor = .clear
    }
    
    private let emptyMessageLabel = UILabel().then {
        $0.text = "작성된 디데이가 없습니다."
        $0.textColor = .labelNeutral
        $0.textAlignment = .center
        $0.isHidden = true
    }
    
    // MARK: - property
    
    var dDays: [DDayModel] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.listCollectionView.reloadData()
                self?.emptyMessageLabel.isHidden = !self!.dDays.isEmpty
            }
        }
    }
    
    var editTapAction: ((DDayModel) -> Void)?
    var deleteTapAction: ((DDayModel) -> Void)?
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.baseInit()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - base func
    
    func setupLayout() {
        self.addSubviews(
            self.listCollectionView,
            self.emptyMessageLabel
        )
        
        self.listCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.emptyMessageLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-50)
        }
    }
    
    func configureUI() {
        self.backgroundColor = .backgroundNormalNormal
    }
}

extension DDayCollectionView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        self.dDays.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: DDayCollectionViewCell.className,
            for: indexPath
        ) as? DDayCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let dDay = dDays[indexPath.item]
        
        cell.editTapAction = { [weak self] in
            self?.editTapAction?(dDay)
        }
        
        cell.deleteTapAction = { [weak self] in
            self?.deleteTapAction?(dDay)
        }
        
        cell.configure(dDay)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.editTapAction?(dDays[indexPath.item])
    }
}
