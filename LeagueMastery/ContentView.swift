//
//  ContentView.swift
//  LeagueMastery
//
//  Created by Leo Capontes on 29/05/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            TextField(
                "Summoner name",
                text: $viewModel.sumName)
        }
        .padding()
        Button(action: viewModel.searchSumm) {
            Text("Search")
        }
        AsyncImage(url: URL(string: viewModel.splashUrl))
    }
    
    
}

#Preview {
    ContentView()
}
