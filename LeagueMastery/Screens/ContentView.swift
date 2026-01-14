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
    @State private var viewModel: ViewModel
    @FocusState private var fieldFocused: Bool
    
    var searchContainerHeight: Double = 275
    
    init(modelContext: ModelContext) {
           let viewModel = ViewModel(modelContext: modelContext)
           _viewModel = State(initialValue: viewModel)
    }
    
    var body: some View {
        ZStack{
            BackgroundImage()
            NavigationStack(path: $viewModel.path){
                ZStack(){
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
                            Image("launch_image")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding(.vertical, 12)
                            Text("LEAGUE\nMASTERY")
                                .font(.system(size: 36, weight: .heavy, design: .monospaced))
                        }
                        .frame(maxHeight: 100)
                        
                        // makes space for search field container above it in the ZStack
                        Rectangle()
                            .frame(height: searchContainerHeight)
                            .opacity(0)
                        
                        if (viewModel.pinnedUser != nil) {
                            PinnedUser(
                                entries: viewModel.pinnedResponse ?? mockMasteryResponse,
                                user: viewModel.pinnedUser ?? User(
                                    puuid: "d",
                                    name: "Hide on Bush",
                                    tagline: "KR1",
                                    region: "Korea",
                                    server: "Asia",
                                    profileIconId: 1,
                                    summonerLevel: 999,
                                    masteryScore: 999
                                )
                            )
                            .frame(height: 186)
                            .padding(.vertical)
                        }
                    }
                    .foregroundColor(.white)
                    .allowsHitTesting( viewModel.showingProgress || fieldFocused ? false : true)
                    .ignoresSafeArea(.container, edges: .bottom)
                    .animation(.default, value: viewModel.showingScreen)
                    .offset(y: -50)
                    .opacity(fieldFocused ? 0 : 1)
                    .animation(.snappy, value: fieldFocused)
                    
//                    Rectangle()
//                        .foregroundStyle(.black.opacity(fieldFocused ? 0.95 : 0))
                    
                    
                    SummonerSearchContainer(
                        viewModel: $viewModel,
                        fieldFocused: $fieldFocused,
                        searchSummoner: SearchSummoner
                    )
                    .frame(maxHeight: fieldFocused ? 550 : searchContainerHeight)
                    .ignoresSafeArea(.container, edges: .bottom)
                    .offset(y: viewModel.pinnedUser == nil ? 0 : -110)
                    .animation(.snappy, value: fieldFocused)
                    
                    if(viewModel.showingProgress){
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .scaleEffect(1.5, anchor: .center)
                    }
                }
                .ignoresSafeArea(edges: .all)
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
                .onAppear {
                    viewModel.setupPinnedUser()
                }
            }
            .alert(viewModel.alertMessage, isPresented : $viewModel.showingAlert){
                Button("OK") {}
            }
            
        }
    }
    
    func SearchSummoner(){
        fieldFocused = false
        viewModel.setCurrentSummoner()
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

struct SummonerSearchContainer: View {
    @Binding var viewModel: ContentView.ViewModel
    @FocusState.Binding var fieldFocused: Bool
    var searchSummoner: () -> Void
    
    
    var body: some View {
        VStack{
            HStack{
                if (fieldFocused) {
                    Button(action: {fieldFocused = false}) {
                        Image(systemName: "chevron.left")
                            .bold()
                    }
                    .padding(.horizontal)
                }
                SummonerSearchField(
                    viewModel: $viewModel,
                    fieldFocused: $fieldFocused,
                    searchSummoner: searchSummoner
                )
                
                Button(action: searchSummoner) {
                    Text("Search")
                }
            }
            
            SearchedUsers(
                sort: SortDescriptor(\User.isFavourite, order: .reverse),
                searchFunc: viewModel.setCurrentSummoner(name:tag:region:server:),
                clearSearches: viewModel.deleteAllUsers,
                fieldFocused: $fieldFocused
            )
        }
        .foregroundStyle(.white)
        .padding()
    }
}

struct BackgroundImage: View{
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    var body: some View {
        ZStack{
            Color(.black)
                .edgesIgnoringSafeArea(.all)
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
}

#Preview {
    let config = ModelConfiguration(for: User.self, isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: User.self, configurations: config)
    let context = container.mainContext
    
    let mockSearchedUsers = [
        User(puuid: "a", name: "Faker", tagline: "KR1", region: "Korea", server: "KR", profileIconId: 1, summonerLevel: 1, masteryScore: 1),
        User(puuid: "b", name: "Chovy", tagline: "KR1", region: "Korea", server: "KR", profileIconId: 1, summonerLevel: 1, masteryScore: 1),
        User(puuid: "c", name: "Bdd", tagline: "KR1", region: "Korea", server: "KR", profileIconId: 1, summonerLevel: 1, masteryScore: 1),
        User(puuid: "d", name: "Zeus", tagline: "KR1", region: "Korea", server: "KR", profileIconId: 1, summonerLevel: 1, masteryScore: 1)
    ]
    
    for user in mockSearchedUsers {
        context.insert(user)
    }
    
    return ContentView(modelContext: container.mainContext).modelContainer(container)
}
