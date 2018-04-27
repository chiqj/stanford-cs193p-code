//
//  Card.swift
//  Concentration
//
//  Created by 迟庆军 on 2018/4/26.
//

import Foundation

// struct 是数值类型，不是引用类型
struct Card {
    var isFaceUp = false    // 是否正面朝上
    var isMatched = false   // 是否已经匹配
    var identifier: Int     // 匹配标识，只有两张卡片的标识时相同的
    
    // 保证生成的 identifier 唯一使用的标识位
    static var identifierFactory = 0
    
    // 生成唯一的标识，静态方法
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    // 初始化
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
