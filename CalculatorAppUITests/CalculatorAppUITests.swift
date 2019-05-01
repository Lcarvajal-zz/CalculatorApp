//
//  CalculatorAppUITests.swift
//  CalculatorAppUITests
//
//  Created by Lukas Carvajal on 25.04.19.
//  Copyright © 2019 AppsByLukas. All rights reserved.
//

import XCTest
//@testable import CalculatorApp

enum Constant {
    static let outputLabel = "OutputLabel"
}

class CalculatorAppUITests: XCTestCase {
    
    override func setUp() {
        continueAfterFailure = false
        XCUIApplication().launch()
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testTappingDecimalWhenAppStartsShouldAddNumbersAfterZeroPoint() {
        let app = XCUIApplication()
        
        let collectionViewsQuery = app.collectionViews
        collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["."]/*[[".cells.buttons[\".\"]",".buttons[\".\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["1"]/*[[".cells.buttons[\"1\"]",".buttons[\"1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["5"]/*[[".cells.buttons[\"5\"]",".buttons[\"5\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["9"]/*[[".cells.buttons[\"9\"]",".buttons[\"9\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()

        XCTAssertEqual(app.staticTexts[Constant.outputLabel].label, "0.159")
    }
    
    func testTappingDecimalWhenOutputIsFiveShouldAddNumbersToEnd() {
        let app = XCUIApplication()
        
        let collectionViewsQuery = app.collectionViews
        let button = collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["5"]/*[[".cells.buttons[\"5\"]",".buttons[\"5\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        button.tap()
        collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["."]/*[[".cells.buttons[\".\"]",".buttons[\".\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["4"]/*[[".cells.buttons[\"4\"]",".buttons[\"4\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        button.tap()
        collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["6"]/*[[".cells.buttons[\"6\"]",".buttons[\"6\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        XCTAssertEqual(app.staticTexts[Constant.outputLabel].label, "5.456")
    }
    
    func testAddingOneTwoThreeShouldShowSix() {
        let app = XCUIApplication()
        
        let collectionViewsQuery = app.collectionViews
        collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["1"]/*[[".cells.buttons[\"1\"]",".buttons[\"1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let button = collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["+"]/*[[".cells.buttons[\"+\"]",".buttons[\"+\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        button.tap()
        collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["2"]/*[[".cells.buttons[\"2\"]",".buttons[\"2\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        button.tap()
        collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["3"]/*[[".cells.buttons[\"3\"]",".buttons[\"3\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["="]/*[[".cells.buttons[\"=\"]",".buttons[\"=\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        XCTAssertEqual(app.staticTexts[Constant.outputLabel].label, "6")
    }
    
    
    func testAddingThreeAndPressingTheEqualSignThreeTimes() {
        let app = XCUIApplication()
        
        let collectionViewsQuery = app.collectionViews
        collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["+"]/*[[".cells.buttons[\"+\"]",".buttons[\"+\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["3"]/*[[".cells.buttons[\"3\"]",".buttons[\"3\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let button = collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["="]/*[[".cells.buttons[\"=\"]",".buttons[\"=\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        button.tap()
        button.tap()
        button.tap()
        
        XCTAssertEqual(app.staticTexts[Constant.outputLabel].label, "9")
    }
    
    func testAddingSubtractingAndMultiplyingThenPressEqualSign() {
        let app = XCUIApplication()
        
        let collectionViewsQuery = app.collectionViews
        collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["5"]/*[[".cells.buttons[\"5\"]",".buttons[\"5\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["+"]/*[[".cells.buttons[\"+\"]",".buttons[\"+\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["3"]/*[[".cells.buttons[\"3\"]",".buttons[\"3\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["-"]/*[[".cells.buttons[\"-\"]",".buttons[\"-\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["1"]/*[[".cells.buttons[\"1\"]",".buttons[\"1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["×"]/*[[".cells.buttons[\"×\"]",".buttons[\"×\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["7"]/*[[".cells.buttons[\"7\"]",".buttons[\"7\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["="]/*[[".cells.buttons[\"=\"]",".buttons[\"=\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        XCTAssertEqual(app.staticTexts[Constant.outputLabel].label, "49")
    }
    
    func testTappingPlusMinusSignWhenOutputLabelIsZeroShouldStayZero() {
        let app = XCUIApplication()
        
        let collectionViewsQuery = app.collectionViews
        collectionViewsQuery.buttons["0"].tap()
        collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["+/-"]/*[[".cells.buttons[\"+\/-\"]",".buttons[\"+\/-\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        XCTAssertEqual(app.staticTexts[Constant.outputLabel].label, "0")
    }
    
    func testTappingPlusMinusSignWhenOutputLabelIsPositiveShouldTurnNegative() {
        let app = XCUIApplication()
        
        let collectionViewsQuery = app.collectionViews
        collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["5"]/*[[".cells.buttons[\"5\"]",".buttons[\"5\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["+/-"]/*[[".cells.buttons[\"+\/-\"]",".buttons[\"+\/-\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        XCTAssertEqual(app.staticTexts[Constant.outputLabel].label, "-5")
       
    }
    
    func testTappingPlusMinusSignWhenOutputLabelIsNegativeShouldTurnPositive() {
        let app = XCUIApplication()
        
        let collectionViewsQuery = app.collectionViews
        collectionViewsQuery.buttons["0"].tap()
        collectionViewsQuery.buttons["-"].tap()
        collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["5"]/*[[".cells.buttons[\"5\"]",".buttons[\"5\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        collectionViewsQuery.buttons["="].tap()
        collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["+/-"]/*[[".cells.buttons[\"+\/-\"]",".buttons[\"+\/-\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        XCTAssertEqual(app.staticTexts[Constant.outputLabel].label, "5")
    }
    
    func testTappingPlusMinusSignWhenEqualSignWasPressedShouldUpdateOperand() {
        let app = XCUIApplication()
        
        let collectionViewsQuery = app.collectionViews
        collectionViewsQuery.buttons["0"].tap()
        collectionViewsQuery.buttons["-"].tap()
        collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["5"]/*[[".cells.buttons[\"5\"]",".buttons[\"5\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        collectionViewsQuery.buttons["="].tap()
        collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["+/-"]/*[[".cells.buttons[\"+\/-\"]",".buttons[\"+\/-\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["×"]/*[[".cells.buttons[\"×\"]",".buttons[\"×\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        collectionViewsQuery.buttons["2"].tap()
        collectionViewsQuery.buttons["="].tap()
        
        XCTAssertEqual(app.staticTexts[Constant.outputLabel].label, "10")
    }
    
    func testTappingMultipleOperatorsConsecutivelyShouldNotPerformMultipleCalculations() {
        let app = XCUIApplication()

        let collectionViewsQuery = app.collectionViews
        collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["5"]/*[[".cells.buttons[\"5\"]",".buttons[\"5\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["+"]/*[[".cells.buttons[\"+\"]",".buttons[\"+\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["-"]/*[[".cells.buttons[\"-\"]",".buttons[\"-\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["×"]/*[[".cells.buttons[\"×\"]",".buttons[\"×\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["÷"]/*[[".cells.buttons[\"÷\"]",".buttons[\"÷\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()

        XCTAssertEqual(app.staticTexts[Constant.outputLabel].label, "5")
    }
    
    func testSelectingOperatorButtonShouldDeselectOtherOperatorButtons() {
        let app = XCUIApplication()
        
        let collectionViewsQuery = app.collectionViews
        collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["5"]/*[[".cells.buttons[\"5\"]",".buttons[\"5\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["+"]/*[[".cells.buttons[\"+\"]",".buttons[\"+\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        collectionViewsQuery.buttons["-"].tap()
        collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["×"]/*[[".cells.buttons[\"×\"]",".buttons[\"×\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["÷"]/*[[".cells.buttons[\"÷\"]",".buttons[\"÷\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        XCTAssertTrue(collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["÷"]/*[[".cells.buttons[\"÷\"]",".buttons[\"÷\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.isSelected)
        XCTAssertFalse(collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["+"]/*[[".cells.buttons[\"+\"]",".buttons[\"+\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.isSelected)
        XCTAssertFalse(collectionViewsQuery.buttons["-"].isSelected)
        XCTAssertFalse(collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["×"]/*[[".cells.buttons[\"×\"]",".buttons[\"×\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.isSelected)
    }
    
    func testOperatorShouldStaySelectedWhenTappingNumber() {
        let app = XCUIApplication()
        
        let collectionViewsQuery = app.collectionViews
        collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["5"]/*[[".cells.buttons[\"5\"]",".buttons[\"5\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["+"]/*[[".cells.buttons[\"+\"]",".buttons[\"+\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        collectionViewsQuery.buttons["5"].tap()
        
        XCTAssertTrue(collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["+"]/*[[".cells.buttons[\"+\"]",".buttons[\"+\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.isSelected)
    }
    
    func testOperatorShouldDeselectWhenTappingEqualSign() {
        let app = XCUIApplication()
        
        let collectionViewsQuery = app.collectionViews
        collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["5"]/*[[".cells.buttons[\"5\"]",".buttons[\"5\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["+"]/*[[".cells.buttons[\"+\"]",".buttons[\"+\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        collectionViewsQuery.buttons["5"].tap()
        collectionViewsQuery.buttons["="].tap()
        collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["+"]/*[[".cells.buttons[\"+\"]",".buttons[\"+\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        collectionViewsQuery.buttons["="].tap()
        
        XCTAssertFalse(collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["+"]/*[[".cells.buttons[\"+\"]",".buttons[\"+\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.isSelected)
    }
}
