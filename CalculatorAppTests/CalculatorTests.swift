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
    
    func testFirstOperationWhenOperatorIsNoneShouldBe0() {
        calculator.resetOperands()
        XCTAssertEqual(calculator.calculateAndGetResult(selectedOperator: .addition, secondOperand: 5), "0")
    }
    
    func testEqualOperationWhenOperatorIsNotSetAndSecondOperantIsFiveShouldBeFive() {
        calculator.resetOperands()
        XCTAssertEqual(calculator.calculateAndGetResult(selectedOperator: .equals, secondOperand: 5), "5")
    }
    
    func testEqualOperationWhenOperatorIsSetToAdditionAndFirstOperandIsSetToFiveAndSecondOperandIsFiveShouldBeTen() {
        calculator.firstOperand = 5
        calculator.currentOperator = .addition
        XCTAssertEqual(calculator.calculateAndGetResult(selectedOperator: .equals, secondOperand: 5), "10")
    }
    
    func testAddFiveWhenAnswerIsZeroShouldBeFive() {
        calculator.firstOperand = 0
        calculator.currentOperator = .addition
        XCTAssertEqual(calculator.calculateAndGetResult(selectedOperator: .addition, secondOperand: 5), "5")
    }
    
    func testSubtractSixWhenAnswerIsTenShouldBeFour() {
        calculator.firstOperand = 10
        calculator.currentOperator = .subtraction
        XCTAssertEqual(calculator.calculateAndGetResult(selectedOperator: .subtraction, secondOperand: 6), "4")
    }
    
    func testMultiplyEightWhenAnswerIsEightShouldBeSixtyFour() {
        calculator.firstOperand = 8
        calculator.currentOperator = .multiplication
        XCTAssertEqual(calculator.calculateAndGetResult(selectedOperator: .multiplication, secondOperand: 8), "64")
    }
    
    func testDivideTenWhenAnswerIsOneHundredShouldBeTen() {
        calculator.firstOperand = 100
        calculator.currentOperator = .division
        XCTAssertEqual(calculator.calculateAndGetResult(selectedOperator: .division, secondOperand: 10), "10")
    }
    
    func testDivideZeroWhenAnswerIsOneHundredShouldBeNotANumber() {
        calculator.firstOperand = 100
        calculator.currentOperator = .division
        XCTAssertEqual(calculator.calculateAndGetResult(selectedOperator: .division, secondOperand: 0), "Not a number")
    }
    
    func testResultsWhenResultsContainDecimalsShouldReturnDecimals() {
        calculator.firstOperand = 2.1
        calculator.currentOperator = .addition
        XCTAssertEqual(calculator.calculateAndGetResult(selectedOperator: .addition, secondOperand: 2), "4.1")
        
        calculator.firstOperand = 2.1
        calculator.currentOperator = .subtraction
        XCTAssertEqual(calculator.calculateAndGetResult(selectedOperator: .subtraction, secondOperand: 2), "0.1")
        
        calculator.firstOperand = 2.1
        calculator.currentOperator = .multiplication
        XCTAssertEqual(calculator.calculateAndGetResult(selectedOperator: .multiplication, secondOperand: 2), "4.2")
        
        calculator.firstOperand = 2.1
        calculator.currentOperator = .division
        XCTAssertEqual(calculator.calculateAndGetResult(selectedOperator: .division, secondOperand: 2), "1.05")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
