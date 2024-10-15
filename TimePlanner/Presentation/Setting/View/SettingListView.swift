//
//  SettingListView.swift
//  TimePlanner
//
//  Created by Coby on 10/15/24.
//

import UIKit

import SnapKit
import Then

final class SettingListView: UIView, BaseViewType {

    // MARK: - Properties
    
    private var settingOptions: [SettingOption] = []
    
    // MARK: - UI Components
    
    private lazy var listTableView = UITableView().then {
        $0.register(SettingItemTableViewCell.self, forCellReuseIdentifier: SettingItemTableViewCell.className)
        $0.separatorStyle = .none
        $0.backgroundColor = .backgroundNormalNormal
        $0.delegate = self
        $0.dataSource = self
    }
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.baseInit()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Base Func
    
    func setupLayout() {
        self.addSubviews(self.listTableView)

        self.listTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configureUI() {
        self.backgroundColor = .backgroundNormalNormal
    }
    
    // MARK: - Public Method
    
    func updateSettingItems(_ items: [SettingOption]) {
        self.settingOptions = items
        self.listTableView.reloadData()
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension SettingListView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.settingOptions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingItemTableViewCell.className, for: indexPath) as? SettingItemTableViewCell else {
            return UITableViewCell()
        }
        
        let item = self.settingOptions[indexPath.row]
        cell.menuLabel.text = item.title
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let item = self.settingOptions[indexPath.row]
        item.handler()
    }
}
