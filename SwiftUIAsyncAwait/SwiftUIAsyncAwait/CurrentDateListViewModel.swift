//
//  CurrentDateListViewModel.swift
//  SwiftUIAsyncAwait
//
//  Created by don't touch me on 2/6/24.
//

import Foundation

class CurrentDateListViewModel: ObservableObject {
    
    @Published var currentDates: [CurrentDateViewModel] = []
    
    func getAllDates() async throws {
        do {
            let currentDate = try await WebService().getDate()
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct CurrentDateViewModel {
    let currentDate: CurrentDate
    
    var id: UUID {
        currentDate.id
    }
    
    var date: String {
        currentDate.date
    }
}
