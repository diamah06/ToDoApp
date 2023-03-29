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
           return "Urgent"
        case .medium:
            return "Medium"
        case .low:
            return "Low"
        }
    }
}


struct AddTasksView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss
    
    @State var name: String = ""
    @State var pitch: String=""
    @State var selectedPriority: Priority = .urgent
    @State var completeDate = Date.now
    @State var isfinish: Bool = true
    @ObservedObject var taskVM = TaskViewModel()
    
    //pour test unit
    
    
    var body: some View {
        
        ZStack{
            
            Image("black.jpg")
                .resizable()
                .ignoresSafeArea()
            VStack{
                Form {
                    Section( header:
                                
                                Text("Task")
                        .accessibilityIdentifier("Task")
                        .bold()
                        .font(.headline)
                        .foregroundColor(Color(hue: 0.1, saturation: 0.141, brightness: 0.972))
                        .accessibilityLabel(/*@START_MENU_TOKEN@*/"Label"/*@END_MENU_TOKEN@*/)){
                            TextField("New Task", text: $name)
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
                        .accessibilityLabel(/*@START_MENU_TOKEN@*/"Label"/*@END_MENU_TOKEN@*/))
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
                            
                    DatePicker("Date", selection: $completeDate, displayedComponents: .date)
                    DatePicker("Time", selection: $completeDate, displayedComponents: .hourAndMinute)
                                .accessibilityIdentifier("DatePicker")
                        }
                    
                    
                    
                    
                        //.datePickerStyle(.graphical)
                        .datePickerStyle(GraphicalDatePickerStyle())
                    
                }.scrollContentBackground(.hidden)
                Button {
                    
                    taskVM.addItem(name: name,pitch: pitch, selectedPriority: selectedPriority, completeDate: completeDate, isfinish: true, viewContext: viewContext)
                    
                    
                    dismiss()
                    
                } label: {
                    Text("ADD")
                        .accessibilityIdentifier("text")
                        .foregroundColor(.white)
                        .bold()
                        .frame(width: 300, height: 35)
                        .overlay(Capsule().stroke(LinearGradient(colors: [.brown, Color(hue: 0.2, saturation: 0.141, brightness: 0.972)], startPoint: .leading, endPoint: .trailing), lineWidth: 10))
                       
                }
                .disabled(name.isEmpty)
                .accessibilityIdentifier("ButtonAdd")
                
            }
        }
        
    }
        
        
        // fonction Add
        // func addItem() {
        //    withAnimation {
        //        let newItem = Item(context: viewContext)
         //       newItem.name = name
          //      newItem.priority = selectedPriority.rawValue
          //      newItem.pitch = pitch
          //      newItem.completeDate = completeDate
           //     newItem.isfinish = Bool()
                
           //     do {
            //        try viewContext.save()
             //   } catch {
                    
              //      let nsError = error as NSError
              //      fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
             //   }
          //  }
        //}
        
      //
        
    }
    
    struct AddTasksView_Previews: PreviewProvider {
        static var previews: some View {
            AddTasksView()
        }
    }

