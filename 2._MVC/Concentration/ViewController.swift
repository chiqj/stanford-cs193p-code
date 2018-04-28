//
//  ViewController.swift
//  Concentration
//
//  Created by 迟庆军 on 2018/4/26.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count+1) / 2)
    
    // 记录翻牌次数的属性
    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    
    // 显示翻牌次数的label
    @IBOutlet weak var flipCountLabel: UILabel!

    // 所有卡片组成的数组
    @IBOutlet var cardButtons: [UIButton]!

    // 单张卡片的点击时执行这个方法
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender) {
            // 交给 Model 处理
            game.chooseCard(at: cardNumber)
            // 翻牌后游戏状态可能会发生改变，需要从 Model 中更新 View
            updateViewFromModel()
        }
        else {
            print("Chosen card was not in CardButtons")
        }
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let btn = cardButtons[index]
            let card = game.cards[index]
            // 如果正面朝上，即使配对了，也要让用户看到两个配对了
            // 即下次点击其他卡片时再更新状态（变透明）
            if card.isFaceUp {
                btn.setTitle(emoji(for: card), for: UIControlState.normal)
                btn.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }
            // 如果反面朝上，如果已经配对，背景颜色变透明；否则，背景颜色为橙色
            else {
                btn.setTitle("", for: UIControlState.normal)
                btn.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    
    // emoji表情数组
    var emojiChoices = ["🍉", "🥕", "🍓", "🥝", "🥥", "🍒", "🍌", "🍑"]
    
    var emoji = [Int: String]()

    func emoji(for card: Card) -> String {
        // 如果 emoji 字典中没有这个 key，且 emojiChoices 中还有值
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            // 从 emojiChoices 中随机取一个放到 emoji 字典中，并从 emojiChoices 中删除
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        // emoji[card.identifier] 是一个可选类型，因为 card.identifier 可能不存在
        // 当值为 nil 时，使用 "??" 语法返回设定值
        return emoji[card.identifier] ?? "❓"
    }
}

