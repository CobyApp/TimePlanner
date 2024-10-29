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
    
    private let loadingIndicator = UIActivityIndicatorView(style: .large).then {
        $0.hidesWhenStopped = true
    }
    
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
    
    private lazy var monthView = MonthView()
    
    private let toDoInfoView = TaskInfoView(title: "할일", countText: "0 / 0")
    private let noteInfoView = TaskInfoView(title: "노트", countText: "0")
    private let dDayInfoView = TaskInfoView(title: "디데이", countText: "0")
    
    private lazy var stackView = UIStackView(arrangedSubviews: [self.toDoInfoView, self.noteInfoView, self.dDayInfoView]).then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 8
    }
    
    private let barGraphCollectionView = BarGraphCollectionView()
    
    // MARK: - property
    
    private let viewModel: InfoViewModel
    
    private var selectedDate: Date?
    
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
        
        self.monthView.onDateSelected = { [weak self] selectedDate in
            self?.selectedDate = selectedDate
            self?.loadData(date: selectedDate)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configureNavigationBar()
        self.loadData(date: self.selectedDate ?? Date())
    }
    
    // MARK: - func
    
    func setupLayout() {
        self.view.addSubviews(
            self.monthView,
            self.stackView,
            self.barGraphCollectionView,
            self.loadingIndicator
        )
        
        self.monthView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.horizantalPadding)
            $0.height.equalTo(60)
        }
        
        self.stackView.snp.makeConstraints {
            $0.top.equalTo(self.monthView.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.horizantalPadding)
        }
        
        self.barGraphCollectionView.snp.makeConstraints {
            $0.top.equalTo(self.stackView.snp.bottom).offset(SizeLiteral.verticalPadding)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        self.loadingIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
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
    
    private func startLoading() {
        DispatchQueue.main.async { [weak self] in
            self?.loadingIndicator.startAnimating()
        }
    }

    private func stopLoading() {
        DispatchQueue.main.async { [weak self] in
            self?.loadingIndicator.stopAnimating()
        }
    }
}

extension InfoViewController {
    
    private func loadData(date: Date) {
        self.startLoading()
        
        var isCategoriesLoaded = false
        var isNotesLoaded = false
        var isDDaysLoaded = false
        
        func checkIfLoadingComplete() {
            if isCategoriesLoaded && isNotesLoaded && isDDaysLoaded {
                self.stopLoading()
            }
        }
        
        self.viewModel.getCategories(date: date) { [weak self] categories in
            DispatchQueue.main.async { [weak self] in
                self?.toDoInfoView.updateCountText("\(categories.checkedToDo) / \(categories.totalToDo)")
                self?.barGraphCollectionView.categories = categories
                isCategoriesLoaded = true
                checkIfLoadingComplete()
            }
        }
        
        self.viewModel.getNotes(date: date) { [weak self] notes in
            DispatchQueue.main.async { [weak self] in
                self?.noteInfoView.updateCountText("\(notes.count)")
                isNotesLoaded = true
                checkIfLoadingComplete()
            }
        }
        
        self.viewModel.getDDay(date: date) { [weak self] dDays in
            DispatchQueue.main.async { [weak self] in
                self?.dDayInfoView.updateCountText("\(dDays.count)")
                isDDaysLoaded = true
                checkIfLoadingComplete()
            }
        }
    }
}
