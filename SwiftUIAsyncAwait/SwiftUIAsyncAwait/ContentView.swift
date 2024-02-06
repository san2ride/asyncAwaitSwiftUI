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
    
    // fuction must be async
    private func getDate() async throws -> CurrentDate? {
        
        guard let url = URL(string:
            "https://ember-sparkly-rule.glitch.me/current-date") else {
            fatalError("Webiste broken!")
        }
        // URLSession must be labeld await
        let (data, _) = try await URLSession.shared.data(from: url)
        // try? insures any issues with decoding, returns nil
        return try? JSONDecoder().decode(CurrentDate.self, from: data)
    }
    
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
