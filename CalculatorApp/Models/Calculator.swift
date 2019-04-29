//
//  Calculator.swift
//  CalculatorApp
//
//  Created by Lukas Carvajal on 25.04.19.
//  Copyright © 2019 AppsByLukas. All rights reserved.
//

import Foundation


struct Calculator {
    internal var operands: [Double]     // Cache of operands
    internal var lastOperator: Operator?
    
    init() {
        operands = [0]
    }
    
    internal mutating func reset() {
        operands = [0]
        lastOperator = nil
    }
    
    internal mutating func removeAllOperandsButFirst() {
        if operands.count > 0 {
            operands = [operands[0]]
        }
    }
    
    internal mutating func performOperation(_ currentOperator: Operator,
                                   secondOperand: Double?) {
        // Performs operation and sets operand[0] to the result of the operation
        
        var operandToUse: Double
        
        if operands.count > 1 {
            operandToUse = operands.last!
        }
        else if let existingSecondOperand = secondOperand {
            operandToUse = existingSecondOperand
        }
        else {
            return
        }
        
        var operatorToUse: Operator
        
        if let existingLastOperator = lastOperator,
            lastOperator != currentOperator,
            currentOperator == .equals {
            operatorToUse = existingLastOperator
        }
        else {
            operatorToUse = currentOperator
        }
        
        switch operatorToUse {
        case .add:
            operands[0] += operandToUse
        case .subtract:
            operands[0] -= operandToUse
        case .multiply:
            operands[0] *= operandToUse
        case .divide:
            if secondOperand != 0 {
                operands[0] /= operandToUse
            }
        case .equals:
            if let existingLastOperator = lastOperator {
                performOperation(existingLastOperator, secondOperand: secondOperand)
            }
            return
        }
        
        lastOperator = currentOperator
        operands.append(operandToUse)
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
