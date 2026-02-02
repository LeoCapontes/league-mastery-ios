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
    
    init(modelContext: ModelContext, client: APIClient) {
           let viewModel = ViewModel(modelContext: modelContext, client: client)
           _viewModel = State(initialValue: viewModel)
    }
    
    var body: some View {
        ZStack{
            BackgroundImage()
                .brightness(fieldFocused ? -0.1 : 0)
                .animation(.default, value: fieldFocused)
            NavigationStack(path: $viewModel.path){
                GeometryReader{ geo in
                    ZStack(){
                        Title()
                            .brightness(fieldFocused ? -0.1 : 0)
                            .blur(radius: fieldFocused ? 20 : 0)
                            .scaleEffect(fieldFocused ? 0.9 : 1, anchor: .center)
                            .position(
                                x: geo.size.width * 0.5,
                                y: geo.size.height * 0.12
                            )
                        
                        PinnedUser(
                            expandUser: viewModel.setCurrentSummoner(name:tag:region:server:),
                            entries: viewModel.pinnedResponse,
                            user: viewModel.pinnedUser,
                            isSettingUp: $viewModel.settingUpPinned
                        )
                        .fixedSize(horizontal: false, vertical: true)
                        .position(
                            x: geo.size.width * 0.5,
                            y: geo.size.height * 0.76
                        )
                        .brightness(fieldFocused ? -0.1 : 0)
                        .blur(radius: fieldFocused ? 20 : 0)
                        .scaleEffect(fieldFocused ? 0.9 : 1, anchor: .center)
                        
                        
                        SummonerSearchContainer(
                            viewModel: $viewModel,
                            fieldFocused: $fieldFocused,
                            searchSummoner: SearchSummoner,
                            setFavourite: viewModel.setFavouritedUser(_:)
                        )
                        .frame(height: fieldFocused ? geo.size.height * 0.62 : 280)
                        .position(
                            x: geo.size.width * 0.5,
                            y: fieldFocused ? geo.size.height * 0.32 : geo.size.height * 0.4
                        )
                        
                        VStack{
                            Spacer()
                            HStack{
                                Spacer()
                                if #available(iOS 26, *) {
                                    NavigationLink(destination: PreferencesScreen()) {
                                        Image(systemName: "gearshape")
                                            .foregroundStyle(.white)
                                            .padding(10)
                                    }
                                    .buttonBorderShape(.circle)
                                    .buttonStyle(.glass)
                                } else {
                                    NavigationLink(destination: PreferencesScreen()) {
                                        Image(systemName: "gearshape")
                                            .foregroundStyle(.white)
                                            .padding(10)
                                    }
                                    .buttonBorderShape(.circle)
                                }
                            }
                        }
                        
                        .opacity(fieldFocused ? 0 : 1)
                        
                        
                        if(viewModel.showingProgress){
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                .scaleEffect(1.5, anchor: .center)
                        }
                    }
                    .animation(.default, value: fieldFocused)
                }
                .padding(10)
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
                .ignoresSafeArea(.keyboard)
            }
            .alert(viewModel.alertMessage, isPresented : $viewModel.showingAlert){
                Button("OK") {}
            }
            .onChange(of: viewModel.path) { oldPath, newPath in
                // dismiss keyboard when navigating back to this view
                if newPath.isEmpty && !oldPath.isEmpty {
                    fieldFocused = false
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
            }
        }
    }
    
    func SearchSummoner(){
        fieldFocused = false
        viewModel.setCurrentSummoner()
    }
    
}

struct Title: View {
    var body: some View {
        HStack{
            Image("launch_image")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.vertical)
                .frame(maxHeight: 100)
            Text("LEAGUE\nMASTERY")
                .font(.system(size: 36, weight: .heavy, design: .monospaced))
        }
        .foregroundStyle(.white)
    }
}

struct SummonerSearchField: View {
    @Binding var viewModel: ContentView.ViewModel
    @FocusState.Binding var fieldFocused: Bool
    var searchSummoner: () -> Void
    
    var body: some View {
        if #available(iOS 26, *) {
            GlassEffectContainer {
                HStack {
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
                        
                        
                        Divider().overlay(Color.white)
                            .frame(height: 30)
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
                        
                        Picker("Region", selection: $viewModel.selectedServer){
                            ForEach(Server.allCases){ option in
                                Text(String(describing: option))
                            }
                        }
                        .tint(.yellow)
                        .fixedSize()
                        .glassEffect(.regular.interactive())
                    }
                    .focused($fieldFocused)
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    .glassEffect(.regular.interactive())
                    .onTapGesture {
                        fieldFocused = true
                    }
                    
                    Button(action: searchSummoner) {
                        Image(systemName: "magnifyingglass")
                            .padding(10)
                    }
                    .buttonBorderShape(.circle)
                    .buttonStyle(.glass)
                }
                
            }
        } else {
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
                    //                    .border(.green)
                    
                    Picker("Region", selection: $viewModel.selectedServer){
                        ForEach(Server.allCases){ option in
                            Text(String(describing: option))
                        }
                    }
                    .tint(.yellow)
                    .fixedSize()
                }
                .focused($fieldFocused)
                .frame(height: 24)
                .onSubmit {
                    searchSummoner()
                }
                .padding(.horizontal)
                .padding(.vertical, 12)
                .background(Color.gray.opacity(0.2))
                .clipShape(.capsule)
                
                Button(action: searchSummoner) {
                    Image(systemName: "magnifyingglass")
                        .padding(10)
                }
                .buttonBorderShape(.circle)
                .buttonStyle(.plain)
            }
        }
    }
}

struct SummonerSearchContainer: View {
    @Binding var viewModel: ContentView.ViewModel
    @FocusState.Binding var fieldFocused: Bool
    var searchSummoner: () -> Void
    var setFavourite: (User) -> Void
    
    let gradient = LinearGradient(stops: [
        Gradient.Stop(color: .clear, location: 0),
        Gradient.Stop(color: .clear, location: 0.8),
        Gradient.Stop(color: .black.opacity(0.1), location: 1)
    ], startPoint: .top, endPoint: .bottom)
    
    
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
            }
            
            SearchedUsers(
                sort: SortDescriptor(\User.isFavourite, order: .reverse),
                searchFunc: viewModel.setCurrentSummoner(name:tag:region:server:),
                setFavourite: setFavourite,
                clearSearches: viewModel.deleteAllUsers,
                fieldFocused: $fieldFocused
            )
        }
        .foregroundStyle(.white)
        .background(gradient)
        .clipShape(RoundedRectangle(cornerRadius: 20))
//        .optionalGlassEffect()
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
    
    let client = APIClient()
    
    let mockSearchedUsers = [
        User(puuid: "a", name: "Faker", tagline: "KR1", region: "Korea", server: "KR", profileIconId: 1, summonerLevel: 1, masteryScore: 1),
        User(puuid: "b", name: "Chovy", tagline: "KR1", region: "Korea", server: "KR", profileIconId: 1, summonerLevel: 1, masteryScore: 1),
        User(puuid: "c", name: "Bdd", tagline: "KR1", region: "Korea", server: "KR", profileIconId: 1, summonerLevel: 1, masteryScore: 1),
        User(puuid: "d", name: "Zeus", tagline: "KR1", region: "Korea", server: "KR", profileIconId: 1, summonerLevel: 1, masteryScore: 1)
    ]
    
    for user in mockSearchedUsers {
        context.insert(user)
    }
    
    return ContentView(modelContext: container.mainContext, client: client).modelContainer(container)
}
