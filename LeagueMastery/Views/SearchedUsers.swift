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
    
    var body: some View {
        ScrollView(){
            ForEach(users) { user in
                UserRow(user: user, onRowPress: startSearch)
            }
        }
        .scrollContentBackground(.hidden)
        .frame(maxHeight: 200)
    }
    
    init(sort: SortDescriptor<User>, searchFunc: @escaping (String, String, String, String) -> Void){
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
    }
    
    func onPress(){
        onRowPress(user.name, user.tagline, user.region, user.server)
    }
    
    func toggleFavourite(){
        user.isFavourite.toggle()
    }
}
//
//#Preview {
//    SearchedUsers(sort: SortDescriptor(\User.name))
//}
