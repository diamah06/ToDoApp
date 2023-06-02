//
//  DetailTaskView.swift
//  ToDoApp
//
//  Created by Mahdia Amriou on 05/01/2023.
//
import SwiftUI

struct DetailTasksView: View {
  
    @ObservedObject var newItem : Item
   
    
    @Environment(\.managedObjectContext) private var viewContext
  

    var body: some View {
        
        ZStack{
         
            Image("black.jpg")
                .resizable()
                .ignoresSafeArea()
         
        
            VStack {
                Form{
                    Text(newItem.name ?? "")
                        .foregroundColor(Color.brown)
                        .bold()
                        .font(.title)
                        .fontWeight(.heavy)
                        .padding()
                        .listRowBackground(Color(hue: 0.086, saturation: 0.141, brightness: 0.972))
                    
                    HStack{
                        Image(systemName: "flag.fill")
                            .foregroundColor(.brown)
                        Text("   \(newItem.priority ?? "")")
                            .italic()
                            .font(.callout)
                            .padding()
                            .foregroundColor(.brown)
                            .bold()
                    }.listRowBackground(Color(hue: 0.086, saturation: 0.141, brightness: 0.972))
                    HStack{
                        Image(systemName: "alarm.fill")
                            .foregroundColor(.brown)
                        
                        Text("    \(newItem.completeDate!, formatter: itemFormatter)")
                            .foregroundColor(.brown)
                            .bold()
                            .lineSpacing(8)
                            .padding()
                            .multilineTextAlignment(.center)
                            .bold()
                        
                    }.listRowBackground(Color(hue: 0.086, saturation: 0.141, brightness: 0.972))
                    HStack{
                        Image(systemName: "note.text")
                            .foregroundColor(.brown)
                        Text("   \(newItem.pitch ?? "")")
                            .foregroundColor(.brown)
                            .lineSpacing(8)
                            .padding()
                            .multilineTextAlignment(.center)
                            .bold()
                        
                    } .listRowBackground(Color(hue: 0.086, saturation: 0.141, brightness: 0.972))
                    
                }.scrollContentBackground(.hidden)
                   
                    Spacer()
                    
               // ShareLink(item: (newItem.name ?? ""))
                
                ShareLink(item: "Hey ! I share my new todo! \(String(describing: newItem.name)). It's \(String(describing: newItem.completeDate))")
                
//                    .swipeActions(edge: .leading) {
//                        ShareLink(item: "Je te partage ma nouvelle Todo: \n\(newItem.name ?? "No title")\n\(newItem.completeDate, "No description")")
//                    }
                
                
                        .bold()
                        .padding()
                }
            
            
           
            
            }.toolbar {
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: {
                        UpdateTaskView(name: newItem.name!, pitch: newItem.pitch!, selectedPriority: Priority(rawValue: newItem.priority!) ?? .urgent, completeDate: newItem.completeDate!, isfinish: newItem.isfinish , newItem: newItem)
                        
                    }, label: {
                        Image(systemName: "pencil")
                            .foregroundColor(.accentColor)
                    })
                }
            }
            
            
        }
    }

struct DetailTasksView_Previews: PreviewProvider {
    static let persistence = PersistenceController.preview
    static var item: Item = {
        let context = persistence.container.viewContext
        let item = Item(context: context)
        item.completeDate = Date.now
        item.priority = "urgent"
        item.name = "name"
        item.pitch = "pitch"
        item.isfinish = true
        return item
    }()
    
    static var previews: some View {
        DetailTasksView(newItem: item)
            .environment(\.managedObjectContext, persistence.container.viewContext)
    }
}
