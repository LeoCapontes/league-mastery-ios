//
//  ContentView.swift
//  LeagueMastery
//
//  Created by Leo Capontes on 29/05/2024.
//

import SwiftUI

struct ContentView: View {
    let gradient = LinearGradient(
        stops: [
            Gradient.Stop(color: Color.black.opacity(0.2), location: 0.1),
            Gradient.Stop(color: .clear, location: 1)
        ],
        startPoint: .bottom,
        endPoint: .top)
    
    
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
                            .padding(.horizontal)
                            .padding(.vertical, 12)
                            
                            
                            Picker("Region", selection: $viewModel.selectedServer){
                                ForEach(server.allCases){ option in
                                    Text(String(describing: option))
                                }
                            }
                        }
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        
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
                
                if(viewModel.showingScreen) {
                    VStack{
                        Spacer()
                        Rectangle()
                            .frame(height: 84)
                            .foregroundStyle(gradient)
                    }.allowsHitTesting(false)
                }
            }
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

#Preview {
    ContentView()
}
