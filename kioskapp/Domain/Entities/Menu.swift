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
    let category: String
    let items: [MenuItem]
}

struct MenuItem {
    let item: Item
    var isNew: Bool
}
