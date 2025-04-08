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
    private var menuCart = MenuCartView().menuCart
    var currentIndex: Int = 0
    private let pageControl = UIPageControl()
    
    private let menuCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = 0
        $0.minimumInteritemSpacing = 0
    })
    
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
        menuCollectionView.do {
            $0.dataSource = self
            $0.delegate = self
            $0.showsHorizontalScrollIndicator = false
            $0.register(MenuItemCell.self, forCellWithReuseIdentifier: "MenuItemCell")
        }
        
        pageControl.do {
            $0.currentPage = 0
            $0.pageIndicatorTintColor = .lightGray
            $0.currentPageIndicatorTintColor = .systemYellow
            $0.addTarget(self, action: #selector(pageControlTapped(_:)), for: .valueChanged)
        }
        
        pageControl.numberOfPages = Int(ceil(Double(menuData.items.count) / 4.0))
    }
    
    private func setUI() {
        self.addSubview(menuCollectionView)
        self.addSubview(pageControl)
    }
    
    private func setLayout() {
        menuCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        pageControl.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    @objc private func pageControlTapped(_ sender: UIPageControl) {
        let page = sender.currentPage
        let xOffset = CGFloat(page) * menuCollectionView.bounds.width
        menuCollectionView.setContentOffset(CGPoint(x: xOffset, y: 0), animated: true)
        currentIndex = page
    }
}

// MARK: - UICollectionView DataSource & Delegate
extension MenuView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int { 1 }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuData.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuItemCell", for: indexPath) as? MenuItemCell else {
            fatalError("Failed to load cell!")
        }
        let item = menuData.items[indexPath.item]
        cell.configure(with: item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = menuData.items[indexPath.item]
        menuCart.append(MenuItem(name: item.name, imageName: item.imageName, price: item.price))
        print(menuCart)
    }
}

// MARK: - FlowLayout
extension MenuView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let height = collectionView.bounds.height
        return CGSize(width: width / 2, height: height / 2)
    }
}

// MARK: - Custom Paging
extension MenuView: UIScrollViewDelegate {
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                   withVelocity velocity: CGPoint,
                                   targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        guard menuCollectionView.collectionViewLayout is UICollectionViewFlowLayout else {
            return
        }
        
        let pageWidth = menuCollectionView.bounds.width
        let estimatedIndex = scrollView.contentOffset.x / pageWidth
        
        if velocity.x > 0 {
            currentIndex = Int(ceil(estimatedIndex))
        } else if velocity.x < 0 {
            currentIndex = Int(floor(estimatedIndex))
        } else {
            currentIndex = Int(round(estimatedIndex))
        }
        
        let maxIndex = max(0, (menuData.items.count - 1) / 4)
        currentIndex = min(maxIndex, max(0, currentIndex))
        
        let xOffset = CGFloat(currentIndex) * pageWidth
        targetContentOffset.pointee = CGPoint(x: xOffset, y: 0)
        
        pageControl.currentPage = currentIndex
    }
}
#Preview {
    MenuView()
}
