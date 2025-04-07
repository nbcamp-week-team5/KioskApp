//
//  Menu.swift
//  kioskapp
//
//  Created by 정근호 on 4/7/25.
//

import Foundation

struct MenuData {
    let menu: [MenuCategory]
}

struct MenuCategory {
    let category: String
    let items: [MenuItem]
}

struct MenuItem {
    let name: String
    let imageName: String
    let price: Int
}

extension MenuData {
    static let sampleData: MenuData = MenuData(menu: [
        MenuCategory(category: "burger", items: [
            MenuItem(name: "더블 1955", imageName: "db1955", price: 9000),
            MenuItem(name: "더블 상하이", imageName: "dbShanghai", price: 8000),
            MenuItem(name: "쿼터파운더 치즈", imageName: "quarter", price: 6500),
            MenuItem(name: "1955", imageName: "1955", price: 5500),
            MenuItem(name: "상하이 버거", imageName: "shanghai", price: 5000),
            MenuItem(name: "빅맥", imageName: "bigmac", price: 5000),
            MenuItem(name: "슈슈 버거", imageName: "shushu", price: 4000),
            MenuItem(name: "맥치킨", imageName: "chicken", price: 3500),
            MenuItem(name: "불고기 버거", imageName: "bulgogi", price: 3000),
            MenuItem(name: "치즈 버거", imageName: "cheese", price: 3000)
        ]),
        MenuCategory(category: "dessert", items: [
            MenuItem(name: "아이스크림콘", imageName: "cone", price: 1000),
            MenuItem(name: "오레오 맥플러리", imageName: "flurry", price: 2500),
            MenuItem(name: "바닐라 선데이", imageName: "sundae", price: 2000)
        ]),
        MenuCategory(category: "drinks", items: [
            MenuItem(name: "콜라", imageName: "cola", price: 1000),
            MenuItem(name: "환타", imageName: "fanta", price: 1000),
            MenuItem(name: "스프라이트", imageName: "sprite", price: 1000)
        ]),
        MenuCategory(category: "side", items: [
            MenuItem(name: "치즈스틱", imageName: "cheeseStick", price: 2000),
            MenuItem(name: "치킨 스낵랩", imageName: "chickenWrap", price: 2500),
            MenuItem(name: "감자튀김", imageName: "frenchFries", price: 1000),
            MenuItem(name: "맥너겟", imageName: "nugget", price: 2500),
            MenuItem(name: "치킨 텐더", imageName: "tender", price: 2500)
        ])
    ])
}
