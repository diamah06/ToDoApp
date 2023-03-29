//
//  ToDoAppApp.swift
//  ToDoApp
//
//  Created by Mahdia Amriou on 04/01/2023.
//

import SwiftUI

@main
struct ToDoAppApp: App {
    
    let persistenceController = PersistenceController.shared
    let notificationManager = NotificationManager() // pour notification

    init() {

        setupNotifications()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
    
    private func setupNotifications() {
        notificationManager.notificationCenter.delegate = notificationManager
        notificationManager.handleNotification = handleNotification

        requestNotificationsPermission()
    }

    private func handleNotification(notification: UNNotification) {
        print("<<<DEV>>> Notification received: \(notification.request.content.userInfo)")
    }

    private func requestNotificationsPermission() {
        notificationManager.requestPermission(completionHandler: { isGranted, error in
            if isGranted {
                // handle granted success
            }

            if let _ = error {
                // handle error

                return
            }
        })
    }
    
    
    
}
