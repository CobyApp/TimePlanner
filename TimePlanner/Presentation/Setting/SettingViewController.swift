//
//  SettingViewController.swift
//  TimePlanner
//
//  Created by Coby on 10/7/24.
//

import UIKit

import SnapKit
import Then

final class SettingViewController: UIViewController, BaseViewControllerType, Navigationable {
    
    // MARK: - ui component
    
    private lazy var settingListView = SettingListView().then {
        $0.updateSettingItems(self.settingOptions)
    }
    
    // MARK: - property
    
    private let viewModel: SettingViewModel
    
    private lazy var settingOptions: [SettingOptionModel] = [
        SettingOptionModel(
            title: "로그아웃",
            handler: {
                self.viewModel.signOut()
        })
    ]
    
    // MARK: - life cycle
    
    init(viewModel: SettingViewModel) {
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
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - func
    
    func setupLayout() {
        self.view.addSubviews(
            self.settingListView
        )
        
        self.settingListView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configureUI() {
        self.view.backgroundColor = .backgroundNormalNormal
    }
    
    func configureNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.title = "설정"
    }
}
