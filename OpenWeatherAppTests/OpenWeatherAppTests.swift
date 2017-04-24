//
//  OpenWeatherAppTests.swift
//  OpenWeatherAppTests
//
//  Created by Rekha Bisht on 4/23/17.
//  Copyright © 2017 Rekha Bisht. All rights reserved.
//

import UIKit
import XCTest
@testable import OpenWeatherApp

class OpenWeatherAppTests: XCTestCase {
    var mainController:MainViewController!

    override func setUp() {
        super.setUp()
        mainController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "mainViewControllerStoryboard") as! MainViewController
    }
    
    //Should be disabled when there is no text in the text field
    func testGoButton() {
        let _ = mainController.view
        mainController.searchTextField.text = ""
        mainController.toggleSearchButton()
        
        XCTAssertFalse(mainController.searchButton.isEnabled, "Go Button should be disabled")
        
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
}
