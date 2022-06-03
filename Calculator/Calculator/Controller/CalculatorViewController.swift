//
//  Calculator - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit
import Foundation

final class CalculatorViewController: UIViewController {
    // MARK: - Properties
    
    @IBOutlet weak var inputNumberLabel: UILabel!
    @IBOutlet weak var inputOperatorLabel: UILabel!
    @IBOutlet weak var divisionButton: UIButton!
    @IBOutlet weak var multiplicationButton: UIButton!
    @IBOutlet weak var subtractionButton: UIButton!
    @IBOutlet weak var additionButton: UIButton!
    @IBOutlet weak var resultButton: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var keypad: [UIButton]!
    
    var calculatorManager = CalculatorManager()
    
    // MARK: - NotificationCenter
    @objc
    func updateInputNumberLabel(notification: NSNotification) {
        guard let object = notification.object as? String else {
            return
        }
        
        inputNumberLabel.text = object
    }
    
    @objc
    func updateInputOperatoreLabel(notification: NSNotification) {
        guard let object = notification.object as? String else {
            return
        }
        
        inputOperatorLabel.text = object
    }
    
    @objc
    func clearStackView(notification: NSNotification) {
        stackView.removeAllArrangedSubview()
    }
    
    @objc
    func updateStackView(notification: NSNotification) {
        guard let object = notification.object as? String else {
            return
        }
        
        if !object.isEmpty {
            stackView.addLabel(arithmetic: object)
            scrollView.setContentOffset(CGPoint(x: 0, y: scrollView.contentSize.height - scrollView.bounds.height + 20), animated: false)
        }
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calculatorManager.resetCalculator()
        calculatorManager.resetInput(inputNumber: true, inputOperator: true)
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateInputOperatoreLabel), name: CalculatorManager.Notification.operandDidChange, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateInputOperatoreLabel), name: CalculatorManager.Notification.operatorDidChange, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateStackView), name: CalculatorManager.Notification.arithmeticDidChange, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(clearStackView), name: CalculatorManager.Notification.removeDidChange, object: nil)
    }
}

extension CalculatorViewController {
    @IBAction private func tapAllClearButton(_ sender: UIButton) {
        calculatorManager.removeAll()
    }
    
    @IBAction private func tapClearEntryButton(_ sender: UIButton) {
        calculatorManager.resetInput(inputNumber: true, inputOperator: false)
    }
    
    private func updateArithmetic() {
        if calculatorManager.isNumberEmpty {
            return
        }
        
        calculatorManager.appendArithmetic()
        calculatorManager.resetInput(inputNumber: true, inputOperator: true)
    }
}

extension CalculatorViewController {
    @IBAction private func tapKeypadButton(_ sender: UIButton) {
        guard let buttonIndex = keypad.firstIndex(of: sender) else { return }
        
        let numberTapped = Keypad.convertNumber(buttonIndex)
        calculatorManager.updateInputNumber(with: numberTapped)
    }
    
    @IBAction private func tapOperatorsButton(_ sender: UIButton) {
        var currentOperator: Character = " "
        switch sender {
        case additionButton:
            currentOperator = Operator.add.symbol
        case subtractionButton:
            currentOperator = Operator.subtract.symbol
        case multiplicationButton:
            currentOperator = Operator.multiply.symbol
        case divisionButton:
            currentOperator = Operator.divide.symbol
        default:
            return
        }
        
        updateArithmetic()
        calculatorManager.updateOperatorInput(operator: String(currentOperator))
    }
    
    @IBAction private func tapResultButton() {
        if calculatorManager.isArithmeticEmpty {
            return
        }
        
        updateArithmetic()
        
        let formula = ExpressionParser.parse(from: calculatorManager.arithmetic)
        var result = 0.0
        
        do {
            result = try formula.result()
            calculatorManager.updateInputNumber(with: String(result))
        } catch CalculatorError.dividedByZero {
            calculatorManager.updateInputNumber(with: CalculatorError.dividedByZero.errorMessage)
        } catch {
            calculatorManager.updateInputNumber(with: CalculatorError.unknownError.errorMessage)
        }
        
        calculatorManager.resetCalculator()
    }
    
    @IBAction private func tapToChangeSignButton(_ sender: UIButton) {
        calculatorManager.convertSign()
    }
}
