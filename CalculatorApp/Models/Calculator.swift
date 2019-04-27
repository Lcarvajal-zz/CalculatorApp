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
        let result: Int?
        
        switch selectedOperator {
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
        }
        
        if let validResult = result {
            firstOperand = validResult
            secondOperand = 0
            return String(validResult)
        }
        else {
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
