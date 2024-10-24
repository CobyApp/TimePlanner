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
        
        self.loadCategories(date: Date())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configureNavigationBar()
        
        // 날짜가 선택될 때마다 loadCategories 호출
        self.calendarView.onDateSelected = { [weak self] selectedDate in
            self?.loadCategories(date: selectedDate)
        }
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
            $0.top.equalTo(self.calendarView.snp.bottom).offset(SizeLiteral.verticalPadding * 2)
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
}

extension MainViewController {

    private func loadCategories(date: Date) {
        self.viewModel.getCategoriesWithFilteredToDoItems(date: date) { [weak self] categories in
            self?.todoListView.categories = categories
        }
    }
}
