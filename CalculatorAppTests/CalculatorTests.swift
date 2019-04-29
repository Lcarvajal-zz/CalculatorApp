//
//  CalculatorTests.swift
//  CalculatorAppTests
//
//  Created by Lukas Carvajal on 26.04.19.
//  Copyright © 2019 AppsByLukas. All rights reserved.
//

import XCTest
@testable import CalculatorApp

class CalculatorTests: XCTestCase {

    var calculator = Calculator()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testConsecutiveOperations() {
        calculator.reset()
        calculator.operands.append(3)
        calculator.performOperation(.add, secondOperand: 2)
        calculator.performOperation(.subtract, secondOperand: 5)
        calculator.performOperation(.multiply, secondOperand: 6)
        calculator.performOperation(.divide, secondOperand: -2)
        XCTAssertEqual(calculator.getFirstFormattedOperand(), "9")
    }
    

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
