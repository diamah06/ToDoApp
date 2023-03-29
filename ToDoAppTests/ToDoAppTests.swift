//
//  ToDoAppTests.swift
//  ToDoAppTests
//
//  Created by Mahdia Amriou on 29/03/2023.
//

import XCTest
import CoreData
import SwiftUI
@testable import ToDoApp

final class ToDoListTests: XCTestCase {
    let viewContext = PersistenceController(inMemory: true).container.viewContext
    
    @ObservedObject var vm = TaskViewModel()
    
    //let vm = TaskViewModel()

    

    func testAddItem() throws {
        
        let name = "Task 1"
        let pitch = "description"
        let priority = Priority.medium
        let date = Date.now
       // let isfinish = false
        
        
        let item = vm.addItem(name: name,pitch: pitch, selectedPriority: priority, completeDate: date, isfinish: false, viewContext: viewContext)
        
        XCTAssertEqual(item.name, name)
        XCTAssertEqual(item.pitch, pitch)
        XCTAssertEqual(item.priority, Priority.medium.rawValue)
        XCTAssertEqual(item.isfinish, false)
        XCTAssertEqual(item.completeDate, date)
        
    }
    
    func testDeleteItem() throws {
        
        let name = "Task 1"
        let pitch = "description"
        let priority = Priority.medium
        let date = Date.now
       // let isfinish = false
        
        
        let item = vm.addItem(name: name,pitch: pitch, selectedPriority: priority, completeDate: date, isfinish: false, viewContext: viewContext)
        
        XCTAssertEqual(item.name, name)
        XCTAssertEqual(item.pitch, pitch)
        XCTAssertEqual(item.priority, Priority.medium.rawValue)
        XCTAssertEqual(item.isfinish, false)
        XCTAssertEqual(item.completeDate, date)
        
    }




}
