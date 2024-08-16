//
//  HomeView.swift
//  Tasky
//
//  Created by Arun on 07/08/24.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var viewModel = TaskViewModelFactory.createTaskViewModel()
    
    private let filters = ["Active", "Completed"]
    
    @State private var currentFilter = "Active"
    
    @State private var showAddTaskView = false
    
    @State private var showTaskDetailView = false
    
    @State private var refreshList = false
    
    @State private var selectedTask = TaskItem.createEmptyTask()
    
    var body: some View {
        
        NavigationStack {
            
            Picker("Choose filter", selection: $currentFilter) {
                ForEach(filters, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(.segmented)
            .onChange(of: currentFilter) {
                viewModel.showTasks(isCompleted: currentFilter == "Completed")
            }
            
            List(viewModel.taskItems, id: \.id) { item in
                VStack (alignment: .leading) {
                    Text(item.name).font(.title)
                    
                    HStack  {
                        Text(item.description).font(.body).lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                        Spacer()
                        Text(item.finishedDate.toTaskDate())
                    }
                }.onTapGesture {
                    selectedTask = item
                    showTaskDetailView = true
                }
            }
            .onAppear {
                viewModel.showTasks(isCompleted: currentFilter == "Completed")
            }
            .onChange(of: refreshList, {
                viewModel.showTasks(isCompleted: currentFilter == "Completed")
                print("On change")
            })
            .listStyle(.plain)
            .navigationTitle("Home View")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showAddTaskView = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showTaskDetailView,
                   content: {
                
                TaskDetailView(
                    taskItem: $selectedTask,
                    showTaskDetailView: $showTaskDetailView,
                    viewModel: viewModel,
                    refreshList: $refreshList)
            })
            .sheet(isPresented: $showAddTaskView) {
                AddTaskView(viewModel: viewModel, showAddTaskView: $showAddTaskView, refreshList: $refreshList)
            }
        }
    }
}

#Preview {
    HomeView()
}
