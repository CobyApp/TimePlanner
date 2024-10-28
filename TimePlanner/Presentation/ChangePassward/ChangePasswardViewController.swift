//
//  ChangePasswordViewController.swift
//  TimePlanner
//
//  Created by Coby on 10/25/24.
//

import UIKit

import SnapKit
import Then

final class ChangePasswordViewController: UIViewController, BaseViewControllerType, Navigationable, Keyboardable {
    
    // MARK: - UI Components
    
    private let scrollView = UIScrollView().then {
        $0.isScrollEnabled = true
        $0.showsVerticalScrollIndicator = false
    }
    
    private let contentView = UIView()
    
    private let passwordLabel = UILabel().then {
        $0.text = "기존 비밀번호"
        $0.font = .font(size: 18, weight: .medium)
        $0.textColor = .label
    }
    
    private let passwordTextField = UITextField().then {
        $0.placeholder = "기존 비밀번호를 입력하세요"
        $0.font = .font(size: 16, weight: .regular)
        $0.borderStyle = .roundedRect
        $0.clearButtonMode = .whileEditing
        $0.autocapitalizationType = .none // 첫 글자 대문자 방지
        $0.autocorrectionType = .no // 자동완성 기능 제거
        $0.isSecureTextEntry = true // 비밀번호 입력 보안 설정
    }
    
    private let newPasswordLabel = UILabel().then {
        $0.text = "비밀번호"
        $0.font = .font(size: 18, weight: .medium)
        $0.textColor = .label
    }
    
    private let newPasswordTextField = UITextField().then {
        $0.placeholder = "최소 8자, 대문자, 소문자, 숫자, 특수문자 포함"
        $0.font = .font(size: 16, weight: .regular)
        $0.borderStyle = .roundedRect
        $0.clearButtonMode = .whileEditing
        $0.autocapitalizationType = .none // 첫 글자 대문자 방지
        $0.autocorrectionType = .no // 자동완성 기능 제거
        $0.isSecureTextEntry = true // 비밀번호 입력 보안 설정
    }
    
    private let newPasswordConfirmLabel = UILabel().then {
        $0.text = "비밀번호 확인"
        $0.font = .font(size: 18, weight: .medium)
        $0.textColor = .label
    }
    
    private let newPasswordConfirmTextField = UITextField().then {
        $0.placeholder = "비밀번호를 다시 입력하세요"
        $0.font = .font(size: 16, weight: .regular)
        $0.borderStyle = .roundedRect
        $0.clearButtonMode = .whileEditing
        $0.autocapitalizationType = .none // 첫 글자 대문자 방지
        $0.autocorrectionType = .no // 자동완성 기능 제거
        $0.isSecureTextEntry = true // 비밀번호 입력 보안 설정
    }
    
    private lazy var signUpButton = CompleteButton().then {
        let action = UIAction { [weak self] _ in
            guard let self = self else { return }
            self.viewModel.changePassword(
                password: self.passwordTextField.text ?? "",
                newPassword: self.newPasswordTextField.text ?? ""
            )
        }
        $0.addAction(action, for: .touchUpInside)
    }
    
    // MARK: - Properties
    
    private let viewModel: ChangePasswordViewModel
    
    // MARK: - Life Cycle
    
    init(viewModel: ChangePasswordViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
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
        
        self.passwordTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        self.newPasswordTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        self.newPasswordConfirmTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
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
            self.signUpButton
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
            self.passwordLabel,
            self.passwordTextField,
            self.newPasswordLabel,
            self.newPasswordTextField,
            self.newPasswordConfirmLabel,
            self.newPasswordConfirmTextField
        )
        
        self.passwordLabel.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).inset(20)
            $0.leading.equalToSuperview().inset(SizeLiteral.horizantalPadding)
        }
        
        self.passwordTextField.snp.makeConstraints {
            $0.top.equalTo(self.passwordLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.horizantalPadding)
            $0.height.equalTo(50)
        }
        
        self.newPasswordLabel.snp.makeConstraints {
            $0.top.equalTo(self.passwordTextField.snp.bottom).offset(40)
            $0.leading.equalToSuperview().inset(SizeLiteral.horizantalPadding)
        }
        
        self.newPasswordTextField.snp.makeConstraints {
            $0.top.equalTo(self.newPasswordLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.horizantalPadding)
            $0.height.equalTo(50)
        }
        
        self.newPasswordConfirmLabel.snp.makeConstraints {
            $0.top.equalTo(self.newPasswordTextField.snp.bottom).offset(40)
            $0.leading.equalToSuperview().inset(SizeLiteral.horizantalPadding)
        }
        
        self.newPasswordConfirmTextField.snp.makeConstraints {
            $0.top.equalTo(self.newPasswordConfirmLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.horizantalPadding)
            $0.height.equalTo(50)
            $0.bottom.equalToSuperview()
        }
        
        self.signUpButton.snp.makeConstraints {
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
        self.title = "비밀번호 변경"
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        let password = self.passwordTextField.text ?? ""
        let newPassword = self.newPasswordTextField.text ?? ""
        let newPasswordConfirm = self.newPasswordConfirmTextField.text ?? ""
        
        // 비밀번호 제약 조건 체크
        let isPasswordValid = self.validatePassword(newPassword)
        
        if !password.isEmpty && isPasswordValid && newPassword == newPasswordConfirm {
            self.signUpButton.isEnabled = true
        } else {
            self.signUpButton.isEnabled = false
        }
    }
    
    private func validatePassword(_ password: String) -> Bool {
        // 최소 8자
        let passwordLengthValid = password.count >= 8
        
        // 대문자, 소문자, 숫자 및 특수 문자가 포함되어야 함
        let uppercaseLetterRegEx = ".*[A-Z]+.*"
        let lowercaseLetterRegEx = ".*[a-z]+.*"
        let numberRegEx = ".*[0-9]+.*"
        let specialCharacterRegEx = ".*[!@#$%^&*()_+~`\\-={}|\\[\\]:;\"'<>,.?/]+.*"
        
        let uppercasePredicate = NSPredicate(format: "SELF MATCHES %@", uppercaseLetterRegEx)
        let lowercasePredicate = NSPredicate(format: "SELF MATCHES %@", lowercaseLetterRegEx)
        let numberPredicate = NSPredicate(format: "SELF MATCHES %@", numberRegEx)
        let specialCharacterPredicate = NSPredicate(format: "SELF MATCHES %@", specialCharacterRegEx)
        
        let isUppercaseValid = uppercasePredicate.evaluate(with: password)
        let isLowercaseValid = lowercasePredicate.evaluate(with: password)
        let isNumberValid = numberPredicate.evaluate(with: password)
        let isSpecialCharacterValid = specialCharacterPredicate.evaluate(with: password)
        
        return passwordLengthValid && isUppercaseValid && isLowercaseValid && isNumberValid && isSpecialCharacterValid
    }
}
