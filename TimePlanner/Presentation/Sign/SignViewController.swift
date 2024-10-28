//
//  SignViewController.swift
//  TimePlanner
//
//  Created by Coby on 10/14/24.
//

import UIKit

import SnapKit
import Then

final class SignViewController: UIViewController, BaseViewControllerType, Navigationable, Keyboardable {
    
    // MARK: - UI Components
    
    private let scrollView = UIScrollView().then {
        $0.isScrollEnabled = true
        $0.showsVerticalScrollIndicator = false
    }
    
    private let contentView = UIView()
    
    private let emailLabel = UILabel().then {
        $0.text = "이메일"
        $0.font = .font(size: 18, weight: .medium)
        $0.textColor = .label
    }
    
    private let emailTextField = UITextField().then {
        $0.placeholder = "이메일을 입력하세요"
        $0.font = .font(size: 16, weight: .regular)
        $0.borderStyle = .roundedRect
        $0.clearButtonMode = .whileEditing
        $0.autocapitalizationType = .none // 첫 글자 대문자 방지
        $0.autocorrectionType = .no // 자동완성 기능 제거
    }
    
    private let passwordLabel = UILabel().then {
        $0.text = "비밀번호"
        $0.font = .font(size: 18, weight: .medium)
        $0.textColor = .label
    }
    
    private let passwordTextField = UITextField().then {
        $0.placeholder = "최소 8자, 대문자, 소문자, 숫자, 특수문자 포함"
        $0.font = .font(size: 16, weight: .regular)
        $0.borderStyle = .roundedRect
        $0.clearButtonMode = .whileEditing
        $0.autocapitalizationType = .none // 첫 글자 대문자 방지
        $0.autocorrectionType = .no // 자동완성 기능 제거
        $0.isSecureTextEntry = true // 비밀번호 입력 보안 설정
    }
    
    private let passwordConfirmLabel = UILabel().then {
        $0.text = "비밀번호 확인"
        $0.font = .font(size: 18, weight: .medium)
        $0.textColor = .label
    }
    
    private let passwordConfirmTextField = UITextField().then {
        $0.placeholder = "비밀번호를 다시 입력하세요"
        $0.font = .font(size: 16, weight: .regular)
        $0.borderStyle = .roundedRect
        $0.clearButtonMode = .whileEditing
        $0.autocapitalizationType = .none // 첫 글자 대문자 방지
        $0.autocorrectionType = .no // 자동완성 기능 제거
        $0.isSecureTextEntry = true // 비밀번호 입력 보안 설정
    }
    
    private lazy var signUpButton = CompleteButton().then {
        $0.label.text = "회원가입"
        let action = UIAction { [weak self] _ in
            guard let self = self else { return }
            self.viewModel.signUser(
                email: self.emailTextField.text ?? "",
                password: self.passwordTextField.text ?? ""
            )
        }
        $0.addAction(action, for: .touchUpInside)
    }
    
    // MARK: - Properties
    
    private let viewModel: SignViewModel
    
    // MARK: - Life Cycle
    
    init(viewModel: SignViewModel) {
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
        
        self.emailTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        self.passwordTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        self.passwordConfirmTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configureNavigationBar()
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
            self.emailLabel,
            self.emailTextField,
            self.passwordLabel,
            self.passwordTextField,
            self.passwordConfirmLabel,
            self.passwordConfirmTextField
        )
        
        self.emailLabel.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).inset(20)
            $0.leading.equalToSuperview().inset(SizeLiteral.horizantalPadding)
        }
        
        self.emailTextField.snp.makeConstraints {
            $0.top.equalTo(self.emailLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.horizantalPadding)
            $0.height.equalTo(50)
        }
        
        self.passwordLabel.snp.makeConstraints {
            $0.top.equalTo(self.emailTextField.snp.bottom).offset(40)
            $0.leading.equalToSuperview().inset(SizeLiteral.horizantalPadding)
        }
        
        self.passwordTextField.snp.makeConstraints {
            $0.top.equalTo(self.passwordLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.horizantalPadding)
            $0.height.equalTo(50)
        }
        
        self.passwordConfirmLabel.snp.makeConstraints {
            $0.top.equalTo(self.passwordTextField.snp.bottom).offset(40)
            $0.leading.equalToSuperview().inset(SizeLiteral.horizantalPadding)
        }
        
        self.passwordConfirmTextField.snp.makeConstraints {
            $0.top.equalTo(self.passwordConfirmLabel.snp.bottom).offset(10)
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
        self.title = "회원가입"
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        // 각 입력 필드의 텍스트를 가져오고 비어 있지 않은지 확인
        let emailIsValid = self.emailTextField.text?.isEmpty == false
        let passwordIsValid = self.passwordTextField.text?.isEmpty == false
        let passwordConfirmIsValid = self.passwordConfirmTextField.text?.isEmpty == false
        
        // 비밀번호와 비밀번호 확인이 일치하는지, 비밀번호가 유효한지 확인
        let passwordsMatch = self.passwordTextField.text == self.passwordConfirmTextField.text
        let passwordMeetsRequirements = self.validatePassword(self.passwordTextField.text ?? "")
        
        // 모든 조건이 충족되면 버튼 활성화
        self.signUpButton.isEnabled = emailIsValid && passwordIsValid && passwordConfirmIsValid && passwordsMatch && passwordMeetsRequirements
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
