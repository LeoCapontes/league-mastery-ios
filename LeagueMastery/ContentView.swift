//
//  ContentView.swift
//  LeagueMastery
//
//  Created by Leo Capontes on 29/05/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    let gradient = LinearGradient(
        stops: [
            Gradient.Stop(color: Color.black.opacity(0.2), location: 0.1),
            Gradient.Stop(color: .clear, location: 1)
        ],
        startPoint: .bottom,
        endPoint: .top)
    
    
    @State private var viewModel: ViewModel
    @FocusState private var fieldFocused: Bool
    
    init(modelContext: ModelContext) {
           let viewModel = ViewModel(modelContext: modelContext)
           _viewModel = State(initialValue: viewModel)
   }
    
    var body: some View {
        NavigationStack{
            ZStack{
                Rectangle()
                    .edgesIgnoringSafeArea(.all)
                    .foregroundStyle(Color("BGColor"))
// Old background
//                Image("background-mastery")
//                    .resizable()
//                    .aspectRatio(contentMode: .fill)
//                    .frame(minWidth: 0, maxWidth: .infinity)
//                    .edgesIgnoringSafeArea(.all)
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
                            HStack{
                                TextField(
                                    "",
                                    text: $viewModel.sumName,
                                    prompt: Text("Name")
                                        .foregroundStyle(Color(
                                            red: 150/255,
                                            green: 150/255,
                                            blue: 150/255
                                        ))
                                )
                                .frame(width: 124)
//                                .border(.green)
                                Divider().overlay(Color.white)
                                Text("#")
                                TextField(
                                    "",
                                    text: $viewModel.sumTag,
                                    prompt: Text("Tag")
                                        .foregroundStyle(Color(
                                            red: 150/255,
                                            green: 150/255,
                                            blue: 150/255
                                        ))
                                )
                                .frame(width: 48)
//                                .border(.green)
                            }
                            .frame(height: 24)
                            .focused($fieldFocused)
                            .onSubmit {
                                SearchSummoner()
                            }
                            .padding(.horizontal)
                            .padding(.vertical, viewModel.showingScreen ? 2: 18)
                            
                            
                            Picker("Region", selection: $viewModel.selectedServer){
                                ForEach(Server.allCases){ option in
                                    Text(String(describing: option))
                                }
                            }
                            .padding(0)
//                            .border(.green)
                        }
                        .background(Color.gray
                            .opacity(0.2))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        
                        Button(action: SearchSummoner) {
                            Text("Search")
                        }
                    }
                    .padding(.horizontal, 10)
                    
                    if(!viewModel.showingScreen) {
                        VStack(alignment: .leading){
                            SearchedUsers(
                                sort: SortDescriptor(\User.isFavourite, order: .reverse),
                                searchFunc: viewModel.searchSumm(name:tag:region:server:),
                                clearSearches: viewModel.deleteAllUsers
                            )
                        }
                    }
                    
                    if(viewModel.showingScreen) {
                        AccountScreen(
                            masteryData: viewModel.response!,
                            user: viewModel.userToDisplay!,
                            addToWatchlist: viewModel.addToWatchlist,
                            removeFromWatchlist: viewModel.removeFromWatchlist
                        )
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
                if(viewModel.showingProgress){
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(1.5, anchor: .center)
                }
            }
            .edgesIgnoringSafeArea(.bottom)
        }
        .alert(viewModel.alertMessage, isPresented : $viewModel.showingAlert){
            Button("OK") {}
        }
    }
    
    func SearchSummoner(){
        viewModel.searchSumm()
        fieldFocused = false
    }
}


#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: User.self, configurations: config)
    
    ContentView(modelContext: container.mainContext).modelContainer(container)
}
