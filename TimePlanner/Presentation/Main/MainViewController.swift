//
//  MainViewController.swift
//  TimePlanner
//
//  Created by Coby on 9/20/24.
//

import UIKit

import SnapKit
import Then

final class MainViewController: UIViewController, BaseViewControllerType, Navigationable {
    
    // MARK: - ui component

    private let titleLogo = UIImageView(image: UIImage.Icon.logo.resize(to: CGSize(width: 150, height: 28)))
        
    private lazy var moreButton = MoreButton().then {
        let action1 = UIAction(title: "뭉치 등록") { [weak self] _ in
            self?.viewModel.presentCategoryRegister()
        }
        let action2 = UIAction(title: "뭉치 관리") { [weak self] _ in
            self?.viewModel.presentCategoryManagement()
        }
        let menu = UIMenu(children: [action1, action2])
        $0.menu = menu
        $0.showsMenuAsPrimaryAction = true
    }
    
    private let calendarView = CalendarView()
    
    private lazy var todoListView = ToDoListView().then {
        $0.checkTapAction = { [weak self] in
            print("투두 체크 버튼 클릭")
        }
        $0.editTapAction = { [weak self] in
            print("투두 수정 버튼 클릭")
        }
        $0.deleteTapAction = { [weak self] in
            print("투두 삭제 버튼 클릭")
        }
    }
    
    private let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
    }
    
    // MARK: - property
    
    private let viewModel: MainViewModel
    
    // MARK: - life cycle
    
    init(viewModel: MainViewModel) {
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
        self.loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configureNavigationBar()
    }
    
    // MARK: - func
    
    func setupLayout() {
        self.view.addSubviews(
            self.scrollView
        )
        
        self.scrollView.addSubviews(
            self.calendarView,
            self.todoListView
        )
        
        self.scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.calendarView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.horizantalPadding)
            $0.width.equalTo(self.scrollView.snp.width).offset(-SizeLiteral.horizantalPadding * 2)
        }
        
        self.todoListView.snp.makeConstraints {
            $0.top.equalTo(self.calendarView.snp.bottom).offset(20)
            $0.leading.trailing.bottom.equalToSuperview().inset(SizeLiteral.horizantalPadding)
            $0.width.equalTo(self.scrollView.snp.width).offset(-SizeLiteral.horizantalPadding * 2)
        }
    }
    
    func configureUI() {
        self.view.backgroundColor = .backgroundNormalNormal
    }
    
    func configureNavigationBar() {
        let titleLogo = makeBarButtonItem(with: self.titleLogo)
        let rightOffsetButton = self.removeBarButtonItemOffset(with: self.moreButton, offsetX: -10)
        let rightButton = self.makeBarButtonItem(with: rightOffsetButton)
        
        self.navigationItem.leftBarButtonItem = titleLogo
        self.navigationItem.rightBarButtonItem = rightButton
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func loadData() {
        // 샘플 데이터 생성
        let sampleItems1 = [
            ToDoItem(title: "할 일 1", isChecked: false),
            ToDoItem(title: "할 일 2", isChecked: false),
            ToDoItem(title: "할 일 3", isChecked: false),
            ToDoItem(title: "할 일 4", isChecked: false)
        ]
        
        let sampleItems2 = [
            ToDoItem(title: "할 일 1", isChecked: false),
            ToDoItem(title: "할 일 2", isChecked: false)
        ]

        let categories = [
            ToDoCategory(title: "카테고리 1", items: sampleItems1),
            ToDoCategory(title: "카테고리 2", items: sampleItems2)
        ]

        // categories 속성에 데이터 할당
        todoListView.categories = categories
    }
}
