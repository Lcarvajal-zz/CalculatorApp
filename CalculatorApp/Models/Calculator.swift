//
//  Calculator.swift
//  CalculatorApp
//
//  Created by Lukas Carvajal on 25.04.19.
//  Copyright © 2019 AppsByLukas. All rights reserved.
//

import Foundation


struct Calculator {
    internal var firstOperand: Double
    internal var currentOperator: Operator
    
    init() {
        firstOperand = 0
        currentOperator = .none
    }
    
    internal mutating func resetOperands() {
        firstOperand = 0
        currentOperator = .none
    }
    
    // FIXME: This messy code should be refactored into multiple functions
    
    internal mutating func calculateAndGetResult(selectedOperator: Operator,
                                                 secondOperand: Double) -> String {
        if currentOperator == .none {
            firstOperand = secondOperand
            
            if selectedOperator != .equals {
                currentOperator = selectedOperator
                return "0"
            }
            else {
                if (firstOperand - floor(firstOperand)) != 0 {
                    return String(firstOperand)
                }
                else {
                    let integerResult = Int(firstOperand)
                    return String(integerResult)
                }
            }
        }
        else if currentOperator != .equals {
            if let validResult = getResult(secondOperand: secondOperand) {
                firstOperand = validResult
                currentOperator = selectedOperator
                
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
                firstOperand = validResult
                currentOperator = selectedOperator
                
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
        
        switch currentOperator {
        case .none:
            result = 0
            debugPrint("No operator selected for calculation")
        case .addition:
            result = firstOperand + secondOperand
        case .subtraction:
            result = firstOperand - secondOperand
        case .multiplication:
            result = firstOperand * secondOperand
        case .division:
            if secondOperand != 0 {
                result = firstOperand / secondOperand
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
    case addition
    case subtraction
    case multiplication
    case division
    case equals
}
