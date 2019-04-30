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
        calculator.reset()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testAddingTwoPlusTwoShouldBeFour() {
        calculator.gather(number: 2, operatorInput: .add)
        calculator.gather(number: 2, operatorInput: .equals)
        XCTAssertEqual(calculator.getFirstFormattedOperand(), "4")
    }
    
    func testAddingOperandThenSubtractingOperand() {
        calculator.gather(number: 0, operatorInput: .add)
        calculator.gather(number: 2, operatorInput: .subtract)
        calculator.gather(number: 5, operatorInput: .equals)
        XCTAssertEqual(calculator.getFirstFormattedOperand(), "-3")
    }

    func testAddingOperandsThenPressingEqualSignMultipleTimes() {
        calculator.gather(number: 0, operatorInput: .add)
        calculator.gather(number: 3, operatorInput: .equals)
        // Number does not matter in the three methods below
        calculator.gather(number: 1, operatorInput: .equals)
        calculator.gather(number: 1, operatorInput: .equals)
        calculator.gather(number: 1, operatorInput: .equals)
        XCTAssertEqual(calculator.getFirstFormattedOperand(), "12")
    }
    
    func testAddingOperandsThenMultiplyingOperands() {
        calculator.gather(number: 0, operatorInput: .add)
        calculator.gather(number: 3, operatorInput: .add)
        calculator.gather(number: 5, operatorInput: .multiply)
        calculator.gather(number: 2, operatorInput: .equals)
        XCTAssertEqual(calculator.getFirstFormattedOperand(), "16")
    }
    
    func testOperatingAfterPerformingAnOperationAndUsingEqualSign() {
        calculator.gather(number: 1, operatorInput: .add)
        calculator.gather(number: 2, operatorInput: .subtract)
        calculator.gather(number: 4, operatorInput: .equals)
        calculator.gather(number: -2, operatorInput: .multiply)
        calculator.gather(number: 0, operatorInput: .equals)
        XCTAssertEqual(calculator.getFirstFormattedOperand(), "2")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
