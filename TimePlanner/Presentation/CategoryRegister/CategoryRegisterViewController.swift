//
//  CategoryRegisterViewController.swift
//  TimePlanner
//
//  Created by Coby on 10/7/24.
//

import UIKit
import SnapKit
import Then

final class CategoryRegisterViewController: UIViewController, BaseViewControllerType, Navigationable {
    
    // MARK: - UI Components
    
    private let scrollView = UIScrollView().then {
        $0.isScrollEnabled = true
        $0.showsVerticalScrollIndicator = false
    }
    
    private let contentView = UIView()
    
    private let titleLabel = UILabel().then {
        $0.text = "뭉치 이름"
        $0.font = .font(size: 18, weight: .medium)
        $0.textColor = UIColor.labelNormal
    }
    
    private let nameTextField = UITextField().then {
        $0.placeholder = "뭉치 이름을 입력하세요"
        $0.borderStyle = .roundedRect
        $0.font = .font(size: 16, weight: .regular)
        $0.clearButtonMode = .whileEditing
    }
    
    private let colorTitleLabel = UILabel().then {
        $0.text = "뭉치 색상"
        $0.font = .font(size: 18, weight: .medium)
        $0.textColor = UIColor.labelNormal
    }
    
    private let colorSelectionStackView = UIStackView().then {
        $0.axis = .horizontal // 가로 방향으로 설정
        $0.spacing = 12
        $0.distribution = .fillEqually // 균등 분배
    }
    
    private lazy var completeButton = CompleteButton().then {
        let action = UIAction { [weak self] _ in
            guard let self = self else { return }
            self.viewModel.registerCategory(
                name: self.nameTextField.text ?? "",
                color: self.selectedColor
            )
        }
        $0.addAction(action, for: .touchUpInside)
    }
    
    private var selectedColor: CategoryColor = CategoryColor.red
    
    // MARK: - Properties
    
    private let viewModel: CategoryRegisterViewModel
    
    private var cellHeight: CGFloat {
        let totalSpacing = CGFloat(12 * (CategoryColor.allCases.count - 1))
        let totalWidth = SizeLiteral.fullWidth - totalSpacing
        let cellCount = CGFloat(CategoryColor.allCases.count) // cellCount도 CGFloat으로 변환
        return totalWidth / cellCount
    }
    
    // MARK: - Life Cycle
    
    init(viewModel: CategoryRegisterViewModel) {
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
        self.setupColorSelection()
        
        self.nameTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configureNavigationBar()
        
        // 화면이 다시 나타날 때 탭 바를 표시
        self.tabBarController?.tabBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // 화면이 사라질 때 탭 바를 숨김
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
            self.nameTextField,
            self.colorTitleLabel,
            self.colorSelectionStackView
        )
        
        self.titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(SizeLiteral.verticalPadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.horizantalPadding)
        }
        
        self.nameTextField.snp.makeConstraints {
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.horizantalPadding)
            $0.height.equalTo(50)
        }
        
        self.colorTitleLabel.snp.makeConstraints {
            $0.top.equalTo(self.nameTextField.snp.bottom).offset(30)
            $0.leading.equalToSuperview().inset(SizeLiteral.horizantalPadding)
        }
        
        self.colorSelectionStackView.snp.makeConstraints {
            $0.top.equalTo(self.colorTitleLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.horizantalPadding)
            $0.height.equalTo(self.cellHeight)
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
        self.title = "뭉치 등록"
    }
    
    private func setupColorSelection() {
        for categoryColor in CategoryColor.allCases {
            let colorButton = UIButton().then {
                $0.layer.cornerRadius = 16
                $0.clipsToBounds = true
                $0.backgroundColor = categoryColor.color
                $0.addTarget(self, action: #selector(self.colorButtonTapped(_:)), for: .touchUpInside)
                
                // 초기 상태: 테두리 없음
                $0.layer.borderWidth = 0
            }
            
            colorButton.tag = categoryColor.rawValue.hashValue
            
            self.colorSelectionStackView.addArrangedSubview(colorButton)
        }
    }
    
    @objc private func colorButtonTapped(_ sender: UIButton) {
        // 버튼의 태그를 이용하여 선택된 `CategoryColor` 찾기
        if let selectedCategoryColor = CategoryColor(tag: sender.tag) {
            // 이전 선택된 버튼의 테두리 제거
            if let previousButton = self.colorSelectionStackView.subviews.first(where: {
                ($0 as? UIButton)?.tag == self.selectedColor.rawValue.hashValue
            }) as? UIButton {
                previousButton.layer.borderWidth = 0 // 이전 선택에서 테두리 제거
            }
            
            // 현재 선택된 버튼에 테두리 추가
            sender.layer.borderWidth = 2
            sender.layer.borderColor = UIColor.labelNormal.cgColor
            
            // 선택된 색상 업데이트
            self.selectedColor = selectedCategoryColor
        }
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        if let text = textField.text, !text.isEmpty {
            self.completeButton.isEnabled = true
        } else {
            self.completeButton.isEnabled = false
        }
    }
}
