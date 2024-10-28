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
    init(completionRate: Double, totalWidth: CGFloat, completedColor: UIColor) {
        super.init(frame: .zero)
        
        // 완료된 막대 설정
        self.completedBar.backgroundColor = completedColor // 완료 항목의 색상
        self.completedBar.frame = CGRect(x: 0, y: 0, width: CGFloat(completionRate) * totalWidth, height: 20)
        self.completedBar.layer.cornerRadius = 8 // 라운딩 추가
        
        // 남은 막대 설정
        self.remainingBar.backgroundColor = .fillNormal // 남은 항목의 색상
        self.remainingBar.frame = CGRect(x: self.completedBar.frame.width, y: 0, width: totalWidth - self.completedBar.frame.width, height: 20)
        self.remainingBar.layer.cornerRadius = 8 // 라운딩 추가
        
        self.addSubview(self.completedBar)
        self.addSubview(self.remainingBar)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
