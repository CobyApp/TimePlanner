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
    
    private let plusButton = PlusButton()
    
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
    }
    
    // MARK: - func
    
    func setupLayout() {
    }
    
    func configureUI() {
        self.view.backgroundColor = .backgroundNormalNormal
    }
    
    func configureNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        let plusButton = makeBarButtonItem(with: self.plusButton)
        self.navigationItem.rightBarButtonItem = plusButton
        self.title = "뭉치 관리"
    }
}
