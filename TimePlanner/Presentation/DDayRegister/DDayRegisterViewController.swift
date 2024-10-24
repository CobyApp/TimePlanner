//
//  DDayRegisterViewController.swift
//  TimePlanner
//
//  Created by Coby on 10/7/24.
//

import UIKit

import SnapKit
import Then

final class DDayRegisterViewController: UIViewController, BaseViewControllerType, Navigationable, Keyboardable {
    
    // MARK: - UI Components
    
    private let scrollView = UIScrollView().then {
        $0.isScrollEnabled = true
        $0.showsVerticalScrollIndicator = false
    }
    
    private let contentView = UIView()
    
    private let titleLabel = UILabel().then {
        $0.text = "내용"
        $0.font = .systemFont(ofSize: 18, weight: .medium)
        $0.textColor = .label
    }
    
    private let titleTextField = UITextField().then {
        $0.placeholder = "내용을 입력해주세요."
        $0.font = .systemFont(ofSize: 16)
        $0.borderStyle = .roundedRect
        $0.clearButtonMode = .whileEditing
    }
    
    private let dateLabel = UILabel().then {
        $0.text = "날짜"
        $0.font = .systemFont(ofSize: 18, weight: .medium)
        $0.textColor = .label
    }
    
    private let datePicker = UIDatePicker().then {
        $0.datePickerMode = .date
        $0.preferredDatePickerStyle = .wheels
        $0.locale = Locale(identifier: "ko_KR") // 한국어로 설정
        $0.timeZone = .current
    }
    
    private lazy var completeButton = CompleteButton().then {
        let action = UIAction { [weak self] _ in
            guard let self = self else { return }
            if let _ = self.viewModel.dDay {
                self.viewModel.updateDDay(
                    name: self.titleTextField.text ?? "",
                    dDate: self.datePicker.date
                )
            } else {
                self.viewModel.registerDDay(
                    name: self.titleTextField.text ?? "",
                    dDate: self.datePicker.date
                )
            }
        }
        $0.addAction(action, for: .touchUpInside)
        $0.label.text = "저장"
    }
    
    // MARK: - Properties
    
    private let viewModel: DDayRegisterViewModel
    
    // MARK: - Life Cycle
    
    init(viewModel: DDayRegisterViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        if let dDay = self.viewModel.dDay {
            self.titleTextField.text = dDay.name
            self.datePicker.date = dDay.dDate
            self.completeButton.isEnabled = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.baseViewDidLoad()
        self.setupNavigation()
        self.setupLayout()
        self.configureUI()
        self.setupKeyboardGesture()
        
        self.titleTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configureNavigationBar()
        self.tabBarController?.tabBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - Functions
    
    func setupLayout() {
        self.view.addSubviews(
            self.scrollView,
            self.completeButton
        )
        
        self.scrollView.snp.makeConstraints {
            $0.top.edges.equalToSuperview()
        }
        
        self.scrollView.addSubviews(
            self.contentView
        )
        
        self.contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        self.contentView.addSubviews(
            self.titleLabel,
            self.titleTextField,
            self.dateLabel,
            self.datePicker
        )
        
        self.titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).inset(20)
            $0.leading.equalToSuperview().inset(20)
        }
        
        self.titleTextField.snp.makeConstraints {
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }
        
        self.dateLabel.snp.makeConstraints {
            $0.top.equalTo(self.titleTextField.snp.bottom).offset(40)
            $0.leading.equalToSuperview().inset(20)
        }
        
        self.datePicker.snp.makeConstraints {
            $0.top.equalTo(self.dateLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview()
        }
        
        self.completeButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.horizantalPadding)
            $0.bottom.equalTo(self.view.keyboardLayoutGuide.snp.top).offset(-10)
            $0.height.equalTo(50)
        }
    }
    
    func configureUI() {
        self.view.backgroundColor = .backgroundNormalNormal
    }
    
    func configureNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.title = "디데이"
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        if let text = textField.text, !text.isEmpty {
            self.completeButton.isEnabled = true
        } else {
            self.completeButton.isEnabled = false
        }
    }
}
