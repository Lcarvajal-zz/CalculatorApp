//
//  Calculator.swift
//  CalculatorApp
//
//  Created by Lukas Carvajal on 25.04.19.
//  Copyright © 2019 AppsByLukas. All rights reserved.
//

import Foundation


struct Calculator {
    internal var firstOperand = 0;
    internal var secondOperand = 0;
    
    internal mutating func resetOperands() {
        firstOperand = 0;
        secondOperand = 0;
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
