//
//  Concentration.swift
//  Concentration
//
//  Created by 迟庆军 on 2018/4/26.
//

import Foundation

// class 是引用类型，不是数值类型
class Concentration {
    
    // 所有卡片组成的数组，通过数组索引与 Controler 的 cardButtons 索引相对应
    var cards = [Card]()
    
    // 记录已翻开的卡片，可选变量，不初始化时则初始值为 nil
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    // 选择（翻开）卡片操作
    func chooseCard(at index: Int) {
        // 如果点击的是已经配对的变透明了的卡片，就不做任何处理
        if !cards[index].isMatched {
            // 如果当前卡片与已经被翻过的卡片不是同一张
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // 如果卡片可以配对，把两张卡的 isMatched 设置为 true
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                // 无论能否配对，都把当前卡片翻到正面，清除已翻开的卡片的标识位
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            }
            else {
                // 如果是新翻开的卡片，那么把这张卡片设置为 正面，其他都翻到反面
                // 配对的卡片，在更新时，会被设置为透明背景色
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    // 初始化方法
    init(numberOfPairsOfCards: Int) {
        // 生成卡片，每两张卡片拥有相同的标识
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        // TODO: 洗牌
    }
}
