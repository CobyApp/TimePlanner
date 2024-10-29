//
//  BarGraphCollectionView.swift
//  TimePlanner
//
//  Created by Coby on 10/28/24.
//

import UIKit

import SnapKit
import Then

final class BarGraphCollectionView: UIView, BaseViewType {
    
    private enum Size {
        static let cellWidth: CGFloat = SizeLiteral.fullWidth
        static let cellHeight: CGFloat = 80
    }
    
    // MARK: - ui component
    
    private let collectionViewFlowLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .vertical
        $0.sectionInset = SizeLiteral.collectionInset
        $0.itemSize = CGSize(width: Size.cellWidth, height: Size.cellHeight)
        $0.minimumLineSpacing = 4
    }
    
    private lazy var listCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout).then {
        $0.dataSource = self
        $0.delegate = self
        $0.showsVerticalScrollIndicator = false
        $0.register(BarGraphCollectionViewCell.self, forCellWithReuseIdentifier: BarGraphCollectionViewCell.className)
        $0.backgroundColor = .clear
    }
    
    // MARK: - property
    
    private var categories: [CategoryModel] = []
    
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
            self.listCollectionView
        )
        
        self.listCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configureUI() {
        self.backgroundColor = .backgroundNormalNormal
    }
    
    func configure(_ categories: [CategoryModel]) {
        DispatchQueue.main.async { [weak self] in
            self?.categories = categories
            self?.listCollectionView.reloadData()
        }
    }
}

extension BarGraphCollectionView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        self.categories.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: BarGraphCollectionViewCell.className,
            for: indexPath
        ) as? BarGraphCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(self.categories[indexPath.item])

        return cell
    }
}
