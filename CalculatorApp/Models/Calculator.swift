//
//  Calculator.swift
//  CalculatorApp
//
//  Created by Lukas Carvajal on 25.04.19.
//  Copyright © 2019 AppsByLukas. All rights reserved.
//

import Foundation


struct Calculator {
    fileprivate var needsToCalculateResult = false
    
    fileprivate var lastOperator: Operator
    fileprivate var currentResult: Double
    fileprivate var operand: Double?
    
    init() {
        currentResult = 0
        operand = nil
        lastOperator = .none
    }
    
    internal mutating func resetOperands() {
        currentResult = 0
        operand = nil
        lastOperator = .none
    }
    
    internal mutating func updateCurrentResult(for outputNumber: Double) {
        if operand == nil {
            operand = outputNumber
        }
        operateOnCurrentResultIfNeeded()
        needsToCalculateResult = false
    }
    
    internal mutating func operate(_ newOperator: Operator, _ outputNumber: Double) {
        if needsToCalculateResult {
            updateCurrentResult(for: outputNumber)
        }
        else {
            operateOnCurrentResultIfNeeded()
            currentResult = outputNumber
            lastOperator = newOperator
            needsToCalculateResult = true
            operand = nil
        }
    }
    
    internal mutating func operateOnCurrentResultIfNeeded() {
        guard let secondOperand = operand else {
            debugPrint("Second operand is nil")
            return
        }
        switch lastOperator {
        case .none:
            debugPrint("No operator selected for calculation")
        case .add:
            currentResult += secondOperand
        case .subtract:
            currentResult -= secondOperand
        case .multiply:
            currentResult *= secondOperand
        case .divide:
            if secondOperand != 0 {
                currentResult = currentResult / secondOperand
            }
            else {
                currentResult = 0
                debugPrint("Attempting to divide by 0")
            }
        }
    }
    
    internal func getFormattedCurrentResult() -> String {
        if (currentResult - floor(currentResult)) != 0 {
            return String(currentResult)
        }
        else {
            let integerResult = Int(currentResult)
            return String(integerResult)
        }
    }
}

enum Operator {
    case none
    case add
    case subtract
    case multiply
    case divide
}
