//
//  CartRepository.swift
//  kioskapp
//
//  Created by tlswo on 4/7/25.
//

protocol CartRepositoryProtocol {
    func getCartItems() -> [CartItem]
    func addCartItem(_ cartItem: CartItem)
    func updateCartItem(_ cartItem: CartItem)
    func deleteCartItem(_ cartItem: CartItem)
    func removeAllCartItems()
}

class CartRepository: CartRepositoryProtocol {
    private var cartItems: [CartItem] = []
    
    func getCartItems() -> [CartItem] {
        return cartItems
    }
    
    func addCartItem(_ cartItem: CartItem) {
        cartItems.append(cartItem)
    }
    
    func updateCartItem(_ cartItem: CartItem) {
        if let index = cartItems.firstIndex(where: { $0.item.id == cartItem.item.id }) {
            cartItems[index] = cartItem
        }
    }
    
    func deleteCartItem(_ cartItem: CartItem) {
        if let index = cartItems.firstIndex(where: { $0.item.id == cartItem.item.id }) {
            cartItems.remove(at: index)
        }
    }
    
    func removeAllCartItems() {
        cartItems.removeAll()
    }
    
}
