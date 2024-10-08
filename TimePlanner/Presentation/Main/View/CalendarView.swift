import UIKit
import SnapKit
import Then

class CalendarView: UIView {
    
    override var intrinsicContentSize: CGSize {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: self.currentMonth)
        
        // 해당 월의 첫 날과 마지막 날 계산
        guard let firstDayOfMonth = calendar.date(from: components),
              let range = calendar.range(of: .day, in: .month, for: firstDayOfMonth) else {
            return CGSize(width: UIView.noIntrinsicMetric, height: 0)
        }
        
        let numberOfDays = range.count
        let firstWeekday = calendar.component(.weekday, from: firstDayOfMonth) - 1 // 일요일이 1이므로 1을 빼서 맞춤

        // 필요한 줄 수 계산
        let totalRows = (numberOfDays + firstWeekday + 6) / 7 // 총 날짜 + 첫 주의 빈 칸 고려
        let numberOfRows = min(totalRows, 6) // 최대 6줄로 제한
        let rowHeight: CGFloat = 40 // 각 줄의 높이 (날짜 버튼)
        let totalHeight = CGFloat(numberOfRows) * rowHeight + 80 // 날짜와 요일 포함
        return CGSize(width: UIView.noIntrinsicMetric, height: totalHeight)
    }
    
    // MARK: - UI Components
    
    private let selectedDateLabel = UILabel().then {
        $0.textAlignment = .left
        $0.font = UIFont.font(size: 18, weight: .bold)
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
    
    private var currentMonth: Date = Date() // 현재 달
    private var selectedDate: Date = Date() // 선택된 날짜
    private var dateGridView = UIView() // 날짜 버튼을 담는 그리드 뷰
    private var selectedButton: UIButton? // 선택된 날짜를 저장할 버튼
    
    var onDateSelected: ((Date) -> Void)? // 날짜 선택 콜백
    
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
    
    // MARK: - Functions
    
    // 상단 뷰 설정
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
    
    // 선택된 날짜 레이블 업데이트
    private func updateSelectedDateLabel() {
        let formatter = DateFormatter().then {
            $0.dateFormat = "yyyy년 MM월 dd일"
        }
        self.selectedDateLabel.text = formatter.string(from: self.selectedDate)
    }
    
    // 이전 달로 이동
    private func goToPreviousMonth() {
        self.changeMonth(by: -1)
    }
    
    // 다음 달로 이동
    private func goToNextMonth() {
        self.changeMonth(by: 1)
    }
    
    // 달을 변경할 때 처리
    func changeMonth(by value: Int) {
        // 현재 월에서 value만큼 더하거나 뺌
        let newMonth = Calendar.current.date(byAdding: .month, value: value, to: self.currentMonth)!
        
        // 변경된 월의 마지막 날짜를 확인
        let lastDayOfNewMonth = Calendar.current.range(of: .day, in: .month, for: newMonth)!.upperBound - 1
        
        // 현재 선택된 날짜의 일(day)과 새로운 월의 마지막 일 비교하여 날짜 유지
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

        // intrinsicContentSize 업데이트
        self.invalidateIntrinsicContentSize() // 높이 업데이트
    }
    
    // 요일과 날짜 버튼들 배치
    private func setupCalendarView() {
        let dayOfWeekStackView = UIStackView().then {
            $0.axis = .horizontal
            $0.distribution = .fillEqually
        }
        
        let days = ["일", "월", "화", "수", "목", "금", "토"]
        
        for day in days {
            let dayLabel = UILabel().then {
                $0.textAlignment = .center
                $0.text = day
                $0.font = .font(size: 16, weight: .semibold)
                $0.textColor = .labelNormal
            }
            dayOfWeekStackView.addArrangedSubview(dayLabel)
        }
        
        self.addSubview(dayOfWeekStackView)
        dayOfWeekStackView.snp.makeConstraints {
            $0.top.equalTo(self.selectedDateLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(30)
        }
        
        // 날짜 버튼들을 담을 뷰
        self.addSubview(self.dateGridView)
        self.dateGridView.snp.makeConstraints {
            $0.top.equalTo(dayOfWeekStackView.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    // 달력 그리기
    private func renderCalendar(for date: Date) {
        // 기존 날짜 버튼들 제거
        self.dateGridView.subviews.forEach { $0.removeFromSuperview() }
        self.selectedButton = nil
        
        let calendar = Calendar.current
        let range = calendar.range(of: .day, in: .month, for: date)!
        let components = calendar.dateComponents([.year, .month], from: date)
        
        let firstDayOfMonth = calendar.date(from: components)!
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
            
            var hasDaysInRow = false
            
            for col in 0..<7 {
                let dateButton = UIButton().then {
                    if isFirstWeek && col < firstWeekday {
                        $0.setTitle("", for: .normal) // 빈 칸
                    } else if currentDay <= range.count {
                        $0.setTitle("\(currentDay)", for: .normal)
                        $0.setTitleColor(.labelNormal, for: .normal)
                        $0.setTitleColor(.labelStrong, for: .selected)
                        $0.titleLabel?.font = .font(size: 16, weight: .regular)
                        $0.addTarget(self, action: #selector(self.dateButtonTapped(_:)), for: .touchUpInside)
                        
                        // 선택된 날짜 강조
                        let dayComponent = calendar.component(.day, from: self.selectedDate)
                        if currentDay == dayComponent {
                            self.selectedButton = $0
                            $0.backgroundColor = .yellow
                        }
                        hasDaysInRow = true
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
            
            // 해당 줄에 날짜가 없으면 줄을 추가하지 않음
            if hasDaysInRow {
                self.dateGridView.addSubview(rowStackView)
                rowStackView.snp.makeConstraints {
                    $0.leading.trailing.equalToSuperview()
                    $0.top.equalToSuperview().offset(row * 40) // 각 줄이 40 포인트의 높이를 가짐
                    $0.height.equalTo(40)
                }
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
