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
    
    var categories: [ToDoCategory] = [] {
        didSet {
            listCollectionView.reloadData()
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
        return categories.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ToDoListCollectionViewCell.className,
            for: indexPath
        ) as? ToDoListCollectionViewCell else {
            return UICollectionViewCell()
        }

        let category = categories[indexPath.item]
        cell.toDoItems = category.items
        
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
        let category = categories[indexPath.item]
        
        // ToDo 항목의 수에 따라 동적 높이를 계산
        let numberOfItems = category.items.count
        let itemHeight: CGFloat = 60 // 각 ToDoItemView의 높이 (필요에 따라 조정 가능)
        let spacing: CGFloat = 4 // 스택뷰 간의 간격
        let totalHeight = CGFloat(numberOfItems) * (itemHeight + spacing) + 40 // 상단 여백을 포함한 전체 높이
        
        return CGSize(width: SizeLiteral.fullWidth, height: totalHeight)
    }
}
