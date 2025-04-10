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
    var menuItems: [MenuItem]
    
    var currentIndex: Int = 0
    
    private let pageControl = UIPageControl()
    
    private let menuCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout().then {
            $0.scrollDirection = .horizontal
            $0.minimumLineSpacing = 0
            $0.minimumInteritemSpacing = 0
        }
    )
    
    private let viewModel: KioskMainViewModel
    
    private var delegate: MenuViewDelegate
    
    init(
        viewModel: KioskMainViewModel,
        menuItems: [MenuItem],
        cartView: CartView
    ) {
        self.viewModel = viewModel
        self.menuItems = menuItems
        self.delegate = MenuViewDelegate(
            viewModel: viewModel,
            pageControl: pageControl,
            menuCollectionView: menuCollectionView,
            menuItems: menuItems,
            cartView: cartView
        )
        super.init(frame: .zero)
        setStyle()
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setStyle() {
        menuCollectionView.do {
            $0.dataSource = delegate
            $0.delegate = delegate
            $0.showsHorizontalScrollIndicator = false
            $0.register(MenuCell.self, forCellWithReuseIdentifier: "MenuItemCell")
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
        
        pageControl.numberOfPages = Int(ceil(Double(menuItems.count) / 4.0))
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

extension MenuView {
    func reloadMenu() {
        let newItems = viewModel.getMenuItems().menu[viewModel.getCategoryIndex()].items
        self.menuItems = newItems
        
        delegate.menuItems = newItems
        
        pageControl.numberOfPages = Int(ceil(Double(newItems.count)) / 4.0)
        pageControl.currentPage = 0
        
        menuCollectionView.setContentOffset(.zero, animated: false)
        menuCollectionView.reloadData()
        
        self.layoutIfNeeded()
    }
}
