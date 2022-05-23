//
//  Calculator - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {
    
    // TODO: 필요한 프로퍼티 가져오기
    @IBOutlet weak var inputNumberLabel: UILabel!
    @IBOutlet weak var signLabel: UILabel!
    @IBOutlet var numbersButton: [UIButton]!
    
    // TODO: 숫자버튼을 한 곳에서 처리하는 메서드 생성
    // TODO: 어떤 버튼이 들어오는지 구별하기 -> UIOutletCollection, enum 사용
    @IBAction func tapNumbersButton(_ sender: UIButton) {
        if numbersButton.contains(sender) {
            let index = numbersButton.firstIndex(of: sender) ?? 0
            let text = Keypad.matchNumber(index)
        }
    }
    
    // TODO: enum 따로 파일로 빼기
    enum Keypad: Int, CaseIterable {
        case zero = 0
        case one
        case two
        case three
        case four
        case five
        case six
        case seven
        case eight
        case nine
        case doubleZero
        case decimalPoint
        
        static func matchNumber(_ index: Int) -> String {
            switch index {
            case doubleZero.rawValue:
                return "00"
            case decimalPoint.rawValue:
                return "."
            default:
                let result = Keypad.allCases.filter {
                    $0.rawValue == index
                }[0].rawValue
                return String(result)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

