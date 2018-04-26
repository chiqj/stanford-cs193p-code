//
//  ViewController.swift
//  Concentration
//
//  Created by 迟庆军 on 2018/4/26.
//

import UIKit

class ViewController: UIViewController {
    
    // 记录翻牌次数的属性
    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    // emoji表情数组
    var emojiChoices = ["👻", "🎃", "🎃", "👻", "🎃", "👻"]
    
    // 显示翻牌次数的label
    @IBOutlet weak var flipCountLabel: UILabel!

    // 所有卡片组成的数组
    @IBOutlet var CardButtons: [UIButton]!

    // 单张卡片的点击时执行这个方法
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = CardButtons.index(of: sender) {
            flipCard(withEmoji: emojiChoices[cardNumber], on: sender)
        }
        else {
            print("Chosen card was not in CardButtons")
        }
    }
    
    // 翻牌操作方法
    func flipCard(withEmoji emoji: String, on btn: UIButton) {
        if btn.currentTitle == emoji {
            btn.setTitle("", for: UIControlState.normal)
            btn.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        }
        else {
            btn.setTitle(emoji, for: UIControlState.normal)
            btn.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }
}

