//
//  KioskMainViewModel.swift
//  kioskapp
//
//  Created by tlswo on 4/7/25.
//

class KioskMainViewModel {
    private let menuUseCase: MenuUseCaseProtocol
    private let cartUseCase: CartUseCaseProtocol

    private var cartItems: [CartItem] = [] {
        didSet {
            onCartItemsUpdated?(cartItems)
        }
    }
    
    private var selectedCategoryIndex: Int = 0 {
        didSet {
            onCategoryUPdated?(selectedCategoryIndex)
        }
    }
    
    var onCartItemsUpdated: (([CartItem]) -> Void)?
    var onCategoryUPdated: ((Int) -> Void)?
    
    init(menuUseCase: MenuUseCaseProtocol,cartUseCase: CartUseCaseProtocol) {
        self.menuUseCase = menuUseCase
        self.cartUseCase = cartUseCase
        fetchCartItems()
    }
    
    func updateCategory(_ category: Int) {
        selectedCategoryIndex = category
    }

    func getCategoryIndex() -> Int {
        selectedCategoryIndex
    }
    
    func getMenuItems() -> MenuData {
        menuUseCase.getMenuItems()
    }

    private func fetchCartItems() {
        cartItems = cartUseCase.getCartItems()
    }

    func getCartItems() -> [CartItem] {
        cartUseCase.getCartItems()
    }

    func addCartItem(_ cartItem: CartItem, by amount: Int) {
        cartUseCase.addCartItem(cartItem, amount: amount)
        fetchCartItems()
    }

    func increaseCartItemQuantity(_ cartItem: CartItem) {
        cartUseCase.addCartItem(cartItem, amount: 1)
        fetchCartItems()
    }

    func deleteCartItem(_ cartItem: CartItem) {
        cartUseCase.deleteCartItem(cartItem)
        fetchCartItems()
    }

    func decreaseCartItemQuantity(_ cartItem: CartItem) {
        cartUseCase.decreaseCartItemQuantity(cartItem)
        fetchCartItems()
    }

    func removeAllCartItems() {
        cartUseCase.removeAllCartItems()
        fetchCartItems()
    }

    func getTotalCartItemPrice() -> Int {
        cartUseCase.getTotalCartItemPrice()
    }
}
