//
//  ContentView.swift
//  SwiftUIAsyncAwait
//
//  Created by don't touch me on 2/6/24.
//

import SwiftUI

struct CurrentDate: Decodable, Identifiable {
    let id = UUID()
    let date: String
    
    private enum CodingKeys: String, CodingKey {
        case date = "date"
    }
}

struct ContentView: View {
    
    @StateObject private var currentDateListVM = CurrentDateListViewModel()
    
    var body: some View {
        NavigationView {
            List(currentDateListVM.currentDates, id: \.id) { currentDate in
                Text(currentDate.date)
            }.listStyle(.inset)
            .navigationTitle("Dates")
            .navigationBarItems(trailing: Button(action: {
                // button action
                // async context
                Task.init {
                    await currentDateListVM.populateDates()
                }
            }, label: {
                Image(systemName: "arrow.clockwise.circle")
            }))
            // task modifier
            .task {
                await currentDateListVM.populateDates()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
