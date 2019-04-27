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
    internal var secondOperand: Double?
    internal var selectedOperator: Operator
    
    init() {
        firstOperand = 0
        selectedOperator = .none
    }
    
    internal mutating func resetOperands() {
        firstOperand = 0
        secondOperand = nil
        selectedOperator = .none
    }
    
    internal mutating func calculateAndGetResult() -> String? {
        guard let existingSecondOperand = secondOperand else {
            return nil
        }
        
        let result: Double?
        
        switch selectedOperator {
        case .none:
            result = 0
            debugPrint("No operator selected for calculation")
        case .addition:
            result = firstOperand + existingSecondOperand
        case .subtraction:
            result = firstOperand - existingSecondOperand
        case .multiplication:
            result = firstOperand * existingSecondOperand
        case .division:
            if existingSecondOperand != 0 {
                result = firstOperand / existingSecondOperand
            }
            else {
                result = nil
                debugPrint("Attempting to divide by 0")
            }
        }
        
        if let validResult = result {
            firstOperand = validResult
            secondOperand = nil
            
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
