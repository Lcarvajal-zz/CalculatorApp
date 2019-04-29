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
                                   secondOperand: Double) -> Double {
        switch currentOperator {
        case .add:
            return firstOperand + secondOperand
        case .subtract:
            return firstOperand - secondOperand
        case .multiply:
            return firstOperand * secondOperand
        case .divide:
            if secondOperand != 0 {
                return firstOperand / secondOperand
            }
            else {
                return firstOperand
            }
        default:
            debugPrint("WARNING - attempting to operate with an invalid operator")
            return 0
        }
    }
    
    internal func getFormattedOutput(for number: Double) -> String {
        if (number - floor(number)) != 0 {
            return String(number)
        }
        else {
            let integerResult = Int(number)
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
