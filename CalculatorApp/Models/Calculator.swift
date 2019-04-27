//
//  Calculator.swift
//  CalculatorApp
//
//  Created by Lukas Carvajal on 25.04.19.
//  Copyright © 2019 AppsByLukas. All rights reserved.
//

import Foundation


struct Calculator {
    internal var currentResult: Double
    internal var lastOperator: Operator
    
    init() {
        currentResult = 0
        lastOperator = .none
    }
    
    internal mutating func resetOperands() {
        currentResult = 0
        lastOperator = .none
    }
    
    // FIXME: This messy code should be refactored into multiple functions
    
    internal mutating func calculateAndGetResult(selectedOperator: Operator,
                                                 secondOperand: Double) -> String {
        if lastOperator == .none {
            currentResult = secondOperand
            
            if selectedOperator != .equals {
                lastOperator = selectedOperator
                return "0"
            }
            else {
                if (currentResult - floor(currentResult)) != 0 {
                    return String(currentResult)
                }
                else {
                    let integerResult = Int(currentResult)
                    return String(integerResult)
                }
            }
        }
        else if lastOperator != .equals {
            if let validResult = getResult(secondOperand: secondOperand) {
                currentResult = validResult
                lastOperator = selectedOperator
                
                // Handle decimal formatting
                if (validResult - floor(validResult)) != 0 {
                    return String(validResult)
                }
                else {
                    let integerResult = Int(validResult)
                    return String(integerResult)
                }
            }
            else {
                resetOperands()
                return "Not a number"
            }
        }
        else {
            if let validResult = getResult(secondOperand: secondOperand) {
                currentResult = validResult
                lastOperator = selectedOperator
                
                // Handle decimal formatting
                if (validResult - floor(validResult)) != 0 {
                    return String(validResult)
                }
                else {
                    let integerResult = Int(validResult)
                    return String(integerResult)
                }
            }
            else {
                resetOperands()
                return "Not a number"
            }
        }
    }
    
    internal func getResult(secondOperand: Double) -> Double? {
        let result: Double?
        
        switch lastOperator {
        case .none:
            result = 0
            debugPrint("No operator selected for calculation")
        case .add:
            result = currentResult + secondOperand
        case .subtract:
            result = currentResult - secondOperand
        case .multiply:
            result = currentResult * secondOperand
        case .divide:
            if secondOperand != 0 {
                result = currentResult / secondOperand
            }
            else {
                result = nil
                debugPrint("Attempting to divide by 0")
            }
        case .equals:
            result = 0
        }
        
        return result
    }
}

enum Operator {
    case none
    case add
    case subtract
    case multiply
    case divide
    case equals
}
