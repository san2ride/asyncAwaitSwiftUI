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
    
    @State private var currentDates: [CurrentDate] = []
    
    private func populateDates() async {
        do {
            guard let currentDate = try await getDate() else {
                return
            }
            currentDates.append(currentDate)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    var body: some View {
        NavigationView {
            List(currentDates) { currentDate in
                Text(currentDate.date)
            }.listStyle(.inset)
            .navigationTitle("Dates")
            .navigationBarItems(trailing: Button(action: {
                // button action
                // async context
                Task.init {
                    await populateDates()
                }
            }, label: {
                Image(systemName: "arrow.clockwise.circle")
            }))
            .task {
                await populateDates()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
