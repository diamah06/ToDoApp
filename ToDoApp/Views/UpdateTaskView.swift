//
//  UpdateTaskView.swift
//  ToDoApp
//
//  Created by Mahdia Amriou on 31/03/2023.
//

import SwiftUI

struct UpdateTaskView: View {
    
    @State var name: String
    @State var pitch: String
    @State var selectedPriority: Priority
    @State var completeDate : Date
    @State var isfinish: Bool 

    //var task : FetchedResults<Item>
    
    @ObservedObject var newItem : Item
    @Environment(\.dismiss) var dismiss

    
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var vm = TaskViewModel()
    
    var body: some View {
        
        ZStack{
            
            Image("black.jpg")
                .resizable()
                .ignoresSafeArea()
            
            
            VStack {
                Form {
                    Section( header:
                                
                                Text("Task")
                        .accessibilityIdentifier("Task")
                        .bold()
                        .font(.headline)
                        .foregroundColor(Color(hue: 0.1, saturation: 0.141, brightness: 0.972))
                        .accessibilityLabel("Label")){
                           
                            TextField("New Task", text: $name)
                            //TextField("\($vm.newItem.name)", text: $name)
                                .textFieldStyle(.roundedBorder)
                        }
                        .accessibilityIdentifier("NewTaskTextField")
                        .textInputAutocapitalization(.never)
                    
                    // .textFieldStyle(OvalTextFieldStyle())
                    Section( header:
                                
                                Text("Description")
                        .accessibilityIdentifier("Description")
                        .bold()
                        .font(.headline)
                        .foregroundColor(Color(hue: 0.1, saturation: 0.141, brightness: 0.972))){
                            TextField("Description of task", text: $pitch)
                                .textFieldStyle(.roundedBorder)
                        }
                        .accessibilityIdentifier("DescTaskTextField")
                        .textInputAutocapitalization(.never)
                    Section( header:
                                
                                Text("Priority")
                        .accessibilityIdentifier("Priority")
                             
                        .bold()
                        .font(.headline)
                        .foregroundColor(Color(hue: 0.1, saturation: 0.141, brightness: 0.972))
                        .accessibilityLabel("Label"))
                    {
                        Picker("Priority", selection: $selectedPriority){
                            ForEach(Priority.allCases) { priority in
                                Text(priority.name).tag(priority)
                                
                            }
                            
                        }.pickerStyle(.segmented)
                            .colorMultiply(.brown)
                            .accessibilityIdentifier("Picker")
                    }
                    Section( header:
                                
                                Text("Date")
                        .accessibilityIdentifier("Date")
                        .bold()
                        .font(.headline)
                        .foregroundColor(Color(hue: 0.1, saturation: 0.141, brightness: 0.972))){
                            
                            DatePicker("Date", selection: $completeDate,in: Date()..., displayedComponents: .date)
                            DatePicker("Time", selection: $completeDate, displayedComponents: .hourAndMinute)
                            
                                .accessibilityIdentifier("DatePicker")
                        }
                        .datePickerStyle(GraphicalDatePickerStyle())
                    
                }.scrollContentBackground(.hidden)
                Button {
                    
                    vm.updateItem(item: newItem, name: name , pitch:pitch, selectedPriority: selectedPriority, completeDate: completeDate, isfinish: true, viewContext: viewContext)
                    
                    
                    dismiss()
                    
                } label: {
                    Text("Update")
                        .accessibilityIdentifier("text")
                        .foregroundColor(.white)
                        .bold()
                        .frame(width: 300, height: 35)
                        .overlay(Capsule().stroke(LinearGradient(colors: [.brown, Color(hue: 0.2, saturation: 0.141, brightness: 0.972)], startPoint: .leading, endPoint: .trailing), lineWidth: 10))
                    
                }
            }
            
            
            //
            
            
        }
        
        
    }
}

//struct UpdateTaskView_Previews: PreviewProvider {
//    static let persistence = PersistenceController.preview
//    static var item: Item = {
//        let context = persistence.container.viewContext
//        let item = Item(context: context)
//        item.completeDate = Date.now
//        item.priority = "urgent"
//        item.name = "name"
//        item.pitch = "pitch"
//        item.isfinish = true
//        return item
//    }()
    
//    static var previews: some View {
//        UpdateTaskView(task: Item(), newItem: item)
//            .environment(\.managedObjectContext, persistence.container.viewContext)
//    }
//}
