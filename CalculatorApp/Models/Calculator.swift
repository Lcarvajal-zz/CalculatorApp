//
//  Calculator.swift
//  CalculatorApp
//
//  Created by Lukas Carvajal on 25.04.19.
//  Copyright © 2019 AppsByLukas. All rights reserved.
//

import Foundation


struct Calculator {
    internal var firstOperand: Int
    internal var secondOperand: Int
    internal var selectedOperator: Operator
    
    init() {
        firstOperand = 0
        secondOperand = 0
        selectedOperator = .none
    }
    
    internal mutating func resetOperands() {
        firstOperand = 0
        secondOperand = 0
        selectedOperator = .none
    }
    
    internal mutating func calculateAndGetResult() -> String {
        let result: String
        
        switch selectedOperator {
        case .none:
            debugPrint("No operator selected for calculation")
            result = "Invalid"
        case .addition:
            result = String(firstOperand + secondOperand)
        case .subtraction:
            result = String(firstOperand - secondOperand)
        case .multiplication:
            result = String(firstOperand * secondOperand)
        case .division:
            result = String(firstOperand / secondOperand)
        }
        
        return result
    }
    
    // Operations
    
    internal mutating func sumToDisplay() -> String {
        firstOperand += secondOperand
        return "\(firstOperand)"
    }
    
    internal mutating func differenceToDisplay() -> String {
        firstOperand -= secondOperand
        return "\(firstOperand)"
    }
    
    internal mutating func productToDisplay() -> String {
        firstOperand *= secondOperand
        return "\(firstOperand)"
    }
    
    internal mutating func quotientToDisplay() -> String {
        if secondOperand != 0 {
            firstOperand /= secondOperand
            return "\(firstOperand)"
        }
        else {
            firstOperand = 0
            secondOperand = 0
            return "Not a number"
        }
    }
}

enum Operator {
    case none
    case addition
    case subtraction
    case multiplication
    case division
}
