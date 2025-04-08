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
    
    private let scrollView = UIScrollView()
    private let cartTableView = UITableView()
    private let emptyLabel = UILabel()
    
    private let cartRepository: CartRepositoryProtocol
    
    init(cartRepository: CartRepositoryProtocol) {
        self.cartRepository = cartRepository
        super.init(frame: .zero)
        
        setStyle()
        setUI()
        setLayout()
        reloadCart()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setStyle() {
        
        scrollView.do {
            $0.isScrollEnabled = true
            $0.layer.borderColor = UIColor.lightGray.cgColor
            $0.layer.borderWidth = 1.0
            $0.layer.cornerRadius = 20
        }
        
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
        self.addSubview(scrollView)
        scrollView.addSubview(cartTableView)
        scrollView.addSubview(emptyLabel)
    }
    
    private func setLayout() {
        
        scrollView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(18)
        }
        
        cartTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        emptyLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    private func reloadCart() {
        cartTableView.reloadData()
        updateEmptyState()
    }
    
    private func updateEmptyState() {
        UIView.transition(with: self, duration: 0.3, options: .transitionCrossDissolve, animations: {
            self.emptyLabel.isHidden = !self.cartRepository
                .getCartItems().isEmpty
            self.cartTableView.isHidden = self.cartRepository
                .getCartItems().isEmpty
        }, completion: nil)
    }
}

extension MenuCartView: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

extension MenuCartView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartRepository.getCartItems().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuCartCell.identifier, for: indexPath) as! MenuCartCell
        let cartItem = cartRepository.getCartItems()
        let item = cartItem[indexPath.row]
        cell.configure(item)
        cell.delegate = self
        return cell
    }
}

extension MenuCartView: MenuCartCellDelegate {
    func didTapPlus(on cell: MenuCartCell) {
        guard let indexPath = cartTableView.indexPath(for: cell) else { return }
        let item = cartRepository.getCartItems()[indexPath.row]
        let updatedItem = CartItem(item: item.item, amount: item.amount + 1)
        cartRepository.updateCartItem(updatedItem)
        reloadCart()
    }
    
    func didTapMinus(on cell: MenuCartCell) {
        guard let indexPath = cartTableView.indexPath(for: cell) else { return }
        let item = cartRepository.getCartItems()[indexPath.row]
        if item.amount <= 1 {
            cartRepository.deleteCartItem(item.item.id)
        } else {
            let updatedItem = CartItem(item: item.item, amount: item.amount - 1)
            cartRepository.updateCartItem(updatedItem)
        }
        reloadCart()
    }
}
