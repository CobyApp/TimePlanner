//
//  CalendarView.swift
//  TimePlanner
//
//  Created by Coby on 9/22/24.
//

import UIKit
import SnapKit
import Then

class CalendarView: UIView {
    
    let selectedDateLabel = UILabel().then {
        $0.textAlignment = .left
        $0.font = UIFont.systemFont(ofSize: 18)
    }
    
    let prevMonthButton = UIButton().then {
        $0.setTitle("<", for: .normal)
        $0.setTitleColor(.black, for: .normal)
    }
    
    let nextMonthButton = UIButton().then {
        $0.setTitle(">", for: .normal)
        $0.setTitleColor(.black, for: .normal)
    }
    
    var currentMonth: Date = Date() // 현재 달
    var selectedDate: Date = Date() // 선택된 날짜
    var onDateSelected: ((Date) -> Void)? // 날짜 선택 콜백
    
    var dateGridView = UIView() // 날짜 버튼을 담는 그리드 뷰
    var selectedButton: UIButton? // 선택된 날짜를 저장할 버튼
    
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
    
    // 상단 뷰 설정
    func setupTopView() {
        // 이전 월 버튼
        self.prevMonthButton.addTarget(self, action: #selector(self.goToPreviousMonth), for: .touchUpInside)
        // 다음 월 버튼
        self.nextMonthButton.addTarget(self, action: #selector(self.goToNextMonth), for: .touchUpInside)
        
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
        
        topStackView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(50)
        }
    }
    
    // 선택된 날짜 레이블 업데이트
    func updateSelectedDateLabel() {
        let formatter = DateFormatter().then {
            $0.dateFormat = "yyyy년 MM월 dd일"
        }
        self.selectedDateLabel.text = formatter.string(from: self.selectedDate)
    }
    
    // 이전 달로 이동
    @objc func goToPreviousMonth() {
        self.changeMonth(by: -1)
    }
    
    // 다음 달로 이동
    @objc func goToNextMonth() {
        self.changeMonth(by: 1)
    }
    
    // 달을 변경할 때 처리
    func changeMonth(by value: Int) {
        // 현재 월에서 value만큼 더하거나 뺌
        var newMonth = Calendar.current.date(byAdding: .month, value: value, to: self.currentMonth)!
        
        // 변경된 월의 마지막 날짜를 확인
        let lastDayOfNewMonth = Calendar.current.range(of: .day, in: .month, for: newMonth)!.upperBound - 1
        
        // 현재 선택된 날짜의 일(day)와 새로운 월의 마지막 일 비교하여 날짜 유지
        var selectedComponents = Calendar.current.dateComponents([.year, .month, .day], from: self.selectedDate)
        selectedComponents.month = Calendar.current.component(.month, from: newMonth)
        selectedComponents.year = Calendar.current.component(.year, from: newMonth)
        selectedComponents.day = min(selectedComponents.day ?? 1, lastDayOfNewMonth)
        
        if let newSelectedDate = Calendar.current.date(from: selectedComponents) {
            self.selectedDate = newSelectedDate
        }
        
        self.currentMonth = newMonth
        self.updateSelectedDateLabel()
        self.renderCalendar(for: self.currentMonth)
    }
    
    // 요일과 날짜 버튼들 배치
    func setupCalendarView() {
        let dayOfWeekStackView = UIStackView().then {
            $0.axis = .horizontal
            $0.distribution = .fillEqually
        }
        
        let days = ["월", "화", "수", "목", "금", "토", "일"]
        
        for day in days {
            let dayLabel = UILabel().then {
                $0.textAlignment = .center
                $0.text = day
            }
            dayOfWeekStackView.addArrangedSubview(dayLabel)
        }
        
        self.addSubview(dayOfWeekStackView)
        dayOfWeekStackView.snp.makeConstraints { make in
            make.top.equalTo(self.selectedDateLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(40)
        }
        
        // 날짜 버튼들을 담을 뷰
        self.addSubview(self.dateGridView)
        self.dateGridView.snp.makeConstraints { make in
            make.top.equalTo(dayOfWeekStackView.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview()
        }
    }
    
    // 달력 그리기
    func renderCalendar(for date: Date) {
        // 기존 날짜 버튼들 제거
        self.dateGridView.subviews.forEach { $0.removeFromSuperview() }
        self.selectedButton = nil
        
        let calendar = Calendar.current
        let range = calendar.range(of: .day, in: .month, for: date)!
        let components = calendar.dateComponents([.year, .month], from: date)
        
        var firstDayOfMonth = calendar.date(from: components)!
        let firstWeekday = calendar.component(.weekday, from: firstDayOfMonth) - 1 // 일요일이 1이므로 1을 빼서 맞춤

        var currentDay = 1
        var isFirstWeek = true

        // 총 6줄의 주를 그리기
        for row in 0..<6 {
            let rowStackView = UIStackView().then {
                $0.axis = .horizontal
                $0.distribution = .fillEqually
                $0.spacing = 5
            }
            
            for col in 0..<7 {
                let dateButton = UIButton().then {
                    if isFirstWeek && col < firstWeekday {
                        $0.setTitle("", for: .normal) // 빈 칸
                    } else if currentDay <= range.count {
                        $0.setTitle("\(currentDay)", for: .normal)
                        $0.setTitleColor(.black, for: .normal)
                        $0.setTitleColor(.yellow, for: .selected)
                        $0.addTarget(self, action: #selector(self.dateButtonTapped(_:)), for: .touchUpInside)
                        
                        // 선택된 날짜 강조
                        let dayComponent = calendar.component(.day, from: self.selectedDate)
                        if currentDay == dayComponent {
                            self.selectedButton = $0
                            $0.backgroundColor = .yellow
                        }
                        
                        currentDay += 1
                    } else {
                        $0.setTitle("", for: .normal) // 빈 칸
                    }
                }
                
                // 동그라미 그리기
                let circleView = UIView().then {
                    $0.backgroundColor = .clear
                    $0.layer.cornerRadius = 15
                    $0.layer.borderWidth = 1
                    $0.layer.borderColor = UIColor.black.cgColor
                }
                
                let container = UIView()
                container.addSubview(circleView)
                container.addSubview(dateButton)
                
                circleView.snp.makeConstraints { make in
                    make.center.equalToSuperview()
                    make.width.height.equalTo(30) // 동그라미 크기
                }
                
                dateButton.snp.makeConstraints { make in
                    make.center.equalToSuperview()
                }
                
                rowStackView.addArrangedSubview(container)
            }
            
            self.dateGridView.addSubview(rowStackView)
            rowStackView.snp.makeConstraints { make in
                make.leading.trailing.equalToSuperview()
                make.top.equalToSuperview().offset(row * 40) // 각 줄이 40 포인트의 높이를 가짐
                make.height.equalTo(40)
            }
            
            isFirstWeek = false
        }
    }
    
    @objc func dateButtonTapped(_ sender: UIButton) {
        guard let dayString = sender.title(for: .normal), let day = Int(dayString) else { return }
        
        // 이전 선택된 버튼 색상 초기화
        self.selectedButton?.backgroundColor = .clear
        
        // 선택된 버튼을 노란색으로 강조
        sender.backgroundColor = .yellow
        self.selectedButton = sender
        
        // 선택한 날짜 갱신
        var components = Calendar.current.dateComponents([.year, .month], from: self.currentMonth)
        components.day = day
        if let selectedDate = Calendar.current.date(from: components) {
            self.selectedDate = selectedDate
            self.updateSelectedDateLabel()
            self.onDateSelected?(selectedDate)
        }
    }
}
