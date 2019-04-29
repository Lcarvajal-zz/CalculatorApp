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

enum Operator {
    case none
    case add
    case subtract
    case multiply
    case divide
}
