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
                                                 selectedOperand: Double) -> String {
        
        if lastOperator == .none {
            currentResult = selectedOperand
            
            if selectedOperator != .equals {
                lastOperator = selectedOperator
                return "0"
            }
            else {
                return getFormattedCurrentResult()
            }
        }
        else if lastOperator != .equals {
            if let validResult = getResult(selectedOperand: selectedOperand) {
                currentResult = validResult
                lastOperator = selectedOperator
                
                return getFormattedCurrentResult()
            }
            else {
                resetOperands()
                return "Not a number"
            }
        }
        else {
            if let validResult = getResult(selectedOperand: selectedOperand) {
                currentResult = validResult
                lastOperator = selectedOperator
                
                return getFormattedCurrentResult()
            }
            else {
                resetOperands()
                return "Not a number"
            }
        }
    }
    
    internal func getResult(selectedOperand: Double) -> Double? {
        let result: Double?
        
        switch lastOperator {
        case .none:
            result = 0
            debugPrint("No operator selected for calculation")
        case .add:
            result = currentResult + selectedOperand
        case .subtract:
            result = currentResult - selectedOperand
        case .multiply:
            result = currentResult * selectedOperand
        case .divide:
            if selectedOperand != 0 {
                result = currentResult / selectedOperand
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
    
    private func getFormattedCurrentResult() -> String {
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
    case equals
}
