//
//  Calculator - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {
    
    // TODO: 필요한 프로퍼티 가져오기
    @IBOutlet weak var inputNumberLabel: UILabel!
    @IBOutlet weak var operatorLabel: UILabel!
    @IBOutlet var numbersButton: [UIButton]!
    @IBOutlet weak var additionButton: UIButton!
    @IBOutlet weak var subtractionButton: UIButton!
    @IBOutlet weak var multiplicationButton: UIButton!
    @IBOutlet weak var divisionButton: UIButton!
    @IBOutlet weak var resultButton: UIButton!
    
    private var numbers = ""
    
    // TODO: 숫자버튼을 한 곳에서 처리하는 메서드 생성
    // TODO: 어떤 버튼이 들어오는지 구별하기 -> UIOutletCollection, enum 사용
    // TODO: 연산자 버튼을 누르기 전까지 숫자가 변경되게 하기
    @IBAction func tapNumbersButton(_ sender: UIButton) {
        if numbersButton.contains(sender) {
            let index = numbersButton.firstIndex(of: sender) ?? 0
            let newInputNumbers = Keypad.matchNumber(index)
            checkInputNumbers(text: newInputNumbers)
            updateLable(text: numbers)
        }
    }
    
    // TODO: 빈 상태에서 00이 못 붙게 하기, 빈 상태에서 . 누르면 0.으로 바뀌게 하기, 0이 첫번째일 때 숫자가 오면 숫자가 첫번째로 되게 하기
    func checkInputNumbers(text: String) {
        if numbers.contains(".") && text == "." {
            return
        }
        
        if (numbers == "" || numbers == "0") && (text == "0" || text == "00") {
            numbers = "0"
        } else if numbers == "" && text == "." {
            numbers = "0."
        } else if numbers == "0" && text != "."{
            numbers = text
        } else {
            numbers += text
        }
    }
    
    // TODO: 누른 숫자 번호 보여주기
    func updateLable(text: String) {
        DispatchQueue.main.async {
            self.inputNumberLabel.text = text
        }
    }
    
    // TODO: 연산자버튼을 한 곳에서 처리하는 메서드 생성
    // TODO: 어떤 연산자 버튼이 들어오는지 구별하기
    @IBAction func tapOperatorsButton(_ sender: UIButton) {
        switch sender {
        case additionButton:
            operatorLabel.text = String(Operator.add.rawValue)
        case subtractionButton:
            operatorLabel.text = String(Operator.subtract.rawValue)
        case multiplicationButton:
            operatorLabel.text = String(Operator.multiply.rawValue)
        case divisionButton:
            operatorLabel.text = String(Operator.divide.rawValue)
        default:
            return
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

