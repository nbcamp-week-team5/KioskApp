//
//  MenuCartCell.swift
//  kioskapp
//
//  Created by 정근호 on 4/8/25.
//

import UIKit
import SnapKit
import Then

class MenuCartCell: UITableViewCell {
    
    static let identifier = "MenuCartCell"
    let menuData = MenuData.sampleData.menu[0]
            
    private let nameLabel = UILabel()
    private let minusButton = UIButton()
    private let plusButton = UIButton()
    private let quantityLabel = UILabel()
    private let priceLabel = UILabel()
    private let cartStackView = UIStackView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure(menuData.items[0])
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
        
        [cartStackView].forEach {
            self.addSubview($0)
        }
        
        [nameLabel, minusButton, quantityLabel, plusButton, priceLabel].forEach {
            self.addSubview($0)
        }
        
    }
    
    private func setLayout() {
        nameLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(10)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(100)
        }
        
        cartStackView.snp.makeConstraints {
            $0.center.equalToSuperview()
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
//        decreaseCartItemQuantity()
    }
    
    @objc func plusClicked() {
//        increaseCartItemQuantity()
    }
    
    func configure(_ item: MenuItem) {
        nameLabel.text = item.name
        priceLabel.text = String(item.price) + "원"
    }
}

#Preview {
    MenuItemCell()
}
