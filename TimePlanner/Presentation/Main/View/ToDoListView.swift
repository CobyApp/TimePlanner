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
        CGSize(width: UIView.noIntrinsicMetric, height: listCollectionView.contentSize.height)
    }

    // MARK: - UI Components
    private lazy var listCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.dataSource = self
        $0.delegate = self
        $0.showsVerticalScrollIndicator = false
        $0.register(ToDoListCollectionViewCell.self, forCellWithReuseIdentifier: ToDoListCollectionViewCell.className)
        $0.backgroundColor = .clear
    }
    
    private let emptyMessageLabel = UILabel().then {
        $0.text = "뭉치를 추가해주세요."
        $0.textColor = .labelNeutral
        $0.textAlignment = .center
        $0.isHidden = true
    }

    // MARK: - Properties
    
    private var categories: [CategoryModel] = []

    var createToDoItemTapAction: ((CategoryModel) -> Void)?
    var checkTapAction: ((CategoryModel, ToDoItemModel, @escaping () -> Void) -> Void)?
    var editTapAction: ((CategoryModel, ToDoItemModel) -> Void)?
    var deleteTapAction: ((CategoryModel, ToDoItemModel) -> Void)?

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
            self.listCollectionView,
            self.emptyMessageLabel
        )

        self.listCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.emptyMessageLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(120)
        }
    }

    func configureUI() {
        self.backgroundColor = .backgroundNormalNormal
    }
    
    func configure(_ categories: [CategoryModel]) {
        DispatchQueue.main.async { [weak self] in
            self?.categories = categories
            self?.listCollectionView.reloadData()
            self?.listCollectionView.performBatchUpdates(nil) { _ in
                self?.invalidateIntrinsicContentSize()
            }
            self?.emptyMessageLabel.isHidden = !self!.categories.isEmpty
        }
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
        cell.createToDoItemTapAction = { [weak self] category in
            self?.createToDoItemTapAction?(category)
        }
        
        cell.checkTapAction = { [weak self] item, toggle in
            self?.checkTapAction?(category, item, toggle)
        }

        cell.editTapAction = { [weak self] item in
            self?.editTapAction?(category, item)
        }

        cell.deleteTapAction = { [weak self] item in
            self?.deleteTapAction?(category, item)
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
