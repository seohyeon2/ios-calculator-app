//
//  CalculatorItemQueue.swift
//  Calculator
//
//  Created by si won kim on 2021/11/09.
//

import Foundation

protocol CalculateItem {
    
}

extension Int: CalculateItem {
    
}

extension Character: CalculateItem {
    
}

class CalculatorItemQueue<T: CalculateItem> {
    var calculatorItems = [T]()
    var temporaryItems = [T]()
    
    func enqueue(_ item: T) -> [T] {
        calculatorItems.append(item)
        return calculatorItems
    }
    
    func dequeue() -> [T] {
        guard calculatorItems.isEmpty == false else {
            return calculatorItems
        }
        temporaryItems = calculatorItems.reversed()
        temporaryItems.removeLast()
        calculatorItems = temporaryItems.reversed()
        temporaryItems.removeAll()
        
        return calculatorItems
    }
}
