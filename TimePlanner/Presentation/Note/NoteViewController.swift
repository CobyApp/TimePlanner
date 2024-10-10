//
//  NoteViewController.swift
//  TimePlanner
//
//  Created by Coby on 9/24/24.
//

import UIKit

import SnapKit
import Then

final class NoteViewController: UIViewController, BaseViewControllerType, Navigationable {
    
    // MARK: - ui component
    
    private let titleLabel = PaddingLabel().then {
        $0.textColor = .labelNormal
        $0.font = UIFont.font(size: 20, weight: .bold)
        $0.padding = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 0)
        $0.text = "노트"
        $0.frame = CGRect(x: 0, y: 0, width: 100, height: 0)
    }
    
    private lazy var plusButton = PlusButton().then {
        let action = UIAction { [weak self] _ in
            self?.viewModel.presentNoteRegister()
        }
        $0.addAction(action, for: .touchUpInside)
    }
    
    private lazy var noteCollectionView = NoteCollectionView().then {
        $0.editTapAction = { [weak self] in
            self?.viewModel.presentNoteRegister()
        }
        $0.deleteTapAction = { [weak self] in
            // 노트 삭제
        }
    }
    
    // MARK: - property
    
    private let viewModel: NoteViewModel
    
    // MARK: - life cycle
    
    init(viewModel: NoteViewModel) {
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
            self.noteCollectionView
        )
        
        self.noteCollectionView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func configureUI() {
        self.view.backgroundColor = .backgroundNormalNormal
    }
    
    func configureNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        let titleLabel = makeBarButtonItem(with: self.titleLabel)
        let rightOffsetButton = self.removeBarButtonItemOffset(with: self.plusButton, offsetX: -10)
        let rightButton = self.makeBarButtonItem(with: rightOffsetButton)
        
        self.navigationItem.leftBarButtonItem = titleLabel
        self.navigationItem.rightBarButtonItem = rightButton
    }
}
