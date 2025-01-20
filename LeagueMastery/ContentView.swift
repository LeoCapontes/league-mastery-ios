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
    @FocusState private var fieldFocused: Bool
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
                        if(viewModel.showingScreen) {
                            Button(action: {viewModel.showingScreen = false}){
                                Image(systemName: "chevron.backward")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width:12)
                                    .padding(.horizontal)
                                    .foregroundStyle(.white)
                            }
                            .transition(.opacity)
                       }
                        HStack{
                            TextField(
                                "",
                                text: $viewModel.sumName,
                                prompt: Text("Summoner name")
                                    .foregroundStyle(Color(
                                        red: 150/255,
                                        green: 150/255,
                                        blue: 150/255
                                    ))
                            ).focused($fieldFocused)
                            .onSubmit {
                                SearchSummoner()
                            }
                            .padding(.horizontal)
                            .padding(.vertical, viewModel.showingScreen ? 2: 18)
                            
                            
                            Picker("Region", selection: $viewModel.selectedServer){
                                ForEach(server.allCases){ option in
                                    Text(String(describing: option))
                                }
                            }
                        }
                        .background(Color.gray
                            .opacity(0.2))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        
                        Button(action: SearchSummoner) {
                            Text("Search")
                        }
                    }
                    .padding(.horizontal, 10)
                    
                    if(viewModel.showingScreen) {
                        AccountScreen(masteryData: viewModel.response!)
                            .transition(.slide)
                    }
                }
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
    
    func SearchSummoner(){
        viewModel.searchSumm()
        fieldFocused = false
    }
}


#Preview {
    ContentView()
}
