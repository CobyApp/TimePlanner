//
//  LoginViewController.swift
//  TimePlanner
//
//  Created by Coby on 10/14/24.
//

import UIKit

import SnapKit
import Then

final class LoginViewController: UIViewController, BaseViewControllerType {
    
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
        $0.placeholder = "비밀번호를 입력하세요"
        $0.font = .font(size: 16, weight: .regular)
        $0.borderStyle = .roundedRect
        $0.clearButtonMode = .whileEditing
        $0.autocapitalizationType = .none // 첫 글자 대문자 방지
        $0.autocorrectionType = .no // 자동완성 기능 제거
        $0.isSecureTextEntry = true // 비밀번호 입력 보안 설정
    }
    
    private lazy var signUpButton = UIButton().then {
        let title = "회원가입 하기"
        let attributedString = NSAttributedString(
            string: title,
            attributes: [
                .font: UIFont.font(size: 14, weight: .regular),
                .foregroundColor: UIColor.labelAlternative,
                .underlineStyle: NSUnderlineStyle.single.rawValue
            ]
        )
        $0.setAttributedTitle(attributedString, for: .normal)
        let action = UIAction { [weak self] _ in
            self?.viewModel.presentSign()
        }
        $0.addAction(action, for: .touchUpInside)
    }
    
    private lazy var loginButton = CompleteButton().then {
        $0.label.text = "로그인"
        let action = UIAction { [weak self] _ in
            guard let self = self else { return }
            self.viewModel.loginUser(
                email: self.emailTextField.text ?? "",
                password: self.passwordTextField.text ?? ""
            )
        }
        $0.addAction(action, for: .touchUpInside)
    }
    
    // MARK: - Properties
    
    private let viewModel: LoginViewModel
    
    // MARK: - Life Cycle
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.baseViewDidLoad()
        self.setupLayout()
        self.configureUI()
        
        self.emailTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        self.passwordTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
    }
    
    // MARK: - Functions
    
    func setupLayout() {
        self.view.addSubviews(
            self.scrollView,
            self.loginButton
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
            self.signUpButton
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
        
        self.signUpButton.snp.makeConstraints {
            $0.top.equalTo(self.passwordTextField.snp.bottom).offset(20)
            $0.centerX.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview()
        }
        
        self.loginButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.horizantalPadding)
            $0.bottom.equalTo(self.view.keyboardLayoutGuide.snp.top).offset(-10)
            $0.height.equalTo(50)
        }
    }
    
    func configureUI() {
        self.view.backgroundColor = .backgroundNormalNormal
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        if let email = emailTextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty {
            self.loginButton.isEnabled = true
        } else {
            self.loginButton.isEnabled = false
        }
    }
}
