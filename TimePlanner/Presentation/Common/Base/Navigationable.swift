//
//  Navigationable.swift
//  TimePlanner
//
//  Created by Coby on 9/20/24.
//

import UIKit

protocol Navigationable: UIGestureRecognizerDelegate {
    func setupNavigation()
}

extension Navigationable where Self: UIViewController {
    func setupNavigation() {
        self.setupNavigationBar()
        self.setupBackButton()
        self.setDragPopGesture(self)
    }
    
    private func backButtonItem() -> UIBarButtonItem {
        let button = BackButton()
        let buttonAction = UIAction { [weak self] _ in
            self?.back()
        }
        button.addAction(buttonAction, for: .touchUpInside)
        let leftOffsetBackButton = self.removeBarButtonItemOffset(with: button, offsetX: 10)
        let backButton = self.makeBarButtonItem(with: leftOffsetBackButton)
        return backButton
    }
    
    private func setupBackButton() {
        let backButton = self.backButtonItem()
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    private func back() {
        if let navigation = self.navigationController {
            navigation.popViewController(animated: true)
        }
    }
    
    private func setupNavigationBar() {
        guard let navigationBar = navigationController?.navigationBar else { return }
        let appearance = UINavigationBarAppearance()
        let font = UIFont.font(size: 18, weight: .semibold)
        let largeFont = UIFont.font(size: 18, weight: .medium)
        
        appearance.titleTextAttributes = [.font: font]
        appearance.largeTitleTextAttributes = [.font: largeFont]
        appearance.shadowColor = .clear
        appearance.backgroundColor = .backgroundNormalNormal
        
        navigationBar.standardAppearance = appearance
        navigationBar.compactAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
    }
    
    func setDragPopGesture(_ viewController: Navigationable) {
        self.navigationController?.interactivePopGestureRecognizer?.delegate = viewController
    }
}
