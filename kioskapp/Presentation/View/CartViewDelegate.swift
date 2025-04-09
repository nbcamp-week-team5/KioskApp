//
//  CartViewDelegate.swift
//  kioskapp
//
//  Created by tlswo on 4/9/25.
//

import UIKit

final class CartViewDelegate: NSObject {
    private let viewModel: KioskMainViewModel
    private weak var cartTableView: UITableView?

    init(viewModel: KioskMainViewModel, cartTableView: UITableView) {
        self.viewModel = viewModel
        self.cartTableView = cartTableView
    }
}

extension CartViewDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}

extension CartViewDelegate: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getCartItems().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CartCell.identifier, for: indexPath) as? CartCell else {
            return UITableViewCell()
        }
        let cartItems = viewModel.getCartItems()
        let cartItem = cartItems[indexPath.row]
        cell.configure(cartItem)
        cell.delegate = self
        return cell
    }
}

extension CartViewDelegate: MenuCartCellDelegate {
    func didTapPlus(on cell: CartCell) {
        guard let indexPath = cartTableView?.indexPath(for: cell) else { return }
        let cartItem = viewModel.getCartItems()[indexPath.row]
        viewModel.increaseCartItemQuantity(cartItem)
    }
    
    func didTapMinus(on cell: CartCell) {
        guard let indexPath = cartTableView?.indexPath(for: cell) else { return }
        let cartItem = viewModel.getCartItems()[indexPath.row]
        if cartItem.amount <= 1 {
            viewModel.deleteCartItem(cartItem)
        } else {
            viewModel.decreaseCartItemQuantity(cartItem)
        }
    }
}
