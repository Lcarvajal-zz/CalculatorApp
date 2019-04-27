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
    
    func testCurrentResultWhenOperationsArePerformedConsecutively() {
        calculator.resetOperands()
        calculator.operate(.add, 3)
        calculator.operate(.add, 6)
        XCTAssertEqual(calculator.getFormattedCurrentResult(), "9")
    }
    
    func testCurrentResultWhenOneOperationIsPerformed() {
        calculator.resetOperands()
        calculator.operate(.add, 3)
        calculator.updateCurrentResult(for: 0)
        XCTAssertEqual(calculator.getFormattedCurrentResult(), "3")
    }
    
    func testCurrentResultWhenMixingConsecutiveOperationsAndUpdatingCurrentResult() {
        calculator.resetOperands()
        calculator.operate(.add, 3)
        calculator.updateCurrentResult(for: 0)
        calculator.operate(.add, 6)
        calculator.operate(.add, 15)
        calculator.updateCurrentResult(for: 0)
        XCTAssertEqual(calculator.getFormattedCurrentResult(), "24")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
