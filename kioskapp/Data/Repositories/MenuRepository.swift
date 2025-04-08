//
//  MenuRepository.swift
//  kioskapp
//
//  Created by tlswo on 4/8/25.
//

import Foundation

class MenuRepository: MenuRepositoryProtocol {
    private var menuItems: MenuData = MenuDataFactory.makeMenuData()

    func getMenuItems() -> MenuData {
        return menuItems
    }
}
