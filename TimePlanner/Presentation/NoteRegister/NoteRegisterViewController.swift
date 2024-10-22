//
//  NoteRegisterViewController.swift
//  TimePlanner
//
//  Created by Coby on 10/7/24.
//

import UIKit

import SnapKit
import Then

final class NoteRegisterViewController: UIViewController, BaseViewControllerType, Navigationable, Keyboardable {
    
    // MARK: - UI Componentsㅋ
    
    private let noteTextView = UITextView().then {
        $0.font = .font(size: 16, weight: .regular)
        $0.layer.borderWidth = 0 // 경계선 제거
        $0.layer.borderColor = UIColor.clear.cgColor // 경계선 색상 제거
        $0.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        $0.backgroundColor = .clear // 배경색을 투명하게 설정
    }
    
    private let placeholderLabel = UILabel().then {
        $0.text = "노트 내용을 입력해주세요."
        $0.font = .font(size: 16, weight: .regular)
        $0.textColor = .labelAssistive
        $0.isHidden = false // 기본적으로 표시
    }
    
    private lazy var completeButton = CompleteButton().then {
        let action = UIAction { [weak self] _ in
            guard let self = self else { return }
            if let _ = self.viewModel.note {
                self.viewModel.updateNote(
                    content: self.noteTextView.text ?? ""
                )
            } else {
                self.viewModel.registerNote(
                    content: self.noteTextView.text ?? ""
                )
            }
        }
        $0.addAction(action, for: .touchUpInside)
        $0.label.text = "저장"
    }
    
    // MARK: - Properties
    
    private let viewModel: NoteRegisterViewModel
    
    // MARK: - Life Cycle
    
    init(viewModel: NoteRegisterViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        if let note = self.viewModel.note {
            self.noteTextView.text = note.content
            self.completeButton.isHidden = true
            self.placeholderLabel.isHidden = true
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
        
        self.noteTextView.delegate = self
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
            self.noteTextView,
            self.placeholderLabel,
            self.completeButton
        )
        
        self.noteTextView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(SizeLiteral.verticalPadding)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.horizantalPadding)
            $0.bottom.equalTo(self.completeButton.snp.top).offset(-SizeLiteral.verticalPadding)
        }
        
        self.placeholderLabel.snp.makeConstraints {
            $0.top.equalTo(self.noteTextView)
            $0.leading.equalTo(self.noteTextView).offset(4)
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
        self.title = "노트"
    }
}

extension NoteRegisterViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let hasText = !textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        self.completeButton.isEnabled = hasText
        self.placeholderLabel.isHidden = !textView.text.isEmpty
        self.completeButton.isHidden = false
    }
}
