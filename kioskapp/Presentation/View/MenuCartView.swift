//
//  MenuCartView.swift
//  kioskapp
//
//  Created by 정근호 on 4/7/25.
//

import UIKit
import SnapKit
import Then

class MenuCartView: UIView {
    
    private let cartTableView = UITableView()
    private let emptyLabel = UILabel()
    
    var menuCart = [MenuItem]() {
        didSet {
            cartTableView.reloadData()
            updateEmptyState()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setStyle()
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setStyle() {
        cartTableView.do {
            $0.delegate = self
            $0.dataSource = self
            $0.register(MenuCartCell.self, forCellReuseIdentifier: MenuCartCell.identifier)
            $0.separatorStyle = .singleLine
            $0.backgroundColor = .white
            $0.rowHeight = 50
        }
        
        emptyLabel.do {
            $0.textAlignment = .center
            $0.textColor = .gray
            $0.font = .systemFont(ofSize: 16, weight: .medium)
            $0.text = "장바구니가 비어 있습니다."
            $0.isHidden = true
        }
    }
    
    private func setUI() {
        self.addSubview(cartTableView)
        self.addSubview(emptyLabel)
    }
    
    private func setLayout() {
        cartTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        emptyLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    func addMenuItem(_ item: MenuItem) {
        menuCart.append(item)
    }
    
    private func updateEmptyState() {
        UIView.transition(with: self, duration: 0.3, options: .transitionCrossDissolve, animations: {
            self.emptyLabel.isHidden = !self.menuCart.isEmpty
            self.cartTableView.isHidden = self.menuCart.isEmpty
        }, completion: nil)
    }
}

extension MenuCartView: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1 // 섹션 수는 1로 고정
    }
}

extension MenuCartView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuCart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuCartCell.identifier, for: indexPath) as! MenuCartCell
        let item = menuCart[indexPath.row]
        cell.configure(item)
        return cell
    }
}
