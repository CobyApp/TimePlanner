//
//  SettingViewController.swift
//  TimePlanner
//
//  Created by Coby on 10/7/24.
//

import UIKit

import SnapKit
import Then

final class SettingViewController: UIViewController, BaseViewControllerType, Navigationable {
    
    // MARK: - ui component
    
    private lazy var settingListView = SettingListView().then {
        $0.updateSettingItems(self.settingOptions)
    }
    
    // MARK: - property
    
    private let viewModel: SettingViewModel
    
    private lazy var settingOptions: [SettingOptionModel] = [
        SettingOptionModel(
            title: "알림설정",
            handler: {
                self.viewModel.presentNotificationSettings()
        }),
        SettingOptionModel(
            title: "비밀번호 변경",
            handler: {
                self.viewModel.presentChangePassword()
        }),
        SettingOptionModel(
            title: "로그아웃",
            handler: {
                self.confirmSignOut()
        }),
        SettingOptionModel(
            title: "회원탈퇴",
            handler: {
                self.confirmDeleteUser()
        })
    ]
    
    // MARK: - life cycle
    
    init(viewModel: SettingViewModel) {
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
    
    // MARK: - func
    
    func setupLayout() {
        self.view.addSubviews(
            self.settingListView
        )
        
        self.settingListView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configureUI() {
        self.view.backgroundColor = .backgroundNormalNormal
    }
    
    func configureNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.title = "설정"
    }
}

extension SettingViewController {
    
    private func confirmSignOut() {
        let alertController = UIAlertController(title: "로그아웃 확인", message: "이 앱에서 로그아웃하시겠습니까?", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "나가기", style: .destructive, handler: { [weak self] _ in
            self?.viewModel.signOut()
        }))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func confirmDeleteUser() {
        let alertController = UIAlertController(title: "탈퇴 확인", message: "이 앱에서 탈퇴하시겠습니까? 비밀번호를 입력하세요.", preferredStyle: .alert)
        
        alertController.addTextField { textField in
            textField.placeholder = "비밀번호"
            textField.isSecureTextEntry = true
            // NotificationCenter를 사용하여 입력 변화 감지
            NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object: textField, queue: .main) { [weak alertController] _ in
                guard let alertController = alertController,
                      let password = alertController.textFields?.first?.text,
                      let deleteAction = alertController.actions.first(where: { $0.title == "탈퇴" }) else {
                    return
                }
                // 비밀번호가 입력되어야 버튼 활성화
                deleteAction.isEnabled = !password.isEmpty
            }
        }
        
        // "탈퇴" 버튼 추가, 초기에는 비활성화 상태
        let deleteAction = UIAlertAction(title: "탈퇴", style: .destructive, handler: { [weak self] _ in
            guard let password = alertController.textFields?.first?.text else { return }
            self?.viewModel.deleteUser(password: password) {
                DispatchQueue.main.async { [weak self] in
                    self?.showDeleteErrorAlert()
                }
            }
        })
        deleteAction.isEnabled = false // 초기 비활성화
        alertController.addAction(deleteAction)
        
        alertController.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }

    // UITextField 입력 변화에 따른 버튼 활성화 상태 업데이트
    @objc private func textDidChangeInLoginAlert(_ sender: UITextField) {
        guard let alertController = presentedViewController as? UIAlertController,
              let password = alertController.textFields?.first?.text,
              let deleteAction = alertController.actions.first(where: { $0.title == "탈퇴" }) else {
            return
        }
        deleteAction.isEnabled = !password.isEmpty
    }
    
    private func showDeleteErrorAlert() {
        let alert = UIAlertController(title: "탈퇴 오류", message: "비밀번호를 확인해주세요.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
