//
//  ToDoListView.swift
//  TimePlanner
//
//  Created by Coby on 9/25/24.
//

import UIKit

import SnapKit
import Then

final class ToDoListView: UIView, BaseViewType {

    override var intrinsicContentSize: CGSize {
        self.listCollectionView.layoutIfNeeded()
        let contentHeight = self.listCollectionView.contentSize.height
        return CGSize(width: UIView.noIntrinsicMetric, height: contentHeight)
    }

    // MARK: - UI Components
    private lazy var listCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.dataSource = self
        $0.delegate = self
        $0.showsVerticalScrollIndicator = false
        $0.register(ToDoListCollectionViewCell.self, forCellWithReuseIdentifier: ToDoListCollectionViewCell.className)
        $0.backgroundColor = .clear
    }

    // MARK: - Properties
    
    var categories: [CategoryModel] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.listCollectionView.reloadData()
                self?.listCollectionView.performBatchUpdates(nil) { _ in
                    self?.invalidateIntrinsicContentSize()
                }
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

extension ToDoListView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.categories.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ToDoListCollectionViewCell.className,
            for: indexPath
        ) as? ToDoListCollectionViewCell else {
            return UICollectionViewCell()
        }

        let category = self.categories[indexPath.item]
        
        cell.configure(category)
        
        // 각 셀의 액션 핸들러 설정
        cell.checkTapAction = { [weak self] in
            self?.checkTapAction?()
        }

        cell.editTapAction = { [weak self] in
            self?.editTapAction?()
        }

        cell.deleteTapAction = { [weak self] in
            self?.deleteTapAction?()
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let category = self.categories[indexPath.item]
        
        // ToDo 항목의 수에 따라 동적 높이를 계산
        let totalHeight = category.items.reduce(40) { (result, item) in
            let itemHeight = item.title.height(withConstrainedWidth: SizeLiteral.fullWidth - 56, font: .font(size: 16, weight: .regular)) + 10
            return result + itemHeight + 4 // Add spacing
        }
        
        return CGSize(width: SizeLiteral.fullWidth, height: totalHeight)
    }
}
