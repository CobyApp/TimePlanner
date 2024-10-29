//
//  MonthView.swift
//  TimePlanner
//
//  Created by Coby on 10/29/24.
//

import UIKit
import SnapKit
import Then

final class MonthView: UIView {
    
    // MARK: - UI Components
    private let selectedDateLabel = UILabel().then {
        $0.textAlignment = .left
        $0.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    }
    
    private lazy var prevMonthButton = UIButton().then {
        $0.tintColor = .labelNormal
        $0.setImage(UIImage.Button.back.resize(to: CGSize(width: 20, height: 20)), for: .normal)
        $0.addAction(UIAction { [weak self] _ in self?.goToPreviousMonth() }, for: .touchUpInside)
    }
    
    private lazy var nextMonthButton = UIButton().then {
        $0.tintColor = .labelNormal
        $0.setImage(UIImage.Button.forward.resize(to: CGSize(width: 20, height: 20)), for: .normal)
        $0.addAction(UIAction { [weak self] _ in self?.goToNextMonth() }, for: .touchUpInside)
    }
    
    private var currentMonth: Date = Date() {
        didSet {
            updateSelectedDateLabel()
        }
    }
    
    var selectedDate: Date = Date() {
        didSet {
            updateSelectedDateLabel()
        }
    }
    
    var onDateSelected: ((Date) -> Void)?
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupTopView()
        self.updateSelectedDateLabel()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupTopView()
        self.updateSelectedDateLabel()
    }

    // MARK: - Methods
    private func setupTopView() {
        let buttonStackView = UIStackView(arrangedSubviews: [self.prevMonthButton, self.nextMonthButton]).then {
            $0.axis = .horizontal
            $0.distribution = .fillEqually
            $0.spacing = 20
        }
        let topStackView = UIStackView(arrangedSubviews: [self.selectedDateLabel, buttonStackView]).then {
            $0.axis = .horizontal
            $0.distribution = .equalSpacing
            $0.alignment = .center
        }
        self.addSubview(topStackView)
        topStackView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(10)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(50)
        }
    }
    
    private func updateSelectedDateLabel() {
        let formatter = DateFormatter().then {
            $0.dateFormat = "yyyy년 MM월"
        }
        self.selectedDateLabel.text = formatter.string(from: currentMonth)
        self.onDateSelected?(currentMonth) // 선택된 날짜 전달
    }
    
    private func goToPreviousMonth() {
        self.changeMonth(by: -1)
    }
    
    private func goToNextMonth() {
        self.changeMonth(by: 1)
    }
    
    private func changeMonth(by value: Int) {
        if let newDate = Calendar.current.date(byAdding: .month, value: value, to: currentMonth) {
            self.currentMonth = newDate
            self.selectedDate = newDate // 현재 월이 변경될 때 선택된 날짜도 업데이트
        }
    }
}
