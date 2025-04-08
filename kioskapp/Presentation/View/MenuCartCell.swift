//  MenuCartCell.swift
//  kioskapp
//
//  Created by 정근호 on 4/8/25.
//

import UIKit
import SnapKit
import Then

protocol MenuCartCellDelegate: AnyObject {
    func didTapPlus(on cell: MenuCartCell)
    func didTapMinus(on cell: MenuCartCell)
}

class MenuCartCell: UITableViewCell {
    
    static let identifier = "MenuCartCell"
    
    weak var delegate: MenuCartCellDelegate?
    
    private let nameLabel = UILabel()
    private let minusButton = UIButton()
    private let plusButton = UIButton()
    private let quantityLabel = UILabel()
    private let priceLabel = UILabel()
    private let cartStackView = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setStyle()
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setStyle() {
        
        cartStackView.do {
            $0.axis = .horizontal
            $0.distribution = .equalSpacing
        }
        
        nameLabel.do {
            $0.font = .systemFont(ofSize: 16, weight: .medium)
            $0.textAlignment = .center
        }
        
        minusButton.do {
            $0.setTitle("-", for: .normal)
            $0.addTarget(self, action: #selector(minusClicked), for: .touchUpInside)
        }
        
        plusButton.do {
            $0.setTitle("+", for: .normal)
            $0.addTarget(self, action: #selector(plusClicked), for: .touchUpInside)
        }
        
        quantityLabel.do {
            $0.text = "1"
            $0.font = .systemFont(ofSize: 16, weight: .medium)
            $0.textAlignment = .center
        }
        
        priceLabel.do {
            $0.font = .systemFont(ofSize: 16, weight: .medium)
            $0.textAlignment = .center
        }
    }
    
    private func setUI() {
        self.addSubview(nameLabel)
        self.addSubview(priceLabel)
        self.addSubview(cartStackView)
        
        [minusButton, quantityLabel, plusButton].forEach {
            cartStackView.addArrangedSubview($0)
        }
    }
    
    private func setLayout() {
        nameLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(10)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(100)
        }
        
        cartStackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(nameLabel.snp.trailing).offset(10)
            $0.trailing.equalTo(priceLabel.snp.leading).offset(-10)
        }
        
        minusButton.snp.makeConstraints {
            $0.width.height.equalTo(30)
        }
        
        quantityLabel.snp.makeConstraints {
            $0.width.equalTo(30)
        }
        
        plusButton.snp.makeConstraints {
            $0.width.height.equalTo(30)
        }
        
        priceLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-10)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(100)
        }
    }
    
    @objc func minusClicked() {
        delegate?.didTapMinus(on: self)
    }
    
    @objc func plusClicked() {
        delegate?.didTapPlus(on: self)
    }
    
    func configure(_ item: CartItem) {
        nameLabel.text = item.item.name
        priceLabel.text = "\(item.item.price * item.amount)원"
        quantityLabel.text = "\(item.amount)"
    }
}

#Preview {
    MenuItemCell()
}
