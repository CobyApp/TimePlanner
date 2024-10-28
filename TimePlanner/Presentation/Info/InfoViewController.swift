//
//  InfoViewController.swift
//  TimePlanner
//
//  Created by Coby on 9/24/24.
//

import UIKit

import SnapKit
import Then

final class InfoViewController: UIViewController, BaseViewControllerType, Navigationable {
    
    // MARK: - ui component
    
    private let titleLabel = PaddingLabel().then {
        $0.textColor = .labelNormal
        $0.font = UIFont.font(size: 20, weight: .bold)
        $0.padding = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 0)
        $0.text = "정보"
        $0.frame = CGRect(x: 0, y: 0, width: 100, height: 0)
    }
    
    private lazy var settingButton = SettingButton().then {
        let action = UIAction { [weak self] _ in
            self?.viewModel.presentSetting()
        }
        $0.addAction(action, for: .touchUpInside)
    }
    
    private let toDoInfoView = TaskInfoView(title: "할일", countText: "0 / 0")
    private let noteInfoView = TaskInfoView(title: "노트", countText: "0")
    private let dDayInfoView = TaskInfoView(title: "디데이", countText: "0")
    
    private lazy var stackView = UIStackView(arrangedSubviews: [self.toDoInfoView, self.noteInfoView, self.dDayInfoView]).then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 24
    }
    
    // MARK: - property
    
    private let viewModel: InfoViewModel
    
    // MARK: - life cycle
    
    init(viewModel: InfoViewModel) {
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
        self.loadData()
    }
    
    // MARK: - func
    
    func setupLayout() {
        self.view.addSubviews(self.stackView)
        
        self.stackView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(SizeLiteral.verticalPadding)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.horizantalPadding)
        }
    }
    
    func configureUI() {
        self.view.backgroundColor = .backgroundNormalNormal
    }
    
    func configureNavigationBar() {
        let titleLabel = makeBarButtonItem(with: self.titleLabel)
        let rightOffsetButton = self.removeBarButtonItemOffset(with: self.settingButton, offsetX: -10)
        let rightButton = self.makeBarButtonItem(with: rightOffsetButton)
        
        self.navigationItem.leftBarButtonItem = titleLabel
        self.navigationItem.rightBarButtonItem = rightButton
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
}

extension InfoViewController {
    
    private func loadData() {
        self.viewModel.getCategories { [weak self] categories in
            DispatchQueue.main.async { [weak self] in
                self?.toDoInfoView.updateCountText("\(categories.checkedToDo) / \(categories.totalToDo)")
            }
        }
        
        self.viewModel.getNotes { [weak self] notes in
            DispatchQueue.main.async { [weak self] in
                self?.noteInfoView.updateCountText("\(notes.count)")
            }
        }
        
        self.viewModel.getDDay { [weak self] dDays in
            DispatchQueue.main.async { [weak self] in
                self?.dDayInfoView.updateCountText("\(dDays.count)")
            }
        }
    }
}
