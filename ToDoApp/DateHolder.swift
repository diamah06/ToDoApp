//
//  DateHolder.swift
//  ToDoApp
//
//  Created by Mahdia Amriou on 05/01/2023.
//

import SwiftUI
import CoreData

class DateHolder: ObservableObject
{
    @Published var date = Date()
    @Published var taskItems: [Item] = []
    
    let calendar: Calendar = Calendar.current
    
    func moveDate(_ days: Int,_ context: NSManagedObjectContext)
    {
        date = calendar.date(byAdding: .day, value: days, to: date)!
        refreshTaskItems(context)
    }
        
    init(_ context: NSManagedObjectContext)
    {
        refreshTaskItems(context)
    }
    
    func refreshTaskItems(_ context: NSManagedObjectContext)
    {
        taskItems = fetchTaskItems(context)
    }
    
    func fetchTaskItems(_ context: NSManagedObjectContext) -> [Item]
    {
        do
        {
            return try context.fetch(dailyTasksFetch()) as [Item]
        }
        catch let error
        {
            fatalError("Unresolved error \(error)")
        }
    }
    
    func dailyTasksFetch() -> NSFetchRequest<Item>
    {
        let request = TaskItem.fetchRequest()
        
        request.sortDescriptors = sortOrder()
        request.predicate = predicate()
        return request
    }
    
    private func sortOrder() -> [NSSortDescriptor]
    {
        let completedDateSort = NSSortDescriptor(keyPath: \Item.completedDate, ascending: true)
        let timeSort = NSSortDescriptor(keyPath: \Item.scheduleTime, ascending: true)
        let dueDateSort = NSSortDescriptor(keyPath: \Item.dueDate, ascending: true)
        
        return [completedDateSort, timeSort, dueDateSort]
    }
    
    private func predicate() -> NSPredicate
    {
        let start = calendar.startOfDay(for: date)
        let end = calendar.date(byAdding: .day, value: 1, to: start)
        return NSPredicate(format: "dueDate >= %@ AND dueDate < %@", start as NSDate, end! as NSDate)
    }
    
    func saveContext(_ context: NSManagedObjectContext)
    {
        do {
            try context.save()
            refreshTaskItems(context)
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}
