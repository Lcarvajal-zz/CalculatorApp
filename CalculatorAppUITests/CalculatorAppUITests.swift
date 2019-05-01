//
//  CalculatorAppUITests.swift
//  CalculatorAppUITests
//
//  Created by Lukas Carvajal on 25.04.19.
//  Copyright © 2019 AppsByLukas. All rights reserved.
//

import XCTest
//@testable import CalculatorApp

class CalculatorAppUITests: XCTestCase {
    override func setUp() {
        continueAfterFailure = false
        XCUIApplication().launch()
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
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
        
        
        XCTAssertEqual(app.staticTexts["OutputLabel"].label, "6")
    }
    
    

}
