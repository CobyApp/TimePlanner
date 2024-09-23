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
        
    private let moreButton = MoreButton()
    
    private let calendarView = CalendarView()
    
    // MARK: - life cycle
    
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
            self.calendarView
        )
        
        self.calendarView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.horizantalPadding)
            $0.bottom.equalToSuperview()
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
