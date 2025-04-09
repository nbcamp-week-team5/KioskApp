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
    
    let menuData = MenuDataFactory.makeMenuData().menu[0]
    
    var currentIndex: Int = 0
    
    private let viewModel: KioskMainViewModel
    private let pageControl = UIPageControl()
    private weak var menuCartView: MenuCartView?
    
    private let menuCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = 0
        $0.minimumInteritemSpacing = 0
    })
    
    init(frame: CGRect, viewModel: KioskMainViewModel, menuCartView: MenuCartView) {
        self.viewModel = viewModel
        self.menuCartView = menuCartView
        super.init(frame: frame)
        setStyle()
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setStyle() {
        menuCollectionView.do {
            $0.dataSource = self
            $0.delegate = self
            $0.showsHorizontalScrollIndicator = false
            $0.register(MenuItemCell.self, forCellWithReuseIdentifier: "MenuItemCell")
            $0.layer.borderColor = UIColor.lightGray.cgColor
            $0.layer.borderWidth = 1.0
            $0.layer.cornerRadius = 20
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
            $0.edges.equalToSuperview().inset(18)
        }
        
        pageControl.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(24)
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
        let cell = collectionView.cellForItem(at: indexPath)
        
        // 클릭 애니메이션
        UIView.animate(withDuration: 0.1,
                       animations: {
            cell?.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }, completion: { _ in
            UIView.animate(withDuration: 0.1) {
                cell?.transform = CGAffineTransform.identity
            }
        })
        
        let item = menuData.items[indexPath.item]
        let cartItem = CartItem(item: item.item, amount: 1)
        viewModel.addCartItem(cartItem, by: 1)
        menuCartView?.reloadCart(cartItem)
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
