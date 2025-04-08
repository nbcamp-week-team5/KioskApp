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
    
    private let cartHeader = UIStackView()
    private let cartTitleLabel = UILabel()
    private let cartAmount = UILabel()
    
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
            $0.rowHeight = 80
            $0.estimatedRowHeight = 80
            $0.isScrollEnabled = true
        }
        
        emptyLabel.do {
            $0.textAlignment = .center
            $0.textColor = .gray
            $0.font = .systemFont(ofSize: 16, weight: .medium)
            $0.text = "장바구니가 비어 있습니다."
            $0.isHidden = true
        }
        
        cartHeader.do {
            $0.axis = .horizontal
            $0.distribution = .fill
            $0.spacing = 10
        }
        
        cartTitleLabel.do {
            $0.text = "장바구니"
            $0.font = .systemFont(ofSize: 20, weight: .medium)
            $0.textColor = .black
        }
        
        cartAmount.do {
            $0.text = "총 \(cartRepository.getCartItems().count)개"
            $0.font = .systemFont(ofSize: 20, weight: .medium)
            $0.textColor = .black
        }
    }
    
    private func setUI() {
        self.addSubview(scrollView)
        
        scrollView.addSubview(cartHeader)
        scrollView.addSubview(cartTableView)
        scrollView.addSubview(emptyLabel)
        
        [cartTitleLabel, cartAmount].forEach {
            cartHeader.addArrangedSubview($0)
        }
    }
    
    private func setLayout() {
        scrollView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(18)
            $0.top.bottom.equalToSuperview()
        }
        
        cartHeader.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(18)
        }
        
        cartTitleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
        }
        
        cartAmount.snp.makeConstraints {
            $0.trailing.equalToSuperview()
        }
        
        cartTableView.snp.makeConstraints {
            $0.top.equalTo(cartHeader.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(cartRepository.getCartItems().count * 80)
        }
        
        emptyLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    func reloadCart() {
        cartTableView.reloadData()
        updateEmptyState()
        
        cartTableView.snp.updateConstraints {
            $0.height.equalTo(cartRepository.getCartItems().count * 40)
        }
        
        if !cartRepository.getCartItems().isEmpty {
            let lastIndex = IndexPath(row: cartRepository.getCartItems().count - 1, section: 0)
            cartTableView.scrollToRow(at: lastIndex, at: .bottom, animated: true)
        }
        
        var cartAmountValue = 0
        cartRepository.getCartItems().forEach { cartAmountValue += $0.amount }
        
        cartAmount.text = "총 \(cartAmountValue)개"
        
        self.layoutIfNeeded()
    }
    
    private func updateEmptyState() {
        UIView.transition(with: self, duration: 0.3, options: .transitionCrossDissolve, animations: {
            self.emptyLabel.isHidden = !self.cartRepository.getCartItems().isEmpty
            self.cartTableView.isHidden = self.cartRepository.getCartItems().isEmpty
        }, completion: nil)
    }
}

extension MenuCartView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}

extension MenuCartView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartRepository.getCartItems().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MenuCartCell.identifier, for: indexPath) as? MenuCartCell else {
            return UITableViewCell()
        }
        let cartItems = cartRepository.getCartItems()
        let cartItem = cartItems[indexPath.row]
        cell.configure(cartItem)
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
        print(cartRepository.getCartItems())
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
