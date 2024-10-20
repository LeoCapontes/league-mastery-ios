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
        NavigationStack{
            ZStack{
                Image("background-mastery")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    HStack{
                        HStack{
                            TextField(
                                "Summoner name",
                                text: $viewModel.sumName
                            ).onSubmit {
                                viewModel.searchSumm()
                            }
                            .padding()
                            
                            Picker("Region", selection: $viewModel.selectedRegion){
                                ForEach(region.allCases){ option in
                                    Text(String(describing: option))
                                }
                            }
                        }
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        
                        Button(action: viewModel.searchSumm) {
                            Text("Search")
                        }
                    }
                    
                    if(viewModel.showingScreen) {
                        AccountScreen(masteryData: viewModel.response!)
                            .transition(.slide)
                    }
                }
                .padding(10)
                .foregroundColor(.white)
                .edgesIgnoringSafeArea(.bottom)
                .animation(.default, value: viewModel.showingScreen)
            }
        }
    }
}

#Preview {
    ContentView()
}
