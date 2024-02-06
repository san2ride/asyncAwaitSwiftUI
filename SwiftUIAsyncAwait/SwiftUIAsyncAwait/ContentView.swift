//
//  ContentView.swift
//  SwiftUIAsyncAwait
//
//  Created by don't touch me on 2/6/24.
//

import SwiftUI




struct ContentView: View {
    var body: some View {
        NavigationView {
            List(1...10, id: \.self) { index in
                Text("\(index)")
            }.listStyle(.inset)
                .navigationTitle("Dates")
                .navigationBarItems(trailing: Button(action: {
                    // button action
                }, label: {
                    Image(systemName: "arrow.clockwise.circle")
                }))
        }
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
