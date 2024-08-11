//
//  TaskDetailView.swift
//  Tasky
//
//  Created by Arun on 07/08/24.
//

import SwiftUI

struct TaskDetailView: View {
    
    @Binding var taskItem: TaskItem
    
    @Binding var showTaskDetailView: Bool
    
    @ObservedObject var viewModel: TaskViewModel
    
    @Binding var refreshList: Bool
    
    @State private var showDeleteAlert = false
    
    var body: some View {
        
        NavigationStack {
            
            List {
                Section {
                    TextField("Task name", text: $taskItem.name)
                        .font(.title3)
                        .fontWeight(.semibold)
                    
                    TextEditor(text: $taskItem.description)
                        .font(.body)
                                                
                    Toggle("Mark complete", isOn: $taskItem.isCompleted)
                }
                
                Section {
                    DatePicker("Task date", selection: $taskItem.finishedDate, in: viewModel.pickerDateRange)
                } header: {
                    Text("Date/time")
                }
                
                Section {
                    Button("Delete", role: .destructive) {
                        showDeleteAlert = true
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .navigationTitle("Task Details")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        showTaskDetailView = false
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Update") {
                        if viewModel.updateTask(taskItem) {
                            print("Update success !")
                            refreshList.toggle()
                        }
                        showTaskDetailView = false
                    }.disabled(taskItem.name.isEmpty)
                }
            }
            .alert("Delete task", isPresented: $showDeleteAlert) {
                Button("No", role: .cancel) { }
                
                Button("Yes", role: .destructive) {
                    if viewModel.deleteTask(taskItem) {
                        refreshList.toggle()
                    }
                    showTaskDetailView = false
                }
            }
            message: {
                Text("Would you like to delete the task ?")
            }
        }
    }
}

#Preview {
    TaskDetailView(
        taskItem: .constant(
            TaskItem(
                id: 0,
                name: "Workout",
                description: "Workout for 10 minutes.",
                isCompleted: false,
                finishedDate: .now
            )
        ),
        showTaskDetailView: .constant(true),
        viewModel: TaskViewModel(),
        refreshList: .constant(false)
    )
}
