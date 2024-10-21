//
//  CategoryListView.swift
//  TimePlanner
//
//  Created by Coby on 10/21/24.
//

import UIKit

import SnapKit
import Then

final class CategoryListView: UIView, BaseViewType {

    private enum Size {
        static let cellWidth: CGFloat = SizeLiteral.fullWidth
        static let cellHeight: CGFloat = 40
    }
    
    // MARK: - UI Components
    
    private let collectionViewFlowLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .vertical
        $0.sectionInset = SizeLiteral.collectionInset
        $0.itemSize = CGSize(width: Size.cellWidth, height: Size.cellHeight)
        $0.minimumLineSpacing = 12
    }
    
    private lazy var listCollectionView = UICollectionView(frame: .zero, collectionViewLayout: self.collectionViewFlowLayout).then {
        $0.dataSource = self
        $0.delegate = self
        $0.showsVerticalScrollIndicator = false
        $0.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.className)
        $0.backgroundColor = .clear
    }

    // MARK: - Properties
    
    var categories: [CategoryModel] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.listCollectionView.reloadData()
            }
        }
    }

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

    // MARK: - Base Functions
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
}

extension CategoryListView: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CategoryCollectionViewCell.className,
            for: indexPath
        ) as? CategoryCollectionViewCell else {
            return UICollectionViewCell()
        }

        let category = categories[indexPath.item]
        
        cell.categoryItemView.configure(category)

        cell.editTapAction = { [weak self] in
            self?.editTapAction?()
        }

        cell.deleteTapAction = { [weak self] in
            self?.deleteTapAction?()
        }

        return cell
    }
}
