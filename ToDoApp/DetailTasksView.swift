//
//  DetailTaskView.swift
//  ToDoApp
//
//  Created by Mahdia Amriou on 05/01/2023.
//
import SwiftUI





struct DetailTasksView: View {
    private let url = URL(string: "https://www.task.com")!
    
    var newItem : Item
    
    
    var body: some View {
        
        ZStack{
         
            Image("black.jpg")
                .resizable()
                .ignoresSafeArea()
         
        
            VStack {
                Form{
                    Text(newItem.name ?? "")
                      //  .foregroundColor(Color(hue: 0.086, saturation: 0.141, brightness: 0.972))
                        .font(.title)
                        .fontWeight(.heavy)
                        .padding()
                        .listRowBackground(Color(hue: 0.086, saturation: 0.141, brightness: 0.972))
                    
                    HStack{
                        Image(systemName: "flag.fill")
                        Text(":  \(newItem.priority ?? "")")
                        //     .foregroundColor(Color(hue: 0.086, saturation: 0.141, brightness: 0.972))
                            .italic()
                            .font(.callout)
                            .padding()
                    }.listRowBackground(Color(hue: 0.086, saturation: 0.141, brightness: 0.972))
                    HStack{
                        Image(systemName: "alarm.fill")
                        Text(":   \(newItem.completeDate!, formatter: itemFormatter)")
                            .foregroundColor(.brown)
                            .bold()
                            .lineSpacing(8)
                            .padding()
                            .multilineTextAlignment(.center)
                            
                        
                    }.listRowBackground(Color(hue: 0.086, saturation: 0.141, brightness: 0.972))
                    HStack{
                        Image(systemName: "note.text")
                        Text(":  \(newItem.pitch ?? "")")
                        //     .foregroundColor(.white)
                            .lineSpacing(8)
                            .padding()
                            .multilineTextAlignment(.center)
                        
                    } .listRowBackground(Color(hue: 0.086, saturation: 0.141, brightness: 0.972))
                    
                }.scrollContentBackground(.hidden)
                   
                    Spacer()
                    
                    
                    
                    ShareLink(item: url)
                        .bold()
                    
                        .padding()
                }
            }
            
            
        }
    }


private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()



struct DetailTasksView_Previews: PreviewProvider {
    static let persistence = PersistenceController.preview
    static var item: Item = {
        let context = persistence.container.viewContext
        let item = Item(context: context)
        item.timestamp = Date()
        item.completeDate = Date()
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
