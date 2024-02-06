//
//  WebService.swift
//  SwiftUIAsyncAwait
//
//  Created by don't touch me on 2/6/24.
//

import Foundation

class WebService {
    
    // fuction must be async
    func getDate() async throws -> CurrentDate? {
        
        guard let url = URL(string:
            "https://ember-sparkly-rule.glitch.me/current-date") else {
            fatalError("Webiste broken!")
        }
        // URLSession must be labeld await
        let (data, _) = try await URLSession.shared.data(from: url)
        // try? insures any issues with decoding, returns nil
        return try? JSONDecoder().decode(CurrentDate.self, from: data)
    }
}
