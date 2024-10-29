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
    
    private let loadingIndicator = UIActivityIndicatorView(style: .large).then {
        $0.hidesWhenStopped = true
    }
    
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
    
    private let passwordErrorLabel = UILabel().then {
        $0.font = .font(size: 14, weight: .regular)
        $0.textColor = .redNormal
        $0.text = "" // 기본값은 빈 문자열
        $0.textAlignment = .left
        $0.numberOfLines = 0
    }
    
    private let passwordConfirmErrorLabel = UILabel().then {
        $0.font = .font(size: 14, weight: .regular)
        $0.textColor = .redNormal
        $0.text = "" // 기본값은 빈 문자열
        $0.textAlignment = .left
    }
    
    private lazy var signUpButton = CompleteButton().then {
        $0.label.text = "회원가입"
        let action = UIAction { [weak self] _ in
            guard let self = self else { return }
            self.startLoading()
            self.viewModel.signUser(
                email: self.emailTextField.text ?? "",
                password: self.passwordTextField.text ?? ""
            ) {
                self.stopLoading()
            }
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
            self.signUpButton,
            self.loadingIndicator
        )
        
        self.scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.scrollView.addSubviews(
            self.contentView
        )
        
        self.contentView.snp.makeConstraints {
            $0.edges.width.equalToSuperview()
        }
        
        self.contentView.addSubviews(
            self.emailLabel,
            self.emailTextField,
            self.passwordLabel,
            self.passwordTextField,
            self.passwordErrorLabel,
            self.passwordConfirmLabel,
            self.passwordConfirmTextField,
            self.passwordConfirmErrorLabel
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
        
        self.passwordErrorLabel.snp.makeConstraints {
            $0.top.equalTo(self.passwordTextField.snp.bottom).offset(5)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.horizantalPadding)
        }
        
        self.passwordConfirmLabel.snp.makeConstraints {
            $0.top.equalTo(self.passwordErrorLabel.snp.bottom).offset(40)
            $0.leading.equalToSuperview().inset(SizeLiteral.horizantalPadding)
        }
        
        self.passwordConfirmTextField.snp.makeConstraints {
            $0.top.equalTo(self.passwordConfirmLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.horizantalPadding)
            $0.height.equalTo(50)
        }
        
        self.passwordConfirmErrorLabel.snp.makeConstraints {
            $0.top.equalTo(self.passwordConfirmTextField.snp.bottom).offset(5)
            $0.leading.trailing.bottom.equalToSuperview().inset(SizeLiteral.horizantalPadding)
        }
        
        self.signUpButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.horizantalPadding)
            $0.bottom.equalTo(self.view.keyboardLayoutGuide.snp.top).offset(-10)
            $0.height.equalTo(50)
        }
        
        self.loadingIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    func configureUI() {
        self.view.backgroundColor = .backgroundNormalNormal
    }
    
    func configureNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.title = "회원가입"
    }
    
    private func validatePassword(_ password: String) -> Bool {
        let passwordPattern = "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordPattern)
        return passwordPredicate.evaluate(with: password)
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        let email = self.emailTextField.text ?? ""
        let password = self.passwordTextField.text ?? ""
        let passwordConfirm = self.passwordConfirmTextField.text ?? ""
        
        // 이메일 유효성 체크
        let emailIsValid = !email.isEmpty // 이메일이 비어있지 않은지 확인
        
        // 비밀번호 제약 조건 체크
        let isPasswordValid = self.validatePassword(password)
        
        // 에러 메시지 초기화
        self.passwordErrorLabel.text = ""
        self.passwordConfirmErrorLabel.text = ""
        
        // 버튼 활성화 상태 결정
        if emailIsValid && isPasswordValid {
            if password.isEmpty {
                self.signUpButton.isEnabled = false
            } else {
                self.signUpButton.isEnabled = passwordConfirm == password
                if passwordConfirm != password {
                    self.passwordConfirmErrorLabel.text = "비밀번호가 일치하지 않습니다."
                }
            }
        } else {
            self.signUpButton.isEnabled = false
            if !emailIsValid {
                self.passwordErrorLabel.text = "이메일을 입력하세요."
            }
            if !isPasswordValid {
                self.passwordErrorLabel.text = "비밀번호는 최소 8자 이상이어야 하며, 대문자와 특수 문자를 포함해야 합니다."
            }
        }
    }
    
    private func startLoading() {
        DispatchQueue.main.async { [weak self] in
            self?.loadingIndicator.startAnimating()
            self?.signUpButton.isEnabled = false
        }
    }

    private func stopLoading() {
        DispatchQueue.main.async { [weak self] in
            self?.loadingIndicator.stopAnimating()
            self?.signUpButton.isEnabled = true
        }
    }
}
