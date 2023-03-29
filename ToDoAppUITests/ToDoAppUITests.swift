//
//  ToDoAppUITests.swift
//  ToDoAppUITests
//
//  Created by Mahdia Amriou on 29/03/2023.
//

import XCTest

final class ToDoAppUITests: XCTestCase {
    
    override func setUpWithError() throws {
        
        continueAfterFailure = false
        
        
    }
    
    override func tearDownWithError() throws {
        
    }
    
    func testScreen1() throws {
        let app = XCUIApplication() // grace a XCUIApplication nous pouvons accéder à tous les elements de l'interface utilisateur et executer des test ui
        app.launch()  // lancer l'app
        // 1 - Define the UI
        let title = app.staticTexts["title"]
        //  let title = app.staticTexts.element
        //  2 - Check if exists & if label is correct
        XCTAssert(title.exists)
        XCTAssertEqual(title.label,"My Todo list")
        // Boutoon Edit
        let navAddBtn = app.navigationBars.element.buttons.element
        XCTAssert(navAddBtn.exists)
        XCTAssertEqual(navAddBtn.label, "Edit")
        navAddBtn.tap()
        let showModalBtn = app.buttons["showModalBtn"]
        XCTAssert(showModalBtn.exists)
        showModalBtn.tap()
        
        
    }
    
    
    func testList() throws {
        let app = XCUIApplication()
        app.launch()
        
        
        // List
        let list = app.collectionViews.element
        XCTAssert(list.exists)
                // nbre initial d'elements de la liste
    //   let ListRows = list.cells.count
     //   XCTAssert(ListRows == 0)
        
        // 3 elements of list
        
        // let firstM = app.collectionViews.element.staticTexts["task3"]
        // XCTAssert(firstM.exists)
        
       // let secondM = app.collectionViews.element.staticTexts["task2"]
       // XCTAssert(secondM.exists)
        
       // let thirdM = app.collectionViews.element.staticTexts["task1"]
        //XCTAssert(thirdM.exists)
        
        
        let showModalBtn = app.buttons["showModalBtn"]
        XCTAssert(showModalBtn.exists)
        showModalBtn.tap()
        
        // Check list navigation
        // firstM.tap()
        
    }
    
    func testButton() throws {
        let app = XCUIApplication()
        app.launch()
          // 1 - Define the UI
        let buttonAdd = app.buttons["Add"]
        
        //  2 - Check if exists
        XCTAssert(buttonAdd.exists)
        // XCTAssertEqual(buttonAdd.label, "ADD")
        
    }
    
    
    func testAddTasksView() throws {
        let app = XCUIApplication()
        app.launch()
        //  Button ShowModal
        let showModalBtn = app.buttons["showModalBtn"]
        XCTAssert(showModalBtn.exists)
        showModalBtn.tap()
        // Add Tasks
       
        // TextField : New Task
        let newTaskTextField = app.textFields["New Task"]
        XCTAssert(newTaskTextField.exists)
        XCTAssert(newTaskTextField.label.isEmpty)
        newTaskTextField.tap()
        // Type data in text fields
        newTaskTextField.typeText("name")
        // TextField Description
        let descTaskTextField = app.textFields["Description of task"]
        XCTAssert(descTaskTextField.exists)
        XCTAssert(descTaskTextField.label.isEmpty)
        descTaskTextField.tap()
        descTaskTextField.typeText("This is Description of task 3")
        app.collectionViews.buttons["Medium"].tap()
        // DatePicker
        app.collectionViews.datePickers.buttons["Next Month"].tap()
        app.collectionViews.datePickers.collectionViews.buttons["mardi 4 avril"].children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.tap()
       
        
        // Check if ADD button behave correctly (save new task and dismiss the modal sheet)
        let addButton = app.buttons["ADD"]
        addButton.tap()
    }
    
    
     func testAddTasksView4() throws {
        
       let names = ["tache1", "tache2", "tache3"]
        for name in names {
          try testAddtask(name:name)
        }
        
}
    
    
    func testAddTasksView2() throws {
        
        let rename = "name1"
        try testAddtask(name: rename)
       
    }
    
    func testAddtask(name:String) throws {
        let app = XCUIApplication()
        app.launch()
        //  Button ShowModal
        let showModalBtn = app.buttons["showModalBtn"]
        XCTAssert(showModalBtn.exists)
        showModalBtn.tap()
        // Add Tasks
        
        // TextField : New Task
        let newTaskTextField = app.textFields["New Task"]
        XCTAssert(newTaskTextField.exists)
        XCTAssert(newTaskTextField.label.isEmpty)
        newTaskTextField.tap()
        // Type data in text fields
        newTaskTextField.typeText(name)
        // TextField Description
        let descTaskTextField = app.textFields["Description of task"]
        XCTAssert(descTaskTextField.exists)
        XCTAssert(descTaskTextField.label.isEmpty)
        descTaskTextField.tap()
        descTaskTextField.typeText("This is Description of task 3")
        app.collectionViews.buttons["Medium"].tap()
        // DatePicker
        app.collectionViews.datePickers.buttons["Next Month"].tap()
        app.collectionViews.datePickers.collectionViews.buttons["mardi 4 avril"].children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.tap()
        
        
        // Check if ADD button behave correctly (save new task and dismiss the modal sheet)
        let addButton = app.buttons["ADD"]
        addButton.tap()
    }
    
    
    func testtime() throws {
        let app = XCUIApplication()
        app.launch()
        
        let showModalBtn = app.buttons["showModalBtn"]
        XCTAssert(showModalBtn.exists)
        showModalBtn.tap()
        app.collectionViews.staticTexts["Date"].swipeUp()
        app.collectionViews.staticTexts["Time"].tap()
        
                
      //  app.datePickers.pickerWheels["51 minutes"].tap()
       // app.buttons["PopoverDismissRegion"].tap()
        //app.buttons["ButtonAdd"].tap()
        
    }
    
    
    func testdate2() throws {
        let app = XCUIApplication()
        app.launch()
        
        let collectionViewsQuery = XCUIApplication().collectionViews
        collectionViewsQuery.staticTexts["Date"].swipeUp()
        collectionViewsQuery.staticTexts["Time"].tap()
               
                                        
        
    }
    
   // func testhhh() throws {
        
      //  let names = ["tache1", "tache2", "tache3"]
       // names.testAddTasksView2
    
   // }
    
    func testDelate () throws {
        
       let app = XCUIApplication()
       app.launch()
       let navAddBtn = app.navigationBars.element.buttons.element
       XCTAssert(navAddBtn.exists)
       XCTAssertEqual(navAddBtn.label, "Edit")
       navAddBtn.tap()
        

      //  let doneButton = app.navigationBars["_TtGC7SwiftUI19UIHosting"].buttons["Done"]
       // doneButton.tap()
        
       // let collectionViewsQuery = app.collectionViews
        app.collectionViews.children(matching: .cell).element(boundBy: 0).otherElements.containing(.image, identifier:"remove").element.tap()
        app.collectionViews.buttons["Delete"].tap()
        navAddBtn.tap()
        
    }
        
    func testmove () throws {
        let app = XCUIApplication()
        app.launch()
        let navAddBtn = app.navigationBars["_TtGC7SwiftUI19UIHosting"]
        navAddBtn.buttons["Edit"].tap()
        app.collectionViews.children(matching: .cell).element(boundBy: 0).buttons["Reorder"].swipeDown()
        navAddBtn.buttons["Done"].tap()
        
        
        
    }
    

        func testDetailTasksView() throws {
            let app = XCUIApplication()
            app.launch()
            
            // Start list navigation to detail View
            let firstM = app.collectionViews.element.staticTexts["Task 3"]
            firstM.tap()
            
           
            // Check back navigation
            
            let navBackBtn = app.navigationBars.element.buttons.element
            XCTAssert(navBackBtn.exists)
            XCTAssertEqual(navBackBtn.label, "Back")
            navBackBtn.tap()
            
        }
        
    
        func testLaunchPerformance() throws {
            if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
                // This measures how long it takes to launch your application.
                measure(metrics: [XCTApplicationLaunchMetric()]) {
                    XCUIApplication().launch()
                }
            }
        }
    }

