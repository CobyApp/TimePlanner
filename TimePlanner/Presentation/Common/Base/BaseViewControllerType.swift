//
//  BaseViewControllerType.swift
//  TimePlanner
//
//  Created by Coby on 9/22/24.
//

import UIKit

///
/// UIViewController 타입의 클래스를 구성하기 위한 기본적인 함수를 제공합니다.
///

protocol BaseViewControllerType: UIViewController {
    func setupLayout()
    func configureUI()
}

extension BaseViewControllerType {
    func baseViewDidLoad() {
        self.setupLayout()
        self.configureUI()
    }
}
