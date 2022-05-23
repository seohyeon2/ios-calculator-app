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
    @IBAction func tapNumbersButton(_ sender: UIButton) {
        if numbersButton.contains(sender) {
            let index = numbersButton.firstIndex(of: sender) ?? 0
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

