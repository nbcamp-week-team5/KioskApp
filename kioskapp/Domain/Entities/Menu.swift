//
//  MenuItem.swift
//  kioskapp
//
//  Created by tlswo on 4/7/25.
//

struct MenuData {
    let menu: [MenuCategory]
}

struct MenuCategory {
    let category: Category
    let items: [MenuItem]
}

struct MenuItem {
    let item: Item
    var isNew: Bool
}

enum Category: Equatable, CaseIterable {
    case burger
    case dessert
    case drink
    case side
    
    var title: String {
        switch self {
        case .burger: return "버거"
        case .dessert: return "디저트"
        case .drink: return "음료"
        case .side: return "사이드"
        }
    }
}
