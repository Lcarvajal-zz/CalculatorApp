//
//  Calculator.swift
//  CalculatorApp
//
//  Created by Lukas Carvajal on 25.04.19.
//  Copyright © 2019 AppsByLukas. All rights reserved.
//

import Foundation

enum Operator: String {
    case add = "+"
    case subtract = "-"
    case multiply = "×"
    case divide = "÷"
    case equals = "="
}

struct Calculator {
    internal var repeatPreviousCalculation = false  // Used for tapping equal sign repeatedly
    internal var operands: [Double]     // Cache of operands
    internal var selectedOperator: Operator?
    
    init() {
        operands = []
    }
    
    internal mutating func reset() {
        operands = []
        selectedOperator = nil
    }
    
    internal mutating func gather(number: Double, operatorInput: Operator) {
        if !repeatPreviousCalculation {
            operands.append(number)
            calculateIfEnoughOperandsExist()
            repeatPreviousCalculation = false
        }
        else if operatorInput != .equals {
            operands.append(number)
            repeatPreviousCalculation = false
        }
        else {
            calculateIfEnoughOperandsExist()
        }
        
        if operatorInput != .equals {
            selectedOperator = operatorInput
        }
        else {
            repeatPreviousCalculation = true
        }
    }
    
    fileprivate mutating func calculateIfEnoughOperandsExist() {
        guard operands.count >= 2,
            let lastOperand = operands.last,
            let selectedOperator = selectedOperator else {
                debugPrint("Attempting to calculate with less than two operands or without an operator")
                return
        }
        
        switch selectedOperator {
        case .add:
            operands[0] += lastOperand
        case .subtract:
            operands[0] -= lastOperand
        case .multiply:
            operands[0] *= lastOperand
        case .divide:
            if lastOperand != 0 {
                operands[0] /= lastOperand
            }
        case .equals:
            return
        }
    }
    
    internal func getFirstFormattedOperand() -> String {
        // Format 1.0 as 1 for output
        let firstFormattedOperand = operands[0]
        if (firstFormattedOperand - floor(firstFormattedOperand)) != 0 {
            return String(firstFormattedOperand)
        }
        else {
            let integerResult = Int(firstFormattedOperand)
            return String(integerResult)
        }
    }
}
