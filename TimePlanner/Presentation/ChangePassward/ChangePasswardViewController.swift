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
    
    private let loadingIndicator = UIActivityIndicatorView(style: .large).then {
        $0.hidesWhenStopped = true
    }
    
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
        $0.autocapitalizationType = .none
        $0.autocorrectionType = .no
        $0.isSecureTextEntry = true
    }
    
    private let newPasswordLabel = UILabel().then {
        $0.text = "비밀번호"
        $0.font = .font(size: 18, weight: .medium)
        $0.textColor = .label
    }
    
    private let newPasswordTextField = UITextField().then {
        $0.placeholder = "새 비밀번호를 입력하세요"
        $0.font = .font(size: 16, weight: .regular)
        $0.borderStyle = .roundedRect
        $0.clearButtonMode = .whileEditing
        $0.autocapitalizationType = .none
        $0.autocorrectionType = .no
        $0.isSecureTextEntry = true
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
        $0.autocapitalizationType = .none
        $0.autocorrectionType = .no
        $0.isSecureTextEntry = true
    }
    
    private let newPasswordErrorLabel = UILabel().then {
        $0.font = .font(size: 14, weight: .regular)
        $0.textColor = .redNormal
        $0.text = "" // 기본값은 빈 문자열
        $0.textAlignment = .left
        $0.numberOfLines = 0
    }
    
    private let newPasswordConfirmErrorLabel = UILabel().then {
        $0.font = .font(size: 14, weight: .regular)
        $0.textColor = .redNormal
        $0.text = "" // 기본값은 빈 문자열
        $0.textAlignment = .left
    }
    
    private lazy var signUpButton = CompleteButton().then {
        let action = UIAction { [weak self] _ in
            guard let self = self else { return }
            self.startLoading()
            self.viewModel.changePassword(
                password: self.passwordTextField.text ?? "",
                newPassword: self.newPasswordTextField.text ?? "",
                completion: {
                    self.stopLoading()
                    self.showChangeSuccessAlert()
                },
                errorAlert: {
                    DispatchQueue.main.async { [weak self] in
                        self?.showChangeErrorAlert()
                    }
                }
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
            self.passwordLabel,
            self.passwordTextField,
            self.newPasswordLabel,
            self.newPasswordTextField,
            self.newPasswordErrorLabel,
            self.newPasswordConfirmLabel,
            self.newPasswordConfirmTextField,
            self.newPasswordConfirmErrorLabel
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
        
        self.newPasswordErrorLabel.snp.makeConstraints {
            $0.top.equalTo(self.newPasswordTextField.snp.bottom).offset(5)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.horizantalPadding)
        }
        
        self.newPasswordConfirmLabel.snp.makeConstraints {
            $0.top.equalTo(self.newPasswordErrorLabel.snp.bottom).offset(40)
            $0.leading.equalToSuperview().inset(SizeLiteral.horizantalPadding)
        }
        
        self.newPasswordConfirmTextField.snp.makeConstraints {
            $0.top.equalTo(self.newPasswordConfirmLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.horizantalPadding)
            $0.height.equalTo(50)
        }
        
        self.newPasswordConfirmErrorLabel.snp.makeConstraints {
            $0.top.equalTo(self.newPasswordConfirmTextField.snp.bottom).offset(5)
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
        self.title = "비밀번호 변경"
    }
    
    private func validatePassword(_ password: String) -> Bool {
        let passwordPattern = "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordPattern)
        return passwordPredicate.evaluate(with: password)
    }

    @objc private func textFieldDidChange(_ textField: UITextField) {
        let password = self.passwordTextField.text ?? ""
        let newPassword = self.newPasswordTextField.text ?? ""
        let newPasswordConfirm = self.newPasswordConfirmTextField.text ?? ""
        
        // 에러 메시지 초기화
        self.newPasswordErrorLabel.text = ""
        self.newPasswordConfirmErrorLabel.text = ""
        
        if !password.isEmpty {
            let isPasswordValid = self.validatePassword(newPassword)
            
            if !isPasswordValid {
                self.newPasswordErrorLabel.text = "비밀번호는 최소 8자, 대문자, 소문자, 숫자, 특수문자를 포함해야 합니다."
                self.signUpButton.isEnabled = false
            } else {
                if newPassword.isEmpty {
                    self.signUpButton.isEnabled = false
                } else {
                    self.signUpButton.isEnabled = newPasswordConfirm == newPassword
                    if newPasswordConfirm != newPassword {
                        self.newPasswordConfirmErrorLabel.text = "비밀번호가 일치하지 않습니다."
                    }
                }
            }
        } else {
            self.signUpButton.isEnabled = false
        }
    }
    
    private func showChangeErrorAlert() {
        let alert = UIAlertController(title: "비밀번호 변경 오류", message: "비밀번호를 확인해주세요.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func showChangeSuccessAlert() {
        let alert = UIAlertController(title: "비밀번호 변경 완료", message: "비밀번호가 변경되었습니다.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default) { [weak self] _ in
            DispatchQueue.main.async { [weak self] in
                self?.viewModel.dismiss()
            }
        })
        self.present(alert, animated: true, completion: nil)
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
