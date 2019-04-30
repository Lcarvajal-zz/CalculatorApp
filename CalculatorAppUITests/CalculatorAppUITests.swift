//
//  CalculatorAppUITests.swift
//  CalculatorAppUITests
//
//  Created by Lukas Carvajal on 25.04.19.
//  Copyright © 2019 AppsByLukas. All rights reserved.
//

import XCTest

class CalculatorAppUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUp() {

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app = XCUIApplication()
        app.launchArguments.append("--uitesting")
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCalculatorButtons() {
        XCTAssertTrue(app.buttons["1"].exists)
    }

}
