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
        $0.createToDoItemTapAction = { [weak self] category in
            let item = ToDoItemModel(title: "", date: self?.selectedDate ?? Date())
            self?.viewModel.presentToDoItemRegister(categoryId: category.id, toDoItem: item)
        }
        $0.checkTapAction = { [weak self] category, item in
            self?.viewModel.updateToDoItemCheckedStatus(
                categoryId: category.id,
                itemId: item.id,
                isChecked: !item.isChecked
            ) {
                self?.loadCategories(date: self?.selectedDate ?? Date())
            }
        }
        $0.editTapAction = { [weak self] category, item in
            self?.viewModel.presentToDoItemRegister(categoryId: category.id, toDoItem: item)
        }
        $0.deleteTapAction = { [weak self] category, item in
            self?.confirmDeletion(categoryId: category.id, toDoItemId: item.id)
        }
    }
    
    private let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
    }
    
    // MARK: - property
    
    private let viewModel: MainViewModel
    
    private var selectedDate: Date?
    
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
        
        self.calendarView.onDateSelected = { [weak self] selectedDate in
            self?.selectedDate = selectedDate
            self?.loadCategories(date: selectedDate)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configureNavigationBar()
        
        self.loadCategories(date: self.selectedDate ?? Date())
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
    
    private func confirmDeletion(categoryId: String, toDoItemId: String) {
        let alertController = UIAlertController(title: "삭제 확인", message: "이 할일을 삭제하시겠습니까?", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "삭제", style: .destructive, handler: { [weak self] _ in
            self?.viewModel.deleteToDoItem(categoryId: categoryId, toDoItemId: toDoItemId) {
                self?.loadCategories(date: self?.selectedDate ?? Date())
            }
        }))
        
        self.present(alertController, animated: true, completion: nil)
    }
}

extension MainViewController {

    private func loadCategories(date: Date) {
        self.viewModel.getCategoriesWithFilteredToDoItems(date: date) { [weak self] categories in
            self?.todoListView.categories = categories
        }
    }
}
