//
//  WeekView.swift
//  Capstone4
//
//  Created by Maria Silva on 2/9/23.
//

import SwiftUI
import Firebase

struct WeeksView: View {
    @State private var showAddWeekView = false
    @State private var showProfileView = false
    @State private var completed = false
    @ObservedObject var model = ViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                VStack {
                    HStack(alignment: .center) {
                        Text("Your prenatal visits")
                            .font(.title3).bold()
                            .padding()
                        .frame(maxWidth: .infinity)
                        Button {
                            showProfileView.toggle()
                        } label: {
                            ZStack {
                                Circle()
                                    .foregroundColor(.teal)
                                    .frame(width: 50, height: 50, alignment: .center)
                                Image(systemName: "person.fill")
                                    .foregroundColor(.white)
                                    .font(.system(size: 24, weight: .medium, design: .rounded))
                            }
                            .padding(.horizontal)
                        }
                        
                    }
                    List {
                        ForEach(model.weeks.sorted {$0.title < $1.title}) {week in
                            NavigationLink {
                                LabListView(week: week)
                            } label: {
                                WeeksRow(week: week)
                                    .onTapGesture {
                                        completed ? model.updateDataFalse(weekToUpdate: week) : model.updateData(weekToUpdate: week)
                                        completed = !completed
                                    }
                                    .frame(maxWidth: .infinity, maxHeight: 100, alignment: .leading)
                                    .swipeActions(edge: .trailing) {
                                        Button(role: .destructive) {
                                            model.deleteData(weekToDelete: week)
                                        } label: {
                                            Label("Delete", systemImage: "trash")
                                        }
                                    }
                            }
                            
                        }
                        
                    }
                    
                }
                ButtonAddNew()
                    .padding()
                    .onTapGesture {
                        showAddWeekView.toggle()
                    }
            }
            .sheet(isPresented: $showAddWeekView) {
                AddWeekView()
                
            }
            .fullScreenCover(isPresented: $showProfileView) {
                ProfileView()
            }
            
        }
    }
    init() {
        model.getData()
    }
    
}

struct WeeksView_Previews: PreviewProvider {
    static var previews: some View {
        WeeksView()
    }
}
