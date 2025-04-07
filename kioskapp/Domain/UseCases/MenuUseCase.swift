//
//  MenuUseCase.swift
//  kioskapp
//
//  Created by tlswo on 4/7/25.
//

protocol MenuUseCaseProtocol {
    func getMenuItems() -> [MenuItem]
}

class MenuUseCase: MenuUseCaseProtocol {
    private let menuRepository: MenuRepositoryProtocol
    
    init(menuRepository: MenuRepositoryProtocol) {
        self.menuRepository = menuRepository
    }
    
    func getMenuItems() -> [MenuItem] {
        return menuRepository.getMenuItems()
    }
}
