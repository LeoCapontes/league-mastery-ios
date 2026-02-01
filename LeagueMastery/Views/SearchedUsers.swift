//
//  SwiftUIView.swift
//  LeagueMastery
//
//  Created by Leo Capontes on 10/02/2025.
//

import SwiftUI
import SwiftData
import OSLog

struct SearchedUsers: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: [SortDescriptor(\User.isFavourite)]) var users: [User]
    
    @FocusState.Binding var fieldFocused: Bool
    
    var startSearch: (String, String, String, String) -> Void
    var clearSearches: () -> Void
    var setFavourite: (User) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4){
            if #available(iOS 26, *){
                HStack{
                    Text("Previously Searched")
                        .font(.headline)
                        .padding(.leading, 2)
                    Spacer()
                    DeleteButton(deleteFunc: clearSearches)
                }
                .padding(.horizontal, 6)
                ScrollView(){
                    VStack(spacing: 0){
                        ForEach(users) { user in
                            UserRow(
                                user: user,
                                onRowPress: startSearch,
                                setFavourite: setFavourite
                            )
                            .onTapGesture {
                                fieldFocused = false
                                Logger.views.debug("Search field unfocused")
                            }
                            Divider()
                        }
                    }
                }
                .scrollContentBackground(.hidden)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .animation(.default, value: users)
            } else {
                HStack{
                    Text("Previously Searched")
                        .font(.headline)
                        .padding(.leading, 2)
                    Spacer()
                    DeleteButton(deleteFunc: clearSearches)
                }
                .padding(.horizontal, 6)
                ScrollView(){
                    VStack(spacing: 0){
                        ForEach(users) { user in
                            UserRow(
                                user: user,
                                onRowPress: startSearch,
                                setFavourite: setFavourite
                            )
                            .onTapGesture {
                                fieldFocused = false
                                Logger.views.debug("Search field unfocused")
                            }
                            Divider()
                        }
                    }
                }
                .scrollContentBackground(.hidden)
                .background(Color.gray.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .animation(.default, value: users)
            }
        }
    }
    
    init(
        sort: SortDescriptor<User>,
        searchFunc: @escaping (String, String, String, String) -> Void,
        setFavourite: @escaping (User) -> Void,
        clearSearches: @escaping () -> Void,
        fieldFocused: FocusState<Bool>.Binding
    ) {
        self.clearSearches = clearSearches
        self.startSearch = searchFunc
        self.setFavourite = setFavourite
        _users = Query(sort: [sort])
        self._fieldFocused = fieldFocused
    }
}

struct UserRow: View {
    @Bindable var user: User
    var onRowPress: (String, String, String, String) -> Void
    var setFavourite: (User) -> Void
    
    var body: some View {
        HStack(){
            Button(action: onPress){
                Text("\(user.name) #\(user.tagline)")
            }
            Spacer()
            Button(action: { setFavourite(user) }){
                Image(systemName: user.isFavourite ? "star.fill" : "star")
                    .foregroundStyle(user.isFavourite ? .yellow : .white)
            }
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 14)
    }
    
    func onPress(){
        onRowPress(user.name, user.tagline, user.region, user.server)
    }
    
    func toggleFavourite(){
        user.isFavourite.toggle()
    }
}

struct DeleteButton: View {
    var deleteFunc: () -> Void
    
    var body: some View {
        Button(action: deleteFunc){
            Image(systemName: "trash")
        }
        .frame(width: 32, height: 32)
    }
}

//
//#Preview {
//    SearchedUsers(sort: SortDescriptor(\User.name))
//}
