//
//  CartRepository.swift
//  kioskapp
//
//  Created by tlswo on 4/8/25.
//

import Foundation

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

    func deleteCartItem(_ id: UUID) {
        if let index = cartItems.firstIndex(where: { $0.item.id == id }) {
            cartItems.remove(at: index)
        }
    }

    func removeAllCartItems() {
        cartItems.removeAll()
    }

}
