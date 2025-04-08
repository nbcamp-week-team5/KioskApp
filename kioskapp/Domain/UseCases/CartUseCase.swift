//
//  CartUseCase.swift
//  kioskapp
//
//  Created by tlswo on 4/7/25.
//

protocol CartUseCaseProtocol {
    func getCartItems() -> [CartItem]
    func addCartItem(_ cartItem: CartItem, amount: Int)
    func deleteCartItem(_ cartItem: CartItem)
    func decreaseCartItemQuantity(_ cartItem: CartItem)
    func removeAllCartItems()
    func getTotalCartItemPrice() -> Int
}

class CartUseCase: CartUseCaseProtocol {
    private let cartRepository: CartRepositoryProtocol

    init(cartRepository: CartRepositoryProtocol) {
        self.cartRepository = cartRepository
    }

    func getCartItems() -> [CartItem] {
        cartRepository.getCartItems()
    }

    func addCartItem(_ cartItem: CartItem, amount: Int) {
        let cartItems = cartRepository.getCartItems()
        if let existingItem = cartItems.first(where: { $0.item.id == cartItem.item.id }) {
            let updatedCartItem = CartItem(item: existingItem.item, amount: existingItem.amount + amount)
            cartRepository.updateCartItem(updatedCartItem)
        } else {
            cartRepository.addCartItem(cartItem)
        }
    }

    func decreaseCartItemQuantity(_ cartItem: CartItem) {
        let cartItems = cartRepository.getCartItems()
        guard let existingItem = cartItems.first(where: { $0.item.id == cartItem.item.id }) else {
            return
        }
        if existingItem.amount > 1 {
            let updatedItem = CartItem(item: existingItem.item, amount: existingItem.amount - 1)
            cartRepository.updateCartItem(updatedItem)
        } else {
            cartRepository.deleteCartItem(existingItem.item.id)
        }
    }

    func deleteCartItem(_ cartItem: CartItem) {
        let cartItems = cartRepository.getCartItems()
        guard let existingItem = cartItems.first(where: { $0.item.id == cartItem.item.id }) else {
            return
        }
        cartRepository.deleteCartItem(existingItem.item.id)
    }

    func removeAllCartItems() {
        cartRepository.removeAllCartItems()
    }

    func getTotalCartItemPrice() -> Int {
        let cartItems = cartRepository.getCartItems()
        return cartItems.map { $0.item.price * $0.amount }.reduce(0, +)
    }
}
