//
//  Calculator.swift
//  CalculatorApp
//
//  Created by Lukas Carvajal on 25.04.19.
//  Copyright © 2019 AppsByLukas. All rights reserved.
//

import Foundation


struct Calculator {
    internal var repeatPreviousCalculation = false
    internal var operands: [Double]     // Cache of operands
    internal var selectedOperator: Operator?
    
    
    internal var lastOperator: Operator?
    
    init() {
        operands = []
    }
    
    internal mutating func reset() {
        operands = []
        lastOperator = nil
    }
    
    internal mutating func gather(number: Double, operatorInput: Operator) {
        if operatorInput != .equals || !repeatPreviousCalculation {
            operands.append(number)
            
            if !repeatPreviousCalculation {
                calculateIfEnoughOperandsExist()
            }
            
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

enum Operator: String {
    case add = "+"
    case subtract = "-"
    case multiply = "×"
    case divide = "÷"
    case equals = "="
}
