//
//  BarGraphView.swift
//  TimePlanner
//
//  Created by Coby on 10/28/24.
//

import UIKit

import SnapKit

final class BarGraphView: UIView {
    
    // MARK: - Properties
    private var categories: [CategoryModel] = []
    
    // MARK: - Initializer
    init(categories: [CategoryModel] = []) {
        self.categories = categories
        super.init(frame: .zero)
        self.setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    private func setupLayout() {
        self.backgroundColor = .white // 배경색 설정
        self.layoutBars() // 막대 배치
    }
    
    // MARK: - Layout Bars
    private func layoutBars() {
        self.subviews.forEach { $0.removeFromSuperview() } // 기존의 서브뷰 제거
        
        let barHeight: CGFloat = 30 // 막대의 높이
        
        for (index, category) in self.categories.enumerated() {
            let completionRate = category.items.completionRate
            let completedCount = category.items.checkedToDo
            let totalCount = category.items.totalToDo
            
            // 카테고리 이름 레이블 추가
            let categoryItemView = CategoryItemView()
            categoryItemView.configure(category)
            self.addSubview(categoryItemView)
            
            // 완료 수/총 수 레이블 추가
            let countLabel = UILabel()
            countLabel.text = "\(completedCount)/\(totalCount)"
            countLabel.font = UIFont.font(size: 16, weight: .regular)
            countLabel.textColor = .labelNeutral // 색상 설정
            self.addSubview(countLabel)
            
            // ProgressBarView 추가
            let progressBar = ProgressBarView(completionRate: completionRate, totalWidth: self.frame.width, completedColor: category.color.color)
            self.addSubview(progressBar)
            
            // 오토 레이아웃 설정
            categoryItemView.snp.makeConstraints { make in
                make.leading.equalToSuperview()
                make.bottom.equalTo(progressBar.snp.top).offset(-5) // 막대 위에 위치
            }
            
            countLabel.snp.makeConstraints { make in
                make.leading.equalTo(categoryItemView.snp.trailing).offset(8) // 카테고리 이름 오른쪽에 위치
                make.bottom.equalTo(progressBar.snp.top).offset(-5) // 막대 위에 위치
            }
            
            progressBar.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(CGFloat(index) * (barHeight + 10) + 30) // 카테고리 레이블 아래에 위치
                make.leading.equalToSuperview() // 부모 뷰의 너비에 맞춤
                make.trailing.equalToSuperview() // 부모 뷰의 너비에 맞춤
                make.height.equalTo(barHeight) // 막대의 높이 설정
            }
        }
        
        // 전체 높이 설정
        self.snp.makeConstraints { make in
            make.height.equalTo(CGFloat(self.categories.count) * (barHeight + 10) + 30) // 카테고리 이름 공간 추가
        }
    }
    
    // MARK: - Update Categories
    func updateCategories(_ categories: [CategoryModel]) {
        self.categories = categories
        self.layoutBars() // 막대 재배치
    }
}
