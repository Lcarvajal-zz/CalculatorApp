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
        XCTAssertEqual(calculator.calculateAndGetResult(selectedOperator: .add, selectedOperand: 5), "0")
    }
    
    func testEqualOperationWhenOperatorIsNotSetAndSecondOperantIsFiveShouldBeFive() {
        calculator.resetOperands()
        XCTAssertEqual(calculator.calculateAndGetResult(selectedOperator: .equals, selectedOperand: 5), "5")
    }
    
    func testEqualOperationWhenOperatorIsSetToaddAndFirstOperandIsSetToFiveAndselectedOperandIsFiveShouldBeTen() {
        calculator.currentResult = 5
        calculator.lastOperator = .add
        XCTAssertEqual(calculator.calculateAndGetResult(selectedOperator: .equals, selectedOperand: 5), "10")
    }
    
    func testAddFiveWhenAnswerIsZeroShouldBeFive() {
        calculator.currentResult = 0
        calculator.lastOperator = .add
        XCTAssertEqual(calculator.calculateAndGetResult(selectedOperator: .add, selectedOperand: 5), "5")
    }
    
    func testSubtractSixWhenAnswerIsTenShouldBeFour() {
        calculator.currentResult = 10
        calculator.lastOperator = .subtract
        XCTAssertEqual(calculator.calculateAndGetResult(selectedOperator: .subtract, selectedOperand: 6), "4")
    }
    
    func testMultiplyEightWhenAnswerIsEightShouldBeSixtyFour() {
        calculator.currentResult = 8
        calculator.lastOperator = .multiply
        XCTAssertEqual(calculator.calculateAndGetResult(selectedOperator: .multiply, selectedOperand: 8), "64")
    }
    
    func testDivideTenWhenAnswerIsOneHundredShouldBeTen() {
        calculator.currentResult = 100
        calculator.lastOperator = .divide
        XCTAssertEqual(calculator.calculateAndGetResult(selectedOperator: .divide, selectedOperand: 10), "10")
    }
    
    func testDivideZeroWhenAnswerIsOneHundredShouldBeNotANumber() {
        calculator.currentResult = 100
        calculator.lastOperator = .divide
        XCTAssertEqual(calculator.calculateAndGetResult(selectedOperator: .divide, selectedOperand: 0), "Not a number")
    }
    
    func testResultsWhenResultsContainDecimalsShouldReturnDecimals() {
        calculator.currentResult = 2.1
        calculator.lastOperator = .add
        XCTAssertEqual(calculator.calculateAndGetResult(selectedOperator: .add, selectedOperand: 2), "4.1")
        
        calculator.currentResult = 2.1
        calculator.lastOperator = .subtract
        XCTAssertEqual(calculator.calculateAndGetResult(selectedOperator: .subtract, selectedOperand: 2), "0.1")
        
        calculator.currentResult = 2.1
        calculator.lastOperator = .multiply
        XCTAssertEqual(calculator.calculateAndGetResult(selectedOperator: .multiply, selectedOperand: 2), "4.2")
        
        calculator.currentResult = 2.1
        calculator.lastOperator = .divide
        XCTAssertEqual(calculator.calculateAndGetResult(selectedOperator: .divide, selectedOperand: 2), "1.05")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
