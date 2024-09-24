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
    
    private let settingButton = SettingButton()
    
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
    }
    
    func configureUI() {
        self.view.backgroundColor = .backgroundNormalNormal
    }
    
    func configureNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        let titleLabel = makeBarButtonItem(with: self.titleLabel)
        let settingButton = makeBarButtonItem(with: self.settingButton)
        self.navigationItem.leftBarButtonItem = titleLabel
        self.navigationItem.rightBarButtonItem = settingButton
    }
}
