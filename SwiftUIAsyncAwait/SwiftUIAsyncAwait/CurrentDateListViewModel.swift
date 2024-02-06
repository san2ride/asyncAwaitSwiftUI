//
//  CurrentDateListViewModel.swift
//  SwiftUIAsyncAwait
//
//  Created by don't touch me on 2/6/24.
//

import Foundation

// using MainActor informs the ViewModel we are on the main thread on the main queue. Therefore no need for DispatchQueue
@MainActor
class CurrentDateListViewModel: ObservableObject {
    
    @Published var currentDates: [CurrentDateViewModel] = []
    
    func populateDates() async {
        do {
            let currentDate = try await WebService().getDate()
            if let currentDate = currentDate {
                let currentDateViewModel = CurrentDateViewModel(currentDate: currentDate)
                currentDates.append(currentDateViewModel)
                // main queue
//                DispatchQueue.main.async {
//                    // use self cause we are inside a closure
//                    self.currentDates.append(currentDateViewModel)
//                }
            }
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
