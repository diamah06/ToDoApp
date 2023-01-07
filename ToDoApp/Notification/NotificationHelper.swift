//
//  NotificationHelper.swift
//  ToDoApp
//
//  Created by Mahdia Amriou on 06/01/2023.
//

import Foundation
import SwiftUI
import UserNotifications

class NotificationHelper {
    static func getTriggerDate() -> DateComponents? {
        let triggerDate =  Date().addingTimeInterval(10)
        return Calendar.current.dateComponents([.timeZone, .year, .month, .day, .hour, .minute, .second], from: triggerDate)
    }
}
