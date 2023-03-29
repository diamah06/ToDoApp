//
//  Model.swift
//  ToDoApp
//
//  Created by Mahdia Amriou on 29/03/2023.
//

import Foundation


struct Task: Identifiable {
    var id: ObjectIdentifier
    var name: String
    var pitch: String
    var selectedPriority: Priority
    var completeDate = Date()
    var isfinish: Bool

}
