//
//  MenuRepository.swift
//  kioskapp
//
//  Created by tlswo on 4/7/25.
//

protocol MenuRepositoryProtocol {
    func getMenuItems() -> [MenuItem]
}

class MenuRepository: MenuRepositoryProtocol {
    private var menuItems: [MenuItem] = []
    
    func getMenuItems() -> [MenuItem] {
        return menuItems
    }
}
