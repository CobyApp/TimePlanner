//
//  NoteRegisterViewController.swift
//  TimePlanner
//
//  Created by Coby on 10/7/24.
//

import UIKit

import SnapKit
import Then

final class NoteRegisterViewController: UIViewController, BaseViewControllerType, Navigationable {
    
    // MARK: - ui component
    
    // MARK: - property
    
    private let viewModel: NoteRegisterViewModel
    
    // MARK: - life cycle
    
    init(viewModel: NoteRegisterViewModel) {
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
        self.title = "노트 작성"
    }
}
