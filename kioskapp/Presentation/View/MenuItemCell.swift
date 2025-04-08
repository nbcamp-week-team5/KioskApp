import UIKit
import SnapKit
import Then

class MenuItemCell: UICollectionViewCell {
    
    static let identifier = "MenuItemCell"
    
    private let menuImageView = UIImageView()
    private let nameLabel = UILabel()
    private let priceLabel = UILabel()
    private let stackView = UIStackView()
    
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
        contentView.backgroundColor = .white
        
        menuImageView.do {
            $0.contentMode = .scaleAspectFit
            $0.layer.cornerRadius = 8
            $0.clipsToBounds = true
        }
        
        nameLabel.do {
            $0.font = .systemFont(ofSize: 14, weight: .medium)
            $0.textAlignment = .center
            $0.textColor = .black
        }
        
        priceLabel.do {
            $0.font = .systemFont(ofSize: 14, weight: .medium)
            $0.textAlignment = .center
            $0.textColor = .black
        }
        
        stackView.do {
            $0.axis = .vertical
            $0.spacing = 1
            $0.alignment = .fill
            $0.distribution = .fillEqually
        }
    }
    
    private func setUI() {
        contentView.addSubview(menuImageView)
        contentView.addSubview(stackView)
        
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(priceLabel)
    }
    
    private func setLayout() {
        menuImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(menuImageView.snp.bottom).offset(-16)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalToSuperview().offset(-16)
        }
    }
    
    func configure(with item: MenuItem) {
        nameLabel.text = item.item.name
        priceLabel.text = "\(item.item.price)원"
        menuImageView.image = UIImage(named: item.item.image)
    }
}
