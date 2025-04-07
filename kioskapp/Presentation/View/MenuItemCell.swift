//
//  MenuItemCell.swift
//  kioskapp
//
//  Created by 정근호 on 4/7/25.
//

import UIKit
import SnapKit
import Then

class MenuItemCell: UICollectionViewCell {
    static let identifier = "MenuItemCell"
    let menuData = MenuData.sampleData.menu[0]
    
    private let imageSize: CGFloat = 100
    
    private let imageView = UIImageView()
    private let nameLabel = UILabel()
    private let priceLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure(menuData.items[0])
        setStyle()
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setStyle() {
        imageView.do {
            $0.contentMode = .scaleAspectFit
        }
        
        nameLabel.do {
            $0.font = .systemFont(ofSize: 20, weight: .bold)
            $0.textAlignment = .center
        }
        
        priceLabel.do {
            $0.font = .systemFont(ofSize: 16, weight: .medium)
            $0.textAlignment = .center
        }
    }
    
    private func setUI() {
        [imageView, nameLabel, priceLabel].forEach {
            self.addSubview($0)
        }
    }
    
    private func setLayout() {
                
        imageView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.equalTo(imageSize)
            $0.height.equalTo(imageSize)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom)
            $0.centerX.equalToSuperview()
        }
        
        priceLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(1)
            $0.centerX.equalToSuperview()
        }
    }
    
    func configure(_ item: MenuItem) {
        imageView.image = UIImage(named: item.imageName)
        nameLabel.text = item.name
        priceLabel.text = String(item.price) + "원"
    }
}

#Preview {
    MenuItemCell()
}
