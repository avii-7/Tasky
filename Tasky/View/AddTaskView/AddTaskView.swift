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
    
    @State private var taskItem = TaskItem.createEmptyTask()
    
    @Binding var refreshList: Bool
    
    @State private var showDiscardAlert = false
    
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
                    DatePicker("Task date", selection: $taskItem.finishedDate, in: viewModel.pickerDateRange)
                } header: {
                    Text("Task date/time")
                }
            }
            .navigationTitle("Add Task")
            .toolbar{
                ToolbarItem(placement: .topBarLeading) {
                    
                    Button("Cancel") {
                        if taskItem.name.isEmpty == false || taskItem.description.isEmpty == false {
                            showDiscardAlert = true
                        }
                        else {
                            showAddTaskView = false
                        }
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add") {
                        if viewModel.addTask(taskItem) {
                            refreshList.toggle()
                        }
                        showAddTaskView = false
                    }
                    .disabled(taskItem.name.isEmpty)
                }
            }
            .alert("Save task", isPresented: $showDiscardAlert, actions: {
                Button(role: .cancel) {
                    showAddTaskView = false
                } label: {
                    Text("Cancel")
                }
                Button {
                    if viewModel.addTask(taskItem) {
                        refreshList.toggle()
                    }
                    
                    showAddTaskView = false
                } label: {
                    Text("Save")
                }
            }, message: {
                Text("Would you like to save this task ?")
            })
        }
    }
}

#Preview {
    AddTaskView(
        viewModel: TaskViewModelFactory.createTaskViewModel(),
        showAddTaskView: .constant(true),
        refreshList: .constant(false)
    )
}
