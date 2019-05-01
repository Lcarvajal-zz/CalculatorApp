//
//  Constant.swift
//  CalculatorApp
//
//  Created by Lukas Carvajal on 01.05.19.
//  Copyright © 2019 AppsByLukas. All rights reserved.
//

import Foundation

struct Constant {
    static let calculatorButtons = [
        Sign.clear, Sign.plusMinus, Sign.percentage, Sign.division,
        "7", "8", "9", Sign.multiplication,
        "4", "5", "6", Sign.subtraction,
        "1", "2", "3", Sign.addition,
        "0", Sign.decimal, Sign.equal
    ]
    
    struct Sign {
        static let clear = "C"
        static let plusMinus = "+/-"
        static let percentage = "%"
        static let equal = "="
        static let decimal = "."
        
        static let division = "÷"
        static let multiplication = "×"
        static let subtraction = "-"
        static let addition = "+"
    }
}
