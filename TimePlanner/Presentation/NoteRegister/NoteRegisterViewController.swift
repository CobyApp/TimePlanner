//
//  NoteRegisterViewController.swift
//  TimePlanner
//
//  Created by Coby on 10/7/24.
//

import UIKit

import SnapKit
import Then

final class NoteRegisterViewController: UIViewController, BaseViewControllerType, Navigationable {
    
    // MARK: - UI Componentsㅋ
    
    private let titleLabel = UILabel().then {
        $0.text = "노트 내용"
        $0.font = .font(size: 18, weight: .medium)
        $0.textColor = UIColor.labelNormal
    }
    
    private let noteTextView = UITextView().then {
        $0.font = .font(size: 16, weight: .regular)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.layer.cornerRadius = 10
        $0.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    private let completeButton = CompleteButton()
    
    // MARK: - Properties
    
    private let viewModel: NoteRegisterViewModel
    
    // MARK: - Life Cycle
    
    init(viewModel: NoteRegisterViewModel) {
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
            self.titleLabel,
            self.noteTextView,
            self.completeButton
        )
        
        self.titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).inset(SizeLiteral.verticalPadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.horizantalPadding)
        }
        
        self.noteTextView.snp.makeConstraints {
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.horizantalPadding)
            $0.bottom.equalTo(self.completeButton.snp.top).offset(-SizeLiteral.verticalPadding)
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
        self.title = "노트 작성"
    }
}
