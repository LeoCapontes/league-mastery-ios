//
//  ContentView.swift
//  LeagueMastery
//
//  Created by Leo Capontes on 29/05/2024.
//

import SwiftUI
import SwiftData
import Variablur

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
        ZStack{
            BackgroundImage()
            NavigationStack(path: $viewModel.path){
                ZStack{
                    VStack{
                        Spacer()
                        HStack{
                            Spacer()
                            NavigationLink(destination: PreferencesScreen()) {
                                Image(systemName: "gearshape.fill")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 24))
                            }
                        }
                        .padding(24)
                    }
                    VStack{
                        HStack{
                            SummonerSearchField(
                                viewModel: $viewModel,
                                fieldFocused: $fieldFocused,
                                searchSummoner: SearchSummoner
                            )
                            
                            Button(action: SearchSummoner) {
                                Text("Search")
                            }
                        }
                        .padding(.horizontal, 10)
                        
                        VStack(alignment: .leading){
                            SearchedUsers(
                                sort: SortDescriptor(\User.isFavourite, order: .reverse),
                                searchFunc: viewModel.searchSumm(name:tag:region:server:),
                                clearSearches: viewModel.deleteAllUsers
                            )
                        }
                    }
                    .foregroundColor(.white)
                    .allowsHitTesting( viewModel.showingProgress ? false : true)
                    .ignoresSafeArea(.container, edges: .bottom)
                    .animation(.default, value: viewModel.showingScreen)
                    
                    //                if(viewModel.showingScreen) {
                    //                    VStack{
                    //                        Spacer()
                    //                        Rectangle()
                    //                            .frame(height: 84)
                    //                            .foregroundStyle(gradient)
                    //                    }.allowsHitTesting(false)
                    //                }
                    if(viewModel.showingProgress){
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .scaleEffect(1.5, anchor: .center)
                    }
                }
                .ignoresSafeArea(.container, edges: .bottom)
                .navigationDestination(for: Route.self) { route in
                    switch route{
                    case .account:
                        AccountScreen(
                            masteryData: viewModel.response!,
                            user: viewModel.userToDisplay ?? mockUser,
                            addToWatchlist: viewModel.addToWatchlist,
                            removeFromWatchlist: viewModel.removeFromWatchlist
                        )
                    case .champion(let masteryResponse):
                        ChampionScreen(championData: masteryResponse)
                    }
                    
                }
                .containerBackground(.clear, for: .navigation)
            }
            .alert(viewModel.alertMessage, isPresented : $viewModel.showingAlert){
                Button("OK") {}
            }
        }
    }
    
    func SearchSummoner(){
        viewModel.searchSumm()
        fieldFocused = false
    }
    
}

struct SummonerSearchField: View {
    @Binding var viewModel: ContentView.ViewModel
    @FocusState.Binding var fieldFocused: Bool
    var searchSummoner: () -> Void
    
    var body: some View {
        GeometryReader { geo in
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
                    .frame(width: geo.size.width*0.3)
//                    .border(.green)
                    
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
                    .frame(width: geo.size.width*0.2)
//                    .border(.green)
                }
                .frame(height: 24)
                .focused($fieldFocused)
                .onSubmit {
                    searchSummoner()
                }
//                .padding(.horizontal)
                .padding(.vertical, 12)
                
                
                Picker("Region", selection: $viewModel.selectedServer){
                    ForEach(Server.allCases){ option in
                        Text(String(describing: option))
                    }
                }
                .frame(minWidth: 86)
                .padding(0)
//                .border(.green)
            }
            .position(
                x: geo.size.width*0.5,
                y: geo.size.height*0.5)
            .background(Color.gray
                .opacity(0.2))
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .frame(height: 64)
    }
}

struct BackgroundImage: View{
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    var body: some View {
        Image("background-mastery")
            .resizable()
            .brightness(colorScheme == .light ? 0 : -0.05)
            .saturation(colorScheme == .light ? 1 : 1)
            .aspectRatio(contentMode: .fill)
            .frame(minWidth: 0, maxWidth: .infinity)
            .edgesIgnoringSafeArea(.all)
            .variableBlur(radius: 200) { geometryProxy, context in
                // add a blur to the mask to smooth out where the variable blur begins
                context.addFilter(.blur(radius: 30))
                context.fill(
                    Path(CGRect(origin: .zero, size: geometryProxy.size)),
                    with: .color(.white)
                )
            }
            .allowsHitTesting(false)
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: User.self, configurations: config)
    
    ContentView(modelContext: container.mainContext).modelContainer(container)
}
