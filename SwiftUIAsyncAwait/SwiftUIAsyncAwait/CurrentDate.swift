//
//  CurrentDate.swift
//  SwiftUIAsyncAwait
//
//  Created by don't touch me on 2/6/24.
//

import Foundation

struct CurrentDate: Decodable, Identifiable {
    let id = UUID()
    let date: String
    
    private enum CodingKeys: String, CodingKey {
        case date = "date"
    }
}
