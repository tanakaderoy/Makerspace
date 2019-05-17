//
//  MakerspaceUITests.swift
//  MakerspaceUITests
//
//  Created by Rob McMahon on 5/6/19.
//  Copyright © 2019 Rob McMahon. All rights reserved.
//

import XCTest

class MakerspaceUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    func testHomePage() {
        //Not working with table views!
    }
    
    
    //On HomeVC, tap search bar. Type into search bar. Cancel search bar.
    func testSearchBar() {
        let app = XCUIApplication()
        app.tables.searchFields["Search"].tap()
        app.buttons["Cancel"].tap()
    }
    
    
    //On DetailVC, select multiple options from picker. After third selection, press sign in. Dismiss sign in notification.
    func testDetailPageSignIn() {
        let app = XCUIApplication()
        let textField = app.otherElements.containing(.navigationBar, identifier:"Makerspace.DetailVC").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .textField).element
        textField.tap()
        app/*@START_MENU_TOKEN@*/.pickerWheels["Design Studio"]/*[[".pickers.pickerWheels[\"Design Studio\"]",".pickerWheels[\"Design Studio\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeUp()
        textField.tap()
        app/*@START_MENU_TOKEN@*/.pickerWheels["Metal Shop"]/*[[".pickers.pickerWheels[\"Metal Shop\"]",".pickerWheels[\"Metal Shop\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeUp()
        textField.tap()
        app/*@START_MENU_TOKEN@*/.pickerWheels["CNC Wood"]/*[[".pickers.pickerWheels[\"CNC Wood\"]",".pickerWheels[\"CNC Wood\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeDown()
        app.buttons["Sign In"].tap()
        app.alerts["Signed In"].buttons["Dismiss"].tap()
    }
    
    
    //On DetailVC, user is already signed in. Press sign out. Dismiss sign out notification.
    func testDetailPageSignOut() {
        let app = XCUIApplication()
        app.buttons["Sign Out"].tap()
        app.alerts["Signed Out"].buttons["Dismiss"].tap()
    }
    
    
    //On LoginVC, enter the correct credentials and log in as an admin. Then logout.
    func testAdminSuccess() {
        let app = XCUIApplication()
        app.textFields["E-mail"].tap()
        app.secureTextFields["Password"].tap()
        app.buttons["Sign in"].tap()
        app.navigationBars.buttons["Logout"].tap()
    }
    
    
    //On LoginVC, enter the incorrect credentials. Repeat the process. Press Back button after two failures.
    func testAdminFailure() {
        let app = XCUIApplication()
        app.textFields["E-mail"].tap()
        
        let passwordSecureTextField = app.secureTextFields["Password"]
        passwordSecureTextField.tap()
        
        let signInButton = app.buttons["Sign in"]
        signInButton.tap()
        passwordSecureTextField.tap()
        signInButton.tap()
        app.navigationBars["Makerspace.LoginVC"].buttons["Back"].tap()
    }
    
    
    func testAdminDelete() {
        //Not working with table views!
    }
    
    
    /* On CreateUserVC, enter user name and email, then press Create Account Button. Logout afterwards.
    This shows the updated table view cell on both CreateUser and HomeVC. */
    func testAdminAdd() {
        let app = XCUIApplication()
        app.textFields["Full Name"].tap()
        
        let eMailTextField = app.textFields["E-mail"]
        eMailTextField.tap()
        app.buttons["Create Account"].tap()
        app.alerts["User Created"].buttons["Dismiss"].tap()
        eMailTextField.tap()
        app.navigationBars.buttons["Logout"].tap()
    }
} //end class
