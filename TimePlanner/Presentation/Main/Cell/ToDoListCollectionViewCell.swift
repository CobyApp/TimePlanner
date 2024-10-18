//
//  ToDoListCollectionViewCell.swift
//  TimePlanner
//
//  Created by Coby on 10/8/24.
//

import UIKit

import SnapKit
import Then

final class ToDoListCollectionViewCell: UICollectionViewCell, BaseViewType {
    
    // MARK: - UI Components
    
    private lazy var categoryItemView: CategoryItemView = CategoryItemView().then {
        $0.configure(CategoryModel(name: "공부 +", color: CategoryColor.red))
    }
    
    private lazy var listCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.dataSource = self
        $0.delegate = self
        $0.showsVerticalScrollIndicator = false
        $0.register(ToDoListItemCollectionViewCell.self, forCellWithReuseIdentifier: ToDoListItemCollectionViewCell.className)
        $0.backgroundColor = .clear
    }
    
    // MARK: - Properties
    var checkTapAction: (() -> Void)?
    var editTapAction: (() -> Void)?
    var deleteTapAction: (() -> Void)?
    
    var toDoItems: [ToDoItemModel] = [] {
        didSet {
            listCollectionView.reloadData()
        }
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.baseInit()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    func setupLayout() {
        self.addSubviews(
            self.categoryItemView,
            self.listCollectionView
        )
        
        self.categoryItemView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        self.listCollectionView.snp.makeConstraints {
            $0.top.equalTo(self.categoryItemView.snp.bottom).offset(12)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func configureUI() {
        self.backgroundColor = .backgroundNormalNormal
    }
}

extension ToDoListCollectionViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.toDoItems.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ToDoListItemCollectionViewCell.className,
            for: indexPath
        ) as? ToDoListItemCollectionViewCell else {
            return UICollectionViewCell()
        }

        let item = toDoItems[indexPath.item]
        cell.toDoContentLabel.text = item.title // Set the title from the ToDoItem

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
        let item = toDoItems[indexPath.item]
        
        // Dynamically calculate height based on text
        let width = SizeLiteral.fullWidth - 56 // Adjust for padding
        let height = item.title.height(withConstrainedWidth: width, font: .font(size: 16, weight: .regular)) + 4 // Add padding
        
        return CGSize(width: SizeLiteral.fullWidth, height: height)
    }
}
