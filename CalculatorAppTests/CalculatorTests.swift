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
    
    func testAdding2FromResetShouldBe2() {
        calculator.reset()
        calculator.performOperation(.add, secondOperand: 2)
        XCTAssertEqual(calculator.getFirstFormattedOperand(), "2")
    }
    
    func testAddingOperandThenSubtractingOperand() {
        calculator.reset()
        calculator.performOperation(.add, secondOperand: 2.0)
        calculator.removeAllOperandsButFirst()
        calculator.performOperation(.subtract, secondOperand: 5)
        XCTAssertEqual(calculator.getFirstFormattedOperand(), "-3")
    }
    
    func testAddingOperandsConsecutively() {
        calculator.reset()
        calculator.performOperation(.add, secondOperand: 3)
        calculator.removeAllOperandsButFirst()
        calculator.performOperation(.add, secondOperand: 5)
        XCTAssertEqual(calculator.getFirstFormattedOperand(), "8")
    }
    
    func testAddingOperandsThenPressingEqualityOperatorMultipleTimes() {
        calculator.reset()
        calculator.performOperation(.add, secondOperand: 3)
        calculator.performOperation(.equals, secondOperand: nil)
        calculator.performOperation(.equals, secondOperand: nil)
        calculator.performOperation(.equals, secondOperand: nil)
        XCTAssertEqual(calculator.getFirstFormattedOperand(), "12")
    }
    
    func testAddingOperandsThenMultiplyingOperands() {
        calculator.reset()
        calculator.performOperation(.add, secondOperand: 3)
        calculator.removeAllOperandsButFirst()
        calculator.performOperation(.add, secondOperand: 5)
        calculator.removeAllOperandsButFirst()
        calculator.performOperation(.multiply, secondOperand: 2)
        XCTAssertEqual(calculator.getFirstFormattedOperand(), "16")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
