//
//  MenuViewDelegate.swift
//  kioskapp
//
//  Created by tlswo on 4/9/25.
//

import UIKit

final class MenuViewDelegate: NSObject {
    private let viewModel: KioskMainViewModel
    private let pageControl: UIPageControl
    private let menuCollectionView: UICollectionView
    var menuItems: [MenuItem]
    private(set) var currentIndex: Int = 0

    init(viewModel: KioskMainViewModel,
         pageControl: UIPageControl,
         menuCollectionView: UICollectionView,
         menuItems: [MenuItem]) {
        self.viewModel = viewModel
        self.pageControl = pageControl
        self.menuCollectionView = menuCollectionView
        self.menuItems = menuItems
    }
}

// MARK: - UICollectionView DataSource & Delegate
extension MenuViewDelegate: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int { 1 }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuItemCell", for: indexPath) as? MenuCell else {
            fatalError("Failed to load cell!")
        }
        let item = menuItems[indexPath.item]
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
        
        let menuItem = menuItems[indexPath.item]
        let cartItem = CartItem(item: menuItem.item, amount: 1)
        viewModel.addCartItem(cartItem, by: 1)
    }
}

// MARK: - FlowLayout
extension MenuViewDelegate: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let height = collectionView.bounds.height
        return CGSize(width: width / 2, height: height / 2)
    }
}

// MARK: - Custom Paging
extension MenuViewDelegate: UIScrollViewDelegate {
    
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
        
        let maxIndex = max(0, (menuItems.count - 1) / 4)
        currentIndex = min(maxIndex, max(0, currentIndex))
        
        let xOffset = CGFloat(currentIndex) * pageWidth
        targetContentOffset.pointee = CGPoint(x: xOffset, y: 0)
        
        pageControl.currentPage = currentIndex
    }
}
