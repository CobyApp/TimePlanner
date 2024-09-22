//
//  MainViewController.swift
//  TimePlanner
//
//  Created by Coby on 9/20/24.
//

import UIKit

import SnapKit
import Then

final class MainViewController: UIViewController, BaseViewControllerType {
    
    // MARK: - ui component

    private let titleLogo = UIImageView(image: UIImage.Icon.logo.resize(to: CGSize(width: 150, height: 32)))
        
    private let moreButton = MoreButton()
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.baseViewDidLoad()
    }
    
    // MARK: - func
    
    func setupLayout() {
        self.view.addSubviews(
            self.titleLogo,
            self.moreButton
        )
        
        self.titleLogo.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(12)
            $0.leading.equalToSuperview().inset(SizeLiteral.horizantalPadding)
        }
        
        self.moreButton.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(16)
            $0.trailing.equalToSuperview().inset(SizeLiteral.horizantalPadding)
        }
    }
    
    func configureUI() {
        self.view.backgroundColor = .backgroundNormalNormal
    }
}
