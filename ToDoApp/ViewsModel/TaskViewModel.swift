//
//  TaskViewModel.swift
//  ToDoApp
//
//  Created by Mahdia Amriou on 29/03/2023.
//

import Foundation
import CoreData
import SwiftUI


@MainActor class TaskViewModel: ObservableObject {
    let notificationManager = NotificationManager()
    
    @Published var name = ""
    @Published var pitch: String=""
    @Published var selectedPriority: Priority = .urgent
    @Published var completeDate = Date.now
    @Published var isfinish: Bool = true
    @Published var updatename = ""
    @Published var updatepitch: String=""
    @Published var updateselectedPriority: Priority = .urgent
    @Published var updatecompleteDate = Date.now
    
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath:
                         \Item.order, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    @Environment(\.managedObjectContext)  var viewContext
 
    //let viewContext = PersistenceController(inMemory: true).container.viewContext
    
    
    init() {}
    
    // fonction Add
    func addItem(name: String,pitch: String, selectedPriority: Priority, completeDate: Date, isfinish: Bool, viewContext: NSManagedObjectContext) -> Item {
        
        withAnimation {
            
            let newItem = Item(context: viewContext)
            newItem.name = name
            newItem.priority = selectedPriority.rawValue
            newItem.pitch = pitch
            newItem.completeDate = completeDate
            newItem.isfinish = Bool()
            
            do {
                try viewContext.save()
            } catch {
                
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
            return newItem
        }
        
    }
    
    // fonction deleteItems
          func deleteItems(offsets: IndexSet) {
            withAnimation {
                offsets.map {items[$0] }.forEach(viewContext.delete)

                do {
                    try viewContext.save()
                } catch {
                    
                    let nsError = error as NSError
                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                }
            }
        }
  // function Update task
    func updateTask() {
        
        do {
            try viewContext.save()
        }
        catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError.localizedDescription), \(nsError.userInfo)")
        }
    }
}
