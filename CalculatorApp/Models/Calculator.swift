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
        switch lastOperator {
        case .none:
            currentResult = selectedOperand
            return getResultForNoLastOperatorSet(selectedOperator: selectedOperator)
        case .equals:
            if let validResult = getResult(selectedOperand: selectedOperand) {
                currentResult = validResult
                
                return getFormattedCurrentResult()
            }
            else {
                resetOperands()
                return "Not a number"
            }
        default:
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
    
    fileprivate mutating func getResultForNoLastOperatorSet(selectedOperator: Operator) -> String {
        switch selectedOperator {
        case .equals:
            return getFormattedCurrentResult()
        default:
            lastOperator = selectedOperator
            return "0"
        }
    }
    
    // MARK: - Calculations
    
    fileprivate func getResult(selectedOperand: Double) -> Double? {
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
            result = nil
            debugPrint("Attempting to use the equality operator in the incorrect manner")
        }
        
        return result
    }
    
    fileprivate func getFormattedCurrentResult() -> String {
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
