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
    @Published var notifId = ""
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath:
                         \Item.order, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    @Environment(\.managedObjectContext)  var viewContext
 
    //let viewContext = PersistenceController(inMemory: true).container.viewContext
    
    
    init() {}
    
    
    func addItem(name: String, pitch: String, selectedPriority: Priority, completeDate: Date, notifId: String, isfinish: Bool, viewContext: NSManagedObjectContext) -> Item {
        withAnimation {
            
            let newItem = Item(context: viewContext)
            newItem.name = name
            newItem.priority = selectedPriority.rawValue
            newItem.pitch = pitch
            newItem.completeDate = completeDate
            newItem.isfinish = isfinish
            newItem.notifId = notifId
            print("ID DE NOTIF \(newItem.notifId ?? "")")
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
            return newItem
        }
    }
    
    // fonction Add
//    func addItem(name: String, pitch: String, selectedPriority: Priority, completeDate: Date, isfinish: Bool, viewContext: NSManagedObjectContext)  {
//
//        withAnimation {
//
//            let newItem = Item(context: viewContext)
//
//            newItem.name = name
//            newItem.priority = selectedPriority.rawValue
//            newItem.pitch = pitch
//            newItem.completeDate = completeDate
//            newItem.isfinish = isfinish
//
//            do {
//                try viewContext.save()
//            } catch {
//
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//            return
//        }
//
//    }
    
    
    func updateItem(item:Item, name: String, pitch: String, selectedPriority: Priority, completeDate: Date, isfinish: Bool, notifId: String, viewContext: NSManagedObjectContext) {
        notificationManager.removePendingNotification(id: notifId)
        withAnimation {
            item.name = name
            item.priority = selectedPriority.rawValue
            item.pitch = pitch
            item.completeDate = completeDate
            item.isfinish = isfinish
            
            do {
                try viewContext.save()
            } catch {
                
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
            return
        }
        
    }
    // fonction deleteItems
    func deleteItems(offsets: IndexSet, notifId: String) {
        notificationManager.removePendingNotification(id: notifId)
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
//    func updateTask() {
//
//        do {
//            try viewContext.save()
//        }
//        catch {
//            let nsError = error as NSError
//            fatalError("Unresolved error \(nsError.localizedDescription), \(nsError.userInfo)")
//        }
//    }
    // fonction Notification
     func scheduleNotification(date: Date, title: String) -> String {
         let notificationId = UUID().uuidString
        let content = UNMutableNotificationContent()
        content.title = "New notification \(title)"
        content.sound = UNNotificationSound.default
        content.userInfo = [
            "notificationId": "\(notificationId)" // additional info to parse if need
        ]

        let trigger = UNCalendarNotificationTrigger(
            dateMatching: NotificationHelper.getTriggerDate(triggerDate: date)!,
                repeats: false
        )

        notificationManager.scheduleNotification(
                id: "\(notificationId)",
                content: content,
                trigger: trigger)
         
         return notificationId
    }
  
}
