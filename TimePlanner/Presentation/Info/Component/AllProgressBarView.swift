//
//  AllProgressBarView.swift
//  TimePlanner
//
//  Created by Coby on 10/29/24.
//

import UIKit

final class AllProgressBarView: UIView {
    
    // MARK: - Properties
    private var barViews: [UIView] = [] // 막대 뷰 배열
    
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
        self.barViews.forEach { $0.removeFromSuperview() } // 이전 막대 뷰 제거
        self.barViews.removeAll() // 막대 뷰 배열 초기화
    }
    
    // MARK: - Configure
    func configure(with data: [ProgressBarModel]) {
        self.setupBars() // 기존 막대 뷰 초기화

        guard !data.isEmpty else {
            // 데이터가 비어있을 경우, 전체를 회색으로 채움
            let barHeight: CGFloat = 20
            let fillBar = UIView(frame: CGRect(x: 0, y: 0, width: SizeLiteral.fullWidth, height: barHeight))
            fillBar.backgroundColor = .fillStrong // 회색으로 설정
            self.addSubview(fillBar) // 회색 막대 추가
            self.barViews.append(fillBar) // 배열에 저장
            self.layoutIfNeeded()
            return
        }
        
        let totalSum = data.reduce(0) { $0 + $1.totalCount } // 모든 totalCount의 합

        // totalCount가 0인 경우 처리
        guard totalSum > 0 else {
            // totalCount가 0일 경우에도 회색으로 채움
            let barHeight: CGFloat = 20
            let fillBar = UIView(frame: CGRect(x: 0, y: 0, width: SizeLiteral.fullWidth, height: barHeight))
            fillBar.backgroundColor = .fillStrong // 회색으로 설정
            self.addSubview(fillBar) // 회색 막대 추가
            self.barViews.append(fillBar) // 배열에 저장
            self.layoutIfNeeded()
            return
        }

        let totalWidth = SizeLiteral.fullWidth
        let barHeight: CGFloat = 20
        var xOffset: CGFloat = 0 // x 위치 조정
        
        for item in data {
            let proportion = Double(item.completionCount) / Double(totalSum) // 비율 계산
            let barWidth = CGFloat(proportion) * totalWidth // 막대 너비
            
            // barWidth가 0보다 클 때만 막대 추가
            if barWidth > 0 {
                let barView = UIView(frame: CGRect(x: xOffset, y: 0, width: barWidth, height: barHeight))
                barView.backgroundColor = item.completedColor // 해당 색상 설정
                self.addSubview(barView) // 막대 추가
                self.barViews.append(barView) // 배열에 저장
                
                xOffset += barWidth // x 위치 업데이트
            }
        }
        
        // 남은 부분 회색으로 설정
        if xOffset < totalWidth {
            let remainingBar = UIView(frame: CGRect(x: xOffset, y: 0, width: totalWidth - xOffset, height: barHeight))
            remainingBar.backgroundColor = .fillStrong // 남은 항목의 색상
            self.addSubview(remainingBar) // 남은 막대 추가
            self.barViews.append(remainingBar) // 배열에 저장
        }

        // 레이아웃 업데이트
        self.layoutIfNeeded()
    }
}
