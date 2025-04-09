//
//  MenuCartView.swift
//  kioskapp
//
//  Created by 정근호 on 4/7/25.
//

import UIKit
import SnapKit
import Then

class CartView: UIView {
    private let containerView = UIView()
    
    private let cartTableView = UITableView()
    private let emptyLabel = UILabel()
    
    private let cartHeader = UIStackView()
    private let cartTitleLabel = UILabel()
    private let cartAmount = UILabel()
    
    private var viewModel: KioskMainViewModel
    
    private let delegate: CartViewDelegate
    
    init(viewModel: KioskMainViewModel) {
        self.viewModel = viewModel
        self.delegate = CartViewDelegate(viewModel: viewModel, cartTableView: cartTableView)
        super.init(frame: .zero)
        setStyle()
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setStyle() {
        containerView.do {
            $0.layer.borderColor = UIColor.lightGray.cgColor
            $0.layer.borderWidth = 1.0
            $0.layer.cornerRadius = 20
        }
        
        cartTableView.do {
            $0.delegate = delegate
            $0.dataSource = delegate
            $0.register(CartCell.self, forCellReuseIdentifier: CartCell.identifier)
            $0.separatorStyle = .singleLine
            $0.backgroundColor = .white
            $0.rowHeight = 40
            $0.estimatedRowHeight = 40
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
            $0.text = "총 \(viewModel.getCartItems().count)개"
            $0.font = .systemFont(ofSize: 20, weight: .medium)
            $0.textColor = .black
        }
    }
    
    private func setUI() {
        self.addSubview(containerView)

        containerView.addSubview(cartHeader)
        containerView.addSubview(cartTableView)
        containerView.addSubview(emptyLabel)
        
        [cartTitleLabel, cartAmount].forEach {
            cartHeader.addArrangedSubview($0)
        }
    }
    
    private func setLayout() {
        containerView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.trailing.leading.equalToSuperview().inset(18)
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
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        emptyLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
        
    func reloadCart(_ cartItem: CartItem? = nil) {
        cartTableView.reloadData()
        updateEmptyState()
        
        let cartAmountValue = viewModel.getCartItems().reduce(0) { $0 + $1.amount }
        cartAmount.text = "총 \(cartAmountValue)개"
                
        if let cartItem = cartItem,
           let selectedIndex = viewModel.getCartItems().firstIndex(
            where: { $0.item.id == cartItem.item.id }
           ) {
            let indexPath = IndexPath(row: selectedIndex, section: 0)
            cartTableView.scrollToRow(at: indexPath, at: .top, animated: true)
        }
        
        self.layoutIfNeeded()
    }
    
    private func updateEmptyState() {
        UIView.transition(with: self, duration: 0.1, options: .transitionCrossDissolve, animations: {
            self.emptyLabel.isHidden = !self.viewModel.getCartItems().isEmpty
            self.cartTableView.isHidden = self.viewModel.getCartItems().isEmpty
            self.cartHeader.isHidden = self.viewModel.getCartItems().isEmpty
        }, completion: nil)
    }
}
