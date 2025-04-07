//
//  MenuView.swift
//  kioskapp
//
//  Created by 정근호 on 4/7/25.
//

import UIKit
import SnapKit
import Then

class MenuView: UIView {
    
    let menuData = MenuData.sampleData.menu[0]
    private let menuItemCell = MenuItemCell()
    
    //    private let menuCollectionView = UICollectionView()
    
    private let menuCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
    })
    private let scrollView = UIScrollView()
    
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
        scrollView.do {
            $0.backgroundColor = .black
        }
        menuCollectionView.do {
            $0.dataSource = self
            $0.delegate = self
            $0.showsHorizontalScrollIndicator = false
            $0.register(MenuItemCell.self, forCellWithReuseIdentifier: "MenuItemCell")
        }
    }
    
    private func setUI() {
        
        self.addSubview(scrollView)
        scrollView.addSubview(menuCollectionView)
    }
    
    private func setLayout() {
        
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(50)
            $0.centerX.centerY.equalToSuperview()
        }
        
        menuCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.centerX.centerY.equalToSuperview()
            $0.height.equalToSuperview()
        }
    }
    
}

extension MenuView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuData.items.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        print("selected \(indexPath.item)")
    }
    
}

extension MenuView: UICollectionViewDataSource {
    
    // cell에 표현될 뷰를 설정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuItemCell", for: indexPath) as? MenuItemCell else {
            fatalError("Failed to load cell!")
        }
        let item = menuData.items[indexPath.item]
        cell.configure(item)
        return cell
    }
    
}

extension MenuView: UICollectionViewDelegateFlowLayout {
    
    // 셀의 크기를 지정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let totalPadding: CGFloat = 10
        let availableWidth = collectionView.frame.width - totalPadding
        let widthPerItem = availableWidth / 4
        return CGSize(width: widthPerItem, height: 200)
    }
    
    // 그리드 줄 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 50
    }
    
    //    // 그리드 행 간격
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    //        return 40
    //    }
    
    // section 여백
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
}

#Preview {
    MenuView()
}
