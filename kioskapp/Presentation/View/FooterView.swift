//
//  FooterView.swift
//  kioskapp
//
//  Created by 최안용 on 4/9/25.
//

import UIKit

import SnapKit
import Then

protocol FooterViewDelegate: AnyObject {
    func didTapPaymentButton()
    func didTapCancelButton()
}

final class FooterView: UIView {
    private let titleLabel = UILabel()
    private let amountLabel = UILabel()
    private let cancleButton = UIButton(type: .system)
    private let paymentButton = UIButton(type: .system)
    private let buttonStackView = UIStackView()
    private var viewModel: KioskMainViewModel
    weak var delegate: FooterViewDelegate?
    
    init(viewModel: KioskMainViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        
        setStyle()
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setStyle() {
        titleLabel.do {
            $0.text = "결제 금액"
            $0.font = .systemFont(ofSize: 16, weight: .bold)
            $0.textColor = .black
        }
        
        amountLabel.do {
            $0.text = "0원"
            $0.font = .systemFont(ofSize: 20, weight: .black)
            $0.textColor = .black
        }
        
        cancleButton.do {
            $0.setTitle("주문 취소", for: .normal)
            $0.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
            $0.layer.cornerRadius = 15
            $0.setTitleColor(.white, for: .normal)
            $0.backgroundColor = .black
            $0.addTarget(self, action: #selector(didTapCancelButton), for: .touchUpInside)
        }
        
        paymentButton.do {
            $0.setTitle("주문 하기", for: .normal)
            $0.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
            $0.layer.cornerRadius = 15
            $0.setTitleColor(.black, for: .normal)
            $0.backgroundColor = .systemYellow
            $0.addTarget(self, action: #selector(didTapPaymentButton), for: .touchUpInside)
        }
        
        buttonStackView.do {
            $0.axis = .horizontal
            $0.spacing = 8
            $0.distribution = .fillEqually
        }
    }
    
    private func setUI() {
        [cancleButton, paymentButton].forEach {
            buttonStackView.addArrangedSubview($0)
        }
        [titleLabel, amountLabel, buttonStackView].forEach {
            addSubview($0)
        }
    }
    
    private func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(4)
            $0.leading.equalToSuperview().inset(22)
            $0.centerY.equalTo(amountLabel.snp.centerY)
        }
        
        amountLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(4)
            $0.trailing.equalToSuperview().inset(22)
        }
        
        buttonStackView.snp.makeConstraints {
            $0.top.equalTo(amountLabel.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview().inset(18)
            $0.height.equalTo(40)
            $0.bottom.equalToSuperview().inset(8)
        }
    }
}

extension FooterView {
    func reloadAmount() {
        amountLabel.text = "\(viewModel.getTotalCartItemPrice())원"
    }
}

extension FooterView {
    @objc
    private func didTapPaymentButton() {
        delegate?.didTapPaymentButton()
    }
    
    @objc
    private func didTapCancelButton() {
        delegate?.didTapCancelButton()
    }
}
