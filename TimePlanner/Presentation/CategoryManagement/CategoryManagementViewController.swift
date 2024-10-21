//
//  CategoryManagementViewController.swift
//  TimePlanner
//
//  Created by Coby on 10/5/24.
//

import UIKit

import SnapKit
import Then

final class CategoryManagementViewController: UIViewController, BaseViewControllerType, Navigationable {
    
    // MARK: - ui component
    
    private lazy var plusButton = PlusButton().then {
        let action = UIAction { [weak self] _ in
            self?.viewModel.presentCategoryRegister()
        }
        $0.addAction(action, for: .touchUpInside)
    }
    
    private lazy var categoryListView = CategoryListView().then {
        $0.editTapAction = { [weak self] category in
            self?.viewModel.presentCategoryRegister(category: category)
        }
        $0.deleteTapAction = { [weak self] category in
            self?.viewModel.deleteCategory(categoryId: category.id) {
                self?.loadCategories()
            }
        }
    }
    
    // MARK: - property
    
    private let viewModel: CategoryManagementViewModel
    
    // MARK: - life cycle
    
    init(viewModel: CategoryManagementViewModel) {
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
        self.loadCategories()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - func
    
    func setupLayout() {
        self.view.addSubviews(
            self.categoryListView
        )
        
        self.categoryListView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configureUI() {
        self.view.backgroundColor = .backgroundNormalNormal
    }
    
    func configureNavigationBar() {
        let rightOffsetButton = self.removeBarButtonItemOffset(with: self.plusButton, offsetX: -10)
        let rightButton = self.makeBarButtonItem(with: rightOffsetButton)
        
        self.navigationItem.rightBarButtonItem = rightButton
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.title = "뭉치 관리"
    }
}

extension CategoryManagementViewController {

    private func loadCategories() {
        self.viewModel.getCategories { [weak self] categories in
            self?.categoryListView.categories = categories
        }
    }
}
