//
//  AddTaskView.swift
//  Tasky
//
//  Created by Arun on 07/08/24.
//

import SwiftUI

struct AddTaskView: View {
    
    @ObservedObject var viewModel: TaskViewModel
    
    @Binding var showAddTaskView: Bool
    
    @State private var taskItem = TaskItem(
        id: 0,
        name: "",
        description: "",
        isCompleted: false,
        finishedDate: .now
    )
    
    @Binding var refreshList: Bool
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField("Task name", text: $taskItem.name)
                        .font(.title3)
                    TextEditor(text: $taskItem.description)
                        .font(.body)
                    
                } header: {
                    Text("Task Details")
                }
                
                Section {
                    DatePicker("Task date", selection: $taskItem.finishedDate)
                } header: {
                    Text("Task date/time")
                }
                
                Section {
                    Button("Delete", role: .destructive) {
                        if viewModel.deleteTask(taskItem) {
                            print("Deletion Success !")
                            refreshList.toggle()
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .navigationTitle("Add Task")
            .toolbar{
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        showAddTaskView = false
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add") {
                        viewModel.addTask(taskItem)
                        print("Add success !")
                        refreshList.toggle()
                        showAddTaskView = false
                    }
                }
            }
        }
    }
}

#Preview {
    AddTaskView(
        viewModel: TaskViewModel(),
        showAddTaskView: .constant(true),
        refreshList: .constant(false)
    )
}
