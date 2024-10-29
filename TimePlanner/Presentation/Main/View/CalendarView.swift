//
//  CalendarView.swift
//  TimePlanner
//
//  Created by Coby on 9/25/24.
//

import UIKit

import SnapKit
import Then

final class CalendarView: UIView {
    
    override var intrinsicContentSize: CGSize {
        return calculateIntrinsicContentSize()
    }
    
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
    
    private var currentMonth: Date = Date()
    private var selectedDate: Date = Date()
    private var dateGridView = UIView()
    private var selectedButton: UIButton?
    
    var onDateSelected: ((Date) -> Void)?
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupTopView()
        self.setupCalendarView()
        self.updateSelectedDateLabel()
        self.renderCalendar(for: self.currentMonth)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupTopView()
        self.setupCalendarView()
        self.updateSelectedDateLabel()
        self.renderCalendar(for: self.currentMonth)
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
            $0.dateFormat = "yyyy년 MM월 dd일"
        }
        self.selectedDateLabel.text = formatter.string(from: self.selectedDate)
    }
    
    private func goToPreviousMonth() { self.changeMonth(by: -1) }
    private func goToNextMonth() { self.changeMonth(by: 1) }
    
    private func changeMonth(by value: Int) {
        self.currentMonth = Calendar.current.date(byAdding: .month, value: value, to: self.currentMonth)!
        self.selectedDate = adjustSelectedDate(for: self.currentMonth)
        self.updateSelectedDateLabel()
        self.renderCalendar(for: self.currentMonth)
        self.invalidateIntrinsicContentSize()
    }

    private func setupCalendarView() {
        let dayOfWeekStackView = createDayOfWeekStackView()
        self.addSubview(dayOfWeekStackView)
        dayOfWeekStackView.snp.makeConstraints {
            $0.top.equalTo(self.selectedDateLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(30)
        }
        self.addSubview(self.dateGridView)
        self.dateGridView.snp.makeConstraints {
            $0.top.equalTo(dayOfWeekStackView.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    private func renderCalendar(for date: Date) {
        self.dateGridView.subviews.forEach { $0.removeFromSuperview() }
        self.selectedButton = nil

        let firstWeekday = getFirstWeekday(of: date)
        let numberOfDays = getNumberOfDays(in: date)

        var currentDay = 1
        var isFirstWeek = true

        let selectedDay = Calendar.current.component(.day, from: self.selectedDate) // 선택된 날짜의 일(day)을 가져옴

        for row in 0..<6 {
            let rowStackView = createRowStackView()
            var hasDaysInRow = false

            for col in 0..<7 {
                let dateButton = UIButton().then {
                    if isFirstWeek && col < firstWeekday {
                        $0.setTitle("", for: .normal)
                    } else if currentDay <= numberOfDays {
                        $0.setTitle("\(currentDay)", for: .normal)
                        self.styleDateButton($0, day: currentDay)
                        $0.addTarget(self, action: #selector(dateButtonTapped(_:)), for: .touchUpInside)
                        
                        // 선택된 날짜와 현재 날짜 비교 후 스타일 적용
                        if currentDay == selectedDay && Calendar.current.isDate(self.selectedDate, equalTo: date, toGranularity: .month) {
                            self.selectedButton = $0
                            self.selectedButton?.layer.borderColor = UIColor.lineSolidNormal.cgColor
                            self.selectedButton?.backgroundColor = .fillStrong
                            self.selectedButton?.alpha = 1.0
                        } else {
                            $0.alpha = 0.5 // 기본 불투명도 설정
                        }
                        
                        hasDaysInRow = true
                        currentDay += 1
                    } else {
                        $0.setTitle("", for: .normal)
                    }
                }
                let container = createButtonContainer(with: dateButton)
                rowStackView.addArrangedSubview(container)
            }

            if hasDaysInRow {
                self.dateGridView.addSubview(rowStackView)
                rowStackView.snp.makeConstraints {
                    $0.leading.trailing.equalToSuperview()
                    $0.top.equalToSuperview().offset(row * 50) // 행 간격 조정
                    $0.height.equalTo(50) // 정사각형 버튼 높이 설정
                }
            }
            isFirstWeek = false
        }
    }
    
    private func adjustSelectedDate(for month: Date) -> Date {
        let lastDay = Calendar.current.range(of: .day, in: .month, for: month)!.upperBound - 1
        var components = Calendar.current.dateComponents([.year, .month, .day], from: self.selectedDate)
        components.month = Calendar.current.component(.month, from: month)
        components.year = Calendar.current.component(.year, from: month)
        components.day = min(components.day ?? 1, lastDay)
        return Calendar.current.date(from: components)!
    }
    
    private func calculateIntrinsicContentSize() -> CGSize {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: self.currentMonth)
        guard let firstDayOfMonth = calendar.date(from: components),
              let range = calendar.range(of: .day, in: .month, for: firstDayOfMonth) else {
            return CGSize(width: UIView.noIntrinsicMetric, height: 0)
        }
        
        let numberOfDays = range.count
        let firstWeekday = calendar.component(.weekday, from: firstDayOfMonth) - 1
        let totalRows = (numberOfDays + firstWeekday + 6) / 7
        let rowHeight: CGFloat = 50 // 정사각형 셀의 높이
        let totalHeight = CGFloat(totalRows) * rowHeight + CGFloat(totalRows - 1) * 5 + 80
        return CGSize(width: UIView.noIntrinsicMetric, height: totalHeight)
    }

    private func getFirstWeekday(of date: Date) -> Int {
        return Calendar.current.component(.weekday, from: Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: date))!) - 1
    }
    
    private func getNumberOfDays(in date: Date) -> Int {
        return Calendar.current.range(of: .day, in: .month, for: date)!.count
    }
    
    private func createDayOfWeekStackView() -> UIStackView {
        let dayOfWeekStackView = UIStackView().then {
            $0.axis = .horizontal
            $0.distribution = .fillEqually
            $0.spacing = 5
        }
        let days = ["일", "월", "화", "수", "목", "금", "토"]
        for day in days {
            let dayLabel = UILabel().then {
                $0.textAlignment = .center
                $0.text = day
                $0.font = .systemFont(ofSize: 16, weight: .semibold)
                $0.textColor = .labelNormal
            }
            let labelContainer = UIView().then {
                $0.addSubview(dayLabel)
                dayLabel.snp.makeConstraints { make in
                    make.center.equalToSuperview()
                    make.width.height.equalTo(50) // 날짜 셀 크기와 동일하게 설정
                }
            }
            dayOfWeekStackView.addArrangedSubview(labelContainer)
        }
        return dayOfWeekStackView
    }
    
    private func createRowStackView() -> UIStackView {
        return UIStackView().then {
            $0.axis = .horizontal
            $0.distribution = .fillEqually
            $0.spacing = 5
        }
    }

    private func styleDateButton(_ button: UIButton, day: Int) {
        button.setTitleColor(.labelNeutral, for: .normal)
        button.backgroundColor = .fillStrong
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lineSolidAlternative.cgColor
        button.alpha = 0.5 // 기본 불투명도
    }
    
    private func createButtonContainer(with button: UIButton) -> UIView {
        let container = UIView().then {
            $0.backgroundColor = .clear
            $0.layer.cornerRadius = 15
        }
        
        container.addSubview(button)
        button.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(50) // 정사각형 셀 크기 설정
        }
        
        return container
    }
    
    @objc func dateButtonTapped(_ sender: UIButton) {
        guard let dayString = sender.title(for: .normal), let day = Int(dayString) else { return }
        
        // 이전 선택된 버튼의 스타일 초기화
        if let selectedButton = self.selectedButton {
            selectedButton.layer.borderColor = UIColor.lineSolidAlternative.cgColor
            selectedButton.alpha = 0.5 // 이전 선택된 버튼의 불투명도 초기화
        }
        
        // 현재 선택된 버튼 스타일 변경
        sender.layer.borderColor = UIColor.lineSolidNormal.cgColor
        sender.alpha = 1.0 // 선택된 버튼의 불투명도
        
        self.selectedButton = sender
        
        var components = Calendar.current.dateComponents([.year, .month], from: self.currentMonth)
        components.day = day
        if let selectedDate = Calendar.current.date(from: components) {
            self.selectedDate = selectedDate
            self.updateSelectedDateLabel()
            self.onDateSelected?(selectedDate)
        }
    }
}
