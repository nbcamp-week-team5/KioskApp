//  MenuCartCell.swift
//  kioskapp
//
//  Created by 정근호 on 4/8/25.
//

import UIKit
import SnapKit
import Then

protocol MenuCartCellDelegate: AnyObject {
    func didTapPlus(on cell: CartCell)
    func didTapMinus(on cell: CartCell)
}

class CartCell: UITableViewCell {
    
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
        self.selectionStyle = .none
    
        cartStackView.do {
            $0.axis = .horizontal
            $0.distribution = .equalSpacing
            $0.spacing = 10
        }
        
        nameLabel.do {
            $0.font = .systemFont(ofSize: 16, weight: .medium)
            $0.textAlignment = .left
        }
        
        minusButton.do {
            $0.setImage(UIImage(systemName: "minus.circle.fill"), for: .normal)
            $0.tintColor = .systemGray
            $0.contentVerticalAlignment = .fill
            $0.contentHorizontalAlignment = .fill
            $0.addTarget(self, action: #selector(minusClicked), for: .touchUpInside)
            $0.isUserInteractionEnabled = true
        }
        
        plusButton.do {
            $0.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
            $0.tintColor = .systemGray
            $0.contentVerticalAlignment = .fill
            $0.contentHorizontalAlignment = .fill
            $0.addTarget(self, action: #selector(plusClicked), for: .touchUpInside)
            $0.isUserInteractionEnabled = true
        }
        
        quantityLabel.do {
            $0.font = .systemFont(ofSize: 16, weight: .medium)
            $0.textAlignment = .center
        }
        
        priceLabel.do {
            $0.font = .systemFont(ofSize: 16, weight: .medium)
            $0.textAlignment = .right
        }
    }
    
    private func setUI() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(cartStackView)
        contentView.addSubview(priceLabel)

        [minusButton, quantityLabel, plusButton].forEach {
            cartStackView.addArrangedSubview($0)
        }
    }
    
    private func setLayout() {
        nameLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
        }
        
        cartStackView.snp.makeConstraints {
            $0.centerY.centerX.equalToSuperview()
           
        }
        
        minusButton.snp.makeConstraints {
            $0.width.height.equalTo(20)
        }
        
        quantityLabel.snp.makeConstraints {
            $0.width.equalTo(20)
        }
        
        plusButton.snp.makeConstraints {
            $0.width.height.equalTo(20)
        }
        
        priceLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-16)
            $0.centerY.equalToSuperview()
        }
    }
    
    @objc private func minusClicked() {
        delegate?.didTapMinus(on: self)
    }
    
    @objc private func plusClicked() {
        delegate?.didTapPlus(on: self)
    }
    
    func configure(_ item: CartItem) {
        nameLabel.text = item.item.name
        priceLabel.text = "\(item.item.price * item.amount)원"
        quantityLabel.text = "\(item.amount)"
    }
}

#Preview {
    MenuCell()
}
