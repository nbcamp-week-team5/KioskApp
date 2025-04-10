//  MenuDataFactory.swift
//  kioskapp
//
//  Created by tlswo on 4/8/25.
//

import Foundation

struct MenuDataFactory {
    static func makeMenuData() -> MenuData {
        return MenuData(menu: [
            MenuCategory(category: .burger, items: [
                MenuItem(
                    item: Item(id: UUID(), name: "더블 1955", image: "db1955", price: 9000),
                    isNew: true
                ),
                MenuItem(
                    item: Item(id: UUID(), name: "더블 상하이", image: "dbShanghai", price: 8000),
                    isNew: true
                ),
                MenuItem(
                    item: Item(id: UUID(), name: "쿼터파운더 치즈", image: "quarter", price: 6500),
                    isNew: true
                ),
                MenuItem(item: Item(id: UUID(), name: "1955", image: "1955", price: 5500), isNew: true),
                MenuItem(item: Item(id: UUID(), name: "상하이 버거", image: "shanghai", price: 5000), isNew: true),
                MenuItem(item: Item(id: UUID(), name: "빅맥", image: "bigmac", price: 5000), isNew: true),
                MenuItem(item: Item(id: UUID(), name: "슈슈 버거", image: "shushu", price: 4000), isNew: true),
                MenuItem(item: Item(id: UUID(), name: "맥치킨", image: "chicken", price: 3500), isNew: true),
                MenuItem(item: Item(id: UUID(), name: "불고기 버거", image: "bulgogi", price: 3000), isNew: true),
                MenuItem(item: Item(id: UUID(), name: "치즈 버거", image: "cheese", price: 3000), isNew: true)
            ]),
            MenuCategory(category: .dessert, items: [
                MenuItem(item: Item(id: UUID(), name: "아이스크림콘", image: "cone", price: 1000), isNew: true),
                MenuItem(item: Item(id: UUID(), name: "오레오 맥플러리", image: "flurry", price: 2500), isNew: true),
                MenuItem(item: Item(id: UUID(), name: "바닐라 선데이", image: "sundae", price: 2000), isNew: true)
            ]),
            MenuCategory(category: .drink, items: [
                MenuItem(item: Item(id: UUID(), name: "콜라", image: "cola", price: 1000), isNew: true),
                MenuItem(item: Item(id: UUID(), name: "환타", image: "fanta", price: 1000), isNew: true),
                MenuItem(item: Item(id: UUID(), name: "스프라이트", image: "sprite", price: 1000), isNew: true)
            ]),
            MenuCategory(category: .side, items: [
                MenuItem(
                    item: Item(id: UUID(), name: "치즈스틱", image: "cheeseStick", price: 2000),
                    isNew: true
                ),
                MenuItem(
                    item: Item(id: UUID(), name: "치킨 스낵랩", image: "chickenWrap", price: 2500),
                    isNew: true
                ),
                MenuItem(
                    item: Item(id: UUID(), name: "감자튀김", image: "frenchFries", price: 1000),
                    isNew: true
                ),
                MenuItem(item: Item(id: UUID(), name: "맥너겟", image: "nugget", price: 2500), isNew: true),
                MenuItem(item: Item(id: UUID(), name: "치킨 텐더", image: "tender", price: 2500), isNew: true)
            ])
        ])
    }
}
