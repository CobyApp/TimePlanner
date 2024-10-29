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
    
    private let loadingIndicator = UIActivityIndicatorView(style: .large).then {
        $0.hidesWhenStopped = true
    }
    
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
        $0.editTapAction = { [weak self] note in
            self?.viewModel.presentNoteRegister(note: note)
        }
        $0.deleteTapAction = { [weak self] note in
            self?.confirmDeletion(for: note.id)
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
        self.loadNotes()
    }
    
    // MARK: - func
    
    func setupLayout() {
        self.view.addSubviews(
            self.noteCollectionView,
            self.loadingIndicator
        )
        
        self.noteCollectionView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
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
        self.navigationController?.navigationBar.prefersLargeTitles = false
        let titleLabel = makeBarButtonItem(with: self.titleLabel)
        let rightOffsetButton = self.removeBarButtonItemOffset(with: self.plusButton, offsetX: -10)
        let rightButton = self.makeBarButtonItem(with: rightOffsetButton)
        
        self.navigationItem.leftBarButtonItem = titleLabel
        self.navigationItem.rightBarButtonItem = rightButton
    }
    
    private func confirmDeletion(for noteId: String) {
        let alertController = UIAlertController(title: "삭제 확인", message: "이 노트를 삭제하시겠습니까?", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "삭제", style: .destructive, handler: { [weak self] _ in
            self?.viewModel.deleteNote(noteId: noteId) {
                self?.loadNotes()
            }
        }))
        
        self.present(alertController, animated: true, completion: nil)
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

extension NoteViewController {

    private func loadNotes() {
        self.startLoading()
        self.viewModel.getNotes { [weak self] notes in
            self?.noteCollectionView.notes = notes
            self?.stopLoading()
        }
    }
}
