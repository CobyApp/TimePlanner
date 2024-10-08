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
    
    private let titleLabel = UILabel().then {
        $0.text = "뭉치 이름"
        $0.font = .font(size: 18, weight: .semibold)
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
        $0.font = .font(size: 18, weight: .semibold)
        $0.textColor = UIColor.labelNormal
    }
    
    private let colorSelectionStackView = UIStackView().then {
        $0.axis = .horizontal // 가로 방향으로 설정
        $0.spacing = 10
        $0.distribution = .fillEqually // 균등 분배
    }
    
    private let colors: [UIColor] = [
        .red, .green, .blue, .yellow, .orange
    ]
    
    private var selectedColor: UIColor? // 기본 선택 색상 (선택된 색상은 nil로 시작)
    
    // MARK: - Properties
    
    private let viewModel: CategoryRegisterViewModel
    
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configureNavigationBar()
    }
    
    // MARK: - Functions
    
    func setupLayout() {
        // 제목 레이블 추가
        self.view.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(SizeLiteral.verticalPadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.horizantalPadding)
        }
        
        // 텍스트 필드 추가
        self.view.addSubview(self.nameTextField)
        self.nameTextField.snp.makeConstraints {
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.horizantalPadding)
            $0.height.equalTo(50)
        }
        
        // 색상 제목 레이블 추가
        self.view.addSubview(self.colorTitleLabel)
        self.colorTitleLabel.snp.makeConstraints {
            $0.top.equalTo(self.nameTextField.snp.bottom).offset(30)
            $0.leading.equalToSuperview().inset(SizeLiteral.horizantalPadding)
        }
        
        // 색상 선택 스택 뷰 추가
        self.view.addSubview(self.colorSelectionStackView)
        self.colorSelectionStackView.snp.makeConstraints {
            $0.top.equalTo(self.colorTitleLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.horizantalPadding)
            $0.height.equalTo(50) // 스택 뷰 높이 설정
        }
    }
    
    func configureUI() {
        self.view.backgroundColor = .backgroundNormalNormal
    }
    
    func configureNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.title = "뭉치 등록"
    }
    
    // 색상 선택 버튼 생성
    private func setupColorSelection() {
        for color in colors {
            let colorButton = UIButton().then {
                $0.layer.cornerRadius = 25 // 동그라미 모양
                $0.clipsToBounds = true // 테두리 자르기
                $0.backgroundColor = color
                $0.addTarget(self, action: #selector(self.colorButtonTapped(_:)), for: .touchUpInside)
                
                // 초기 상태: 테두리 없음
                $0.layer.borderWidth = 0
            }
            self.colorSelectionStackView.addArrangedSubview(colorButton)
            colorButton.snp.makeConstraints {
                $0.width.height.equalTo(50) // 버튼 크기 설정
            }
        }
    }
    
    @objc private func colorButtonTapped(_ sender: UIButton) {
        // 이전 선택된 버튼의 테두리 색상 초기화
        if let previousButton = self.colorSelectionStackView.subviews.first(where: { ($0 as? UIButton)?.backgroundColor == self.selectedColor }) as? UIButton {
            previousButton.layer.borderWidth = 0 // 테두리 없음
        }
        
        // 선택된 버튼의 색상을 강조
        sender.layer.borderWidth = 2 // 테두리 두께 설정
        sender.layer.borderColor = UIColor.black.cgColor // 테두리 색상 설정
        self.selectedColor = sender.backgroundColor // 선택된 색상 업데이트
        
        // 선택된 색상에 따라 뭉치 색상 업데이트 로직 추가 가능
    }
}
