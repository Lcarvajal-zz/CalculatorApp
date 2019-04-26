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
    
    func testAddFiveWhenAnswerIsZeroShouldBeFive() {
        calculator.firstOperand = 0
        calculator.secondOperand = 5
        XCTAssertEqual(calculator.sumToDisplay(), "5")
    }
    
    func testSubtractSixWhenAnswerIsTenShouldBeFour() {
        calculator.firstOperand = 10
        calculator.secondOperand = 6
        XCTAssertEqual(calculator.differenceToDisplay(), "4")
    }
    
    func testMultiplyEightWhenAnswerIsEightShouldBeSixtyFour() {
        calculator.firstOperand = 8
        calculator.secondOperand = 8
        XCTAssertEqual(calculator.productToDisplay(), "64")
    }
    
    func testDivideTenWhenAnswerIsOneHundredShouldBeTen() {
        calculator.firstOperand = 100
        calculator.secondOperand = 10
        XCTAssertEqual(calculator.quotientToDisplay(), "10")
    }
    
    func testDivideZeroWhenAnswerIsOneHundredShouldBeNotANumber() {
        calculator.firstOperand = 100
        calculator.secondOperand = 0
        XCTAssertEqual(calculator.quotientToDisplay(), "Not a number")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
