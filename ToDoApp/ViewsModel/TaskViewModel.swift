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
    private var items: FetchedResults<Item> //FetchedResults: Core Data pour récupérer et gérer les résultats d'une requête de base de données
    //ce qui signifie que les résultats de la requête sont une liste d'objets de type Item.
    
    @Environment(\.managedObjectContext)  var viewContext
    //Dans ce cas, la variable viewContext est déclarée avec @Environment(\.managedObjectContext), ce qui signifie qu'elle obtient le contexte géré (managedObjectContext) à partir de l'environnement. Cela permet à la vue ou à la structure SwiftUI d'accéder au contexte géré pour effectuer des opérations de lecture ou d'écriture sur la base de données Core Data.
    //Le contexte géré (managedObjectContext) est généralement utilisé pour effectuer des opérations de création, de récupération, de mise à jour et de suppression d'objets gérés par Core Data. Il agit comme une interface entre l'application SwiftUI et la couche de persistance Core Data.
 
    //let viewContext = PersistenceController(inMemory: true).container.viewContext
    
    
    init() {}
    
    
    func addItem(name: String, pitch: String, selectedPriority: Priority, completeDate: Date, isfinish: Bool, viewContext: NSManagedObjectContext) -> Item {
        withAnimation {
            
            let newItem = Item(context: viewContext)
            newItem.name = name
            newItem.priority = selectedPriority.rawValue
            newItem.pitch = pitch
            newItem.completeDate = completeDate
            newItem.isfinish = isfinish
           
            let notifId = scheduleNotification(triggerDate: newItem.completeDate!, name: name)
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
    
    
    func updateItem(item:Item, name: String, pitch: String, selectedPriority: Priority, completeDate: Date, isfinish: Bool, viewContext: NSManagedObjectContext) {
        notificationManager.removePendingNotification(id: notifId)
        withAnimation {
            item.name = name
            item.priority = selectedPriority.rawValue
            item.pitch = pitch
            item.completeDate = completeDate
            item.isfinish = isfinish
            let notifId = scheduleNotification(triggerDate: completeDate, name: name)
            item.notifId = notifId
            
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
//    func deleteItems(offsets: IndexSet, notifId: String, items: FetchRequest<Item>) {
//       
//            withAnimation {
//                
//               //let item = offsets.map {items[$0] }
//               // print(item.first!.notifId)
//               
//        
////                offsets.map { items[$0] }.forEach { item in
////                    notificationManager.removePendingNotification(id: item.notifId ?? "")
////                }
////
//                offsets.map {items[$0] }.forEach(viewContext.delete)
//                do {
//                    try viewContext.save()
//                } catch {
//                    
//                    let nsError = error as NSError
//                    print("Unresolved error \(nsError), \(nsError.userInfo)")
//                }
//            }
//        }
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
    func scheduleNotification(triggerDate: Date, name: String) -> String {
        let notificationId = UUID().uuidString
        let content = UNMutableNotificationContent()
        content.title = "ToDoApp"
       // content.body = " it's time to \(name) at \(triggerDate.formatted(date: .abbreviated, time: .standard))"
        content.body = " it's time to : \(name) 🙂 "
        content.sound = UNNotificationSound.default
        content.userInfo = [
            "notificationId": "\(notificationId)" // additional info to parse if need
        ]

         
         let trigger = UNCalendarNotificationTrigger(dateMatching: NotificationHelper.getTriggerDate(triggerDate: triggerDate)!, repeats: false)

        notificationManager.scheduleNotification(
                id: "\(notificationId)",
                content: content,
                trigger: trigger)
         
         return "\(notificationId)"
    }
  
}
