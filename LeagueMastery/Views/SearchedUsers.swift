//
//  SwiftUIView.swift
//  LeagueMastery
//
//  Created by Leo Capontes on 10/02/2025.
//

import SwiftUI
import SwiftData

struct SearchedUsers: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: [SortDescriptor(\User.isFavourite)]) var users: [User]
    
    var startSearch: (String, String, String, String) -> Void
    var clearSearches: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4){
            HStack{
                Text("Previously Searched")
                    .font(.headline)
                    .padding(.leading, 2)
                Spacer()
                DeleteButton(deleteFunc: clearSearches)
            }
            ScrollView(){
                VStack(spacing: 0){
                    ForEach(users) { user in
                        UserRow(user: user, onRowPress: startSearch)
                        Divider()
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .background(Color.gray.opacity(0.2))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .frame(maxHeight: 200)
            .animation(.default, value: users)
        }
        .padding()
    }
    
    init(
        sort: SortDescriptor<User>,
        searchFunc: @escaping (String, String, String, String) -> Void,
        clearSearches: @escaping () -> Void
    ) {
        self.clearSearches = clearSearches
        self.startSearch = searchFunc
        _users = Query(sort: [sort])
    }
}

struct UserRow: View {
    @Bindable var user: User
    var onRowPress: (String, String, String, String) -> Void
    
    var body: some View {
        HStack(){
            Button(action: onPress){
                Text("\(user.name) #\(user.tagline)")
            }
            Spacer()
            Button(action: toggleFavourite){
                Image(systemName: user.isFavourite ? "star.fill" : "star")
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
