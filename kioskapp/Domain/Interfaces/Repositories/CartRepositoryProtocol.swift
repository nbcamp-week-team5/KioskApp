//
//  CartRepository.swift
//  kioskapp
//
//  Created by tlswo on 4/7/25.
//

import Foundation

protocol CartRepositoryProtocol {
    func getCartItems() -> [CartItem]
    func addCartItem(_ cartItem: CartItem)
    func updateCartItem(_ cartItem: CartItem)
    func deleteCartItem(_ id: UUID)
    func removeAllCartItems()
}
