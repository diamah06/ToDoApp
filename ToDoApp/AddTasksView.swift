//
//  AddTasksView.swift
//  ToDoApp
//
//  Created by Mahdia Amriou on 04/01/2023.
//

import SwiftUI

enum Priority: String, CaseIterable, Identifiable {
    
    var id: UUID {
        return UUID()
    }
    case urgent, medium, low
}

extension Priority {
    
    var name : String {
        
       switch self {
        case .urgent:
           return "urgent"
        case .medium:
            return "medium"
        case .low:
            return "low"
        }
    }
}


struct AddTasksView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss
    
    @State var name: String = ""
    @State var pitch: String=""
    @State var selectedPriority: Priority = .urgent
    @State var completeDate = Date()
    @State var isfinish: Bool = true
   
    var body: some View {
        
        ZStack{
            
            Image("black.jpg")
                .resizable()
                .ignoresSafeArea()
            VStack{
                Form {
                    Section( header:
                                
                                Text("Task")
                        .bold()
                        .font(.headline)
                        .foregroundColor(Color(hue: 0.1, saturation: 0.141, brightness: 0.972))){
                            TextField("New Task", text: $name)
                                .textFieldStyle(.roundedBorder)
                        }
                        .textInputAutocapitalization(.never)
                    
                    // .textFieldStyle(OvalTextFieldStyle())
                    Section( header:
                                
                                Text("Description")
                        .bold()
                        .font(.headline)
                        .foregroundColor(Color(hue: 0.1, saturation: 0.141, brightness: 0.972))){
                            TextField("Description of task", text: $pitch)
                                .textFieldStyle(.roundedBorder)
                        }
                        .textInputAutocapitalization(.never)
                    Section( header:
                                
                                Text("Priority")
                        .bold()
                        .font(.headline)
                        .foregroundColor(Color(hue: 0.1, saturation: 0.141, brightness: 0.972)))
                    {
                            Picker("Priority", selection: $selectedPriority){
                                ForEach(Priority.allCases) { priority in
                                    Text(priority.name).tag(priority)
                                    
                                }
                                
                            }.pickerStyle(.segmented)
                            .colorMultiply(.brown)
                        }
                    Section( header:
                                
                                Text("Date")
                        .bold()
                        .font(.headline)
                        .foregroundColor(Color(hue: 0.1, saturation: 0.141, brightness: 0.972))){
                            
                    DatePicker("Start Date", selection: $completeDate)
                            
                        }
                     //   .datePickerStyle(.graphical)
                        .datePickerStyle(GraphicalDatePickerStyle())
                    
                }.scrollContentBackground(.hidden)
                Button {
                    
                    addItem()
                    dismiss()
                    
                } label: {
                    Text("ADD")
                        .foregroundColor(.white)
                        .bold()
                        .frame(width: 300, height: 35)
                        .overlay(Capsule().stroke(LinearGradient(colors: [.brown, Color(hue: 0.2, saturation: 0.141, brightness: 0.972)], startPoint: .leading, endPoint: .trailing), lineWidth: 10))
                }
                
                
                
            }
        }
        
    }
        
        
        // fonction Add
        private func addItem() {
            withAnimation {
                let newItem = Item(context: viewContext)
                newItem.timestamp = Date()
                newItem.name = name
                newItem.priority = selectedPriority.rawValue
                newItem.pitch = pitch
                newItem.completeDate = Date()
                newItem.isfinish = Bool()
                
                do {
                    try viewContext.save()
                } catch {
                    // Replace this implementation with code to handle the error appropriately.
                    // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    let nsError = error as NSError
                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                }
            }
        }
        
      //
        
    }
    
    struct AddTasksView_Previews: PreviewProvider {
        static var previews: some View {
            AddTasksView()
        }
    }

