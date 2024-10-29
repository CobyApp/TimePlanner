//
//  ProgressBarView.swift
//  TimePlanner
//
//  Created by Coby on 10/28/24.
//

import UIKit

final class ProgressBarView: UIView {
    
    // MARK: - Properties
    private let completedBar = UIView() // 완료된 항목을 표시하는 막대
    private let remainingBar = UIView() // 남은 항목을 표시하는 막대
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupBars() // 바 초기 설정
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Bars
    private func setupBars() {
        self.addSubviews(self.completedBar, self.remainingBar)
    }
    
    // MARK: - Configure
    func configure(completionRate: Double, completedColor: UIColor) {
        let totalWidth = SizeLiteral.fullWidth
        let barHeight: CGFloat = 20
        
        // 완료된 막대 설정
        self.completedBar.backgroundColor = completedColor // 완료 항목의 색상
        self.completedBar.frame = CGRect(x: 0, y: 0, width: CGFloat(completionRate) * totalWidth, height: barHeight)
        
        // 남은 막대 설정
        self.remainingBar.backgroundColor = .fillStrong // 남은 항목의 색상
        self.remainingBar.frame = CGRect(x: self.completedBar.frame.width, y: 0, width: totalWidth - self.completedBar.frame.width, height: barHeight)
        
        // 막대의 프레임이 설정된 후 레이아웃을 업데이트
        self.layoutIfNeeded()
    }
}

