//
//  ContentView.swift
//  ToDoApp
//
//  Created by Mahdia Amriou on 04/01/2023.
//

import SwiftUI
import CoreData

struct ContentView : View {

   
    
   // let notificationManager : NotificationManager
    
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath:
                         \Item.order, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    @State var showModal = false
   //
    
    let notificationManager = NotificationManager()
    
    //fonction styleForPropriority
    
    private func styleForPropriority(_ value: String) -> Color {
        let priority = Priority(rawValue: value)
        
        switch priority {
        case .urgent:
            return Color.red
        case .medium:
            return Color.orange
        case .low:
            return Color.green
        case .none:
            return Color.black
        }
    }
    
    ///
    // fonction finish task
  
    private func updateItem(_ item: Item) {
        item.isfinish = !item.isfinish
        
        do {
            try viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    
    
  
    var body: some View {
        
        NavigationView {
            
            ZStack  {
                Image("black.jpg")
                    .resizable()
                    .ignoresSafeArea()
                VStack {
                    
                    HStack{
                        Text("My Todo list ")
                            .font(.title)
                            .foregroundColor(Color(hue: 0.086, saturation: 0.141, brightness: 0.972))
                        LottieView(lottieFile: "jaune")
                            .frame(width: 100, height: 70)
                        
                           
                        
                    }
                    ZStack (alignment: .bottomTrailing) {
                        List { 
                            
                            ForEach(items) { item in
                                NavigationLink {
                                    DetailTasksView(newItem: item)
                                    
                                    //  DetailTasksView()
                                    
                                } label: {
                                    HStack{
                                        
                                        Circle ()
                                            .fill(styleForPropriority(item.priority!))
                                            .frame(width: 15, height: 15)
                                        Spacer().frame(width: 20)
                                        
                                        
                                        
                                      //  Text("\(item.order)")
                                       //     .foregroundColor(.black)
                                        Text(item.name ?? "")
                                            .foregroundColor(.black)
                                        
                                      // fonction onapear
                                        
                                        
                                            .onAppear {
                                            scheduleNotification(date: item.completeDate!, itemContent:
                                            "\(item.name!) le \(item.completeDate!) ")
                                                                                        }
                                        
                                        
                                        
                                    //
                                        
                                        Spacer()
                                        Image(systemName: item.isfinish ? "checkmark.square.fill": "square")
                                            .resizable()
                                            .frame(width: 30, height: 30)
                                            .foregroundColor(.green)
                                            .onTapGesture {
                                                updateItem(item)
                                            }
                                        
                                        
                                        
                                    }
                                    
                                }
                            }
                            
                            // OnDelete, OnMove
                            .onMove(perform: moveItems)
                            .onDelete(perform: deleteItems)
                            
                            .listRowBackground(Color(hue: 0.086, saturation: 0.141, brightness: 0.972))
                        }.scrollContentBackground(.hidden)
                            .toolbar {
                                ToolbarItem(placement: .navigationBarTrailing) {
                                    EditButton()
                                }
                                
                                
                                
                            }
                        
                            .navigationBarTitle("ToDo APP")
                        // .foregroundColor(.white)
                            .foregroundColor(Color(hue: 0.086, saturation: 0.141, brightness: 0.972))
                        
                        
                        
                        
                        Button(action: { showModal = true })
                        {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .frame(width:60, height: 60)
                                .foregroundColor(Color(hue: 0.086, saturation: 0.141, brightness: 0.972))
                                .shadow(color:.purple,radius: 0.6,x:1, y:1)
                            
                            
                        }
                        .sheet(isPresented: $showModal, content: {
                            
                            AddTasksView()
                            
                                .presentationDetents([.medium,.large]) //modifier la taille de sheet
                        })
                    }.padding()
                }
            }
        }
        
    }
    
    
// fonction deleteItems
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    // Fin fonction delete
    
    
    private func scheduleNotification(date: Date, itemContent: String) {
        let notificationId = UUID()
        let content = UNMutableNotificationContent()
        content.body = "New notification \(itemContent)"
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
    }
    
    
    
    
   // fonction pour alerte :
    
    
    
    
    
    
    
    // fonction move
    private func moveItems(at
        sets:IndexSet, destination: Int) {
        let itemToMove = sets.first!
        
        if itemToMove < destination{
            var startIndex = itemToMove + 1
            let endIndex = destination - 1
            var startOrder =
            items[itemToMove].order
            while startIndex <= endIndex{
                items[startIndex].order = startOrder
                startOrder = startOrder + 1
                startIndex = startIndex + 1
            }
            items[itemToMove].order = startOrder
            
        }
        else if destination < itemToMove{
            var startIndex = destination
            let endIndex = itemToMove - 1
            var startOrder =
                items[destination].order + 1
            let newOrder =
                items[destination].order
            while startIndex <= endIndex{
                items[startIndex].order =
                startOrder
                startOrder = startOrder + 1
                startIndex = startIndex + 1
            }
            
            items[itemToMove].order = newOrder
            
        }
        
        do{
            try viewContext.save()
        }
        
        catch{
            
            print(error.localizedDescription)
        }
        
        
            }
    
    // fin de funct move
}





private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
   static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
       
       
      
       
   }
}
