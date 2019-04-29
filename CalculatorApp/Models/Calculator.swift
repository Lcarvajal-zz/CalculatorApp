//
//  Calculator.swift
//  CalculatorApp
//
//  Created by Lukas Carvajal on 25.04.19.
//  Copyright © 2019 AppsByLukas. All rights reserved.
//

import Foundation


struct Calculator {
    internal var operands: [Double]
    // FIXME: Operand and operator names are too similar and confusing
    internal var lastOperand: Double?
    internal var lastOperator: Operator?
    internal var replaceOutput: Bool
    
    init() {
        operands = []
        replaceOutput = false
    }
    
    internal mutating func reset() {
        operands = []
        lastOperand = nil
        lastOperator = nil
        replaceOutput = false
    }
    
    internal mutating func performOperation(_ currentOperator: Operator,
                                   firstOperand: Double,
                                   secondOperand: Double) {
        switch currentOperator {
        case .add:
            operands[0] = firstOperand + secondOperand
        case .subtract:
            operands[0] = firstOperand - secondOperand
        case .multiply:
            operands[0] = firstOperand * secondOperand
        case .divide:
            if secondOperand != 0 {
                operands[0] = firstOperand / secondOperand
            }
            else {
                operands[0] = firstOperand
            }
        default:
            debugPrint("WARNING - attempting to operate with an invalid operator")
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
