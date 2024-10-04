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
        let action = UIAction { [weak self] _ in
            self?.viewModel.presentCategory()
        }
        $0.addAction(action, for: .touchUpInside)
    }
    
    private let calendarView = CalendarView()
    
    private let todoListView = ToDoListView()
    
    private lazy var scrollView = UIScrollView().then {
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
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        self.calendarView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(SizeLiteral.horizantalPadding)
            $0.width.equalTo(self.scrollView.snp.width).offset(-SizeLiteral.horizantalPadding * 2)
            $0.height.equalTo(400)
        }
        
        self.todoListView.snp.makeConstraints {
            $0.top.equalTo(self.calendarView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview().inset(SizeLiteral.horizantalPadding)
            $0.width.equalTo(self.scrollView.snp.width).offset(-SizeLiteral.horizantalPadding * 2)
            $0.height.equalTo(100)
        }
    }
    
    func configureUI() {
        self.view.backgroundColor = .backgroundNormalNormal
    }
    
    func configureNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        let titleLogo = makeBarButtonItem(with: self.titleLogo)
        let moreButton = makeBarButtonItem(with: self.moreButton)
        self.navigationItem.leftBarButtonItem = titleLogo
        self.navigationItem.rightBarButtonItem = moreButton
        
        
    }
}
