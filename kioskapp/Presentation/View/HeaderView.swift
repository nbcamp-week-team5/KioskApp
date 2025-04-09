//
//  HeaderView.swift
//  kioskapp
//
//  Created by 최안용 on 4/8/25.
//

import UIKit

import SnapKit
import Then

final class HeaderView: UIView {
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
        
    private let underLineView = UIView()
    let segmentedControl = CutomSegmentedControl()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setStyle()
        setUI()
        setLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        segmentedControl.layer.addBottomBorder(color: .systemGray5, width: 2)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setStyle() {
        imageView.do {
            $0.image = UIImage(systemName: "die.face.5.fill")
            $0.tintColor = .systemYellow
            $0.contentMode = .scaleAspectFill
        }
        
        titleLabel.do {
            $0.text = "FiveDonalds"
            $0.font = .boldSystemFont(ofSize: 30)
            $0.textColor = .black
        }
        
        segmentedControl.do {
            $0.backgroundColor = .white
            var index = 0
            for category in Category.allCases {
                $0.insertSegment(withTitle: category.title, at: index, animated: true)
                index += 1
            }
            $0.setBackgroundImage(UIImage(), for: .normal, barMetrics: .default)
            $0.setDividerImage(
                UIImage(),
                forLeftSegmentState: .normal,
                rightSegmentState: .normal,
                barMetrics: .default
            )
            
            $0.setTitleTextAttributes([
                .foregroundColor: UIColor.systemGray2,
                .font: UIFont.systemFont(ofSize: 16, weight: .medium)
            ], for: .normal)
            
            $0.setTitleTextAttributes([
                .foregroundColor: UIColor.systemYellow,
                .font: UIFont.systemFont(ofSize: 16, weight: .bold)
            ], for: .selected)
            
            $0.layer.masksToBounds = false
            $0.addTarget(self, action: #selector(changeUnderLinePosition), for: .valueChanged)
            $0.selectedSegmentIndex = 0
        }
        
        underLineView.do {
            $0.backgroundColor = .systemYellow
        }
    }
    
    private func setUI() {
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(segmentedControl)
        addSubview(underLineView)
    }
    
    private func setLayout() {
        imageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(18)
            $0.top.equalTo(safeAreaLayoutGuide).offset(10)
            $0.size.equalTo(50)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(imageView.snp.trailing).offset(10)
            $0.centerY.equalTo(imageView.snp.centerY)
            $0.trailing.equalToSuperview().inset(18)
        }
        
        segmentedControl.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(15)
            $0.horizontalEdges.equalToSuperview().inset(18)
            $0.height.equalTo(45)
        }
        
        underLineView.snp.makeConstraints {
            $0.top.equalTo(segmentedControl.snp.bottom)
            $0.height.equalTo(2)
            $0.leading.equalTo(segmentedControl)
            $0.width.equalTo(segmentedControl.snp.width).dividedBy(segmentedControl.numberOfSegments)
            $0.bottom.equalToSuperview()
        }
    }
}

extension HeaderView {
    @objc
    private func changeUnderLinePosition() {
        let segmentIndex = CGFloat(segmentedControl.selectedSegmentIndex)
        let segmentWidth = segmentedControl.frame.width / CGFloat(segmentedControl.numberOfSegments)
        let leading = segmentWidth * segmentIndex
        
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self else { return }
            
            self.underLineView.snp.updateConstraints {
                $0.leading.equalTo(self.segmentedControl).offset(leading)
            }
            self.layoutIfNeeded()
        }
    }
}
