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
            HStack{
                TextField(
                    "Summoner name",
                    text: $viewModel.sumName
                )
                .padding()
                Picker("Region", selection: $viewModel.selectedRegion){
                    ForEach(region.allCases){ option in
                        Text(String(describing: option))
                    }
                }
            }
            Button(action: viewModel.searchSumm) {
                Text("Search")
            }
            if(viewModel.showingScreen) {
                AccountScreen(masteryData: viewModel.response!)
            }
        }
    }
}

#Preview {
    ContentView()
}
