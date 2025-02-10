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
    
    var body: some View {
        ScrollView(){
            ForEach(users) { user in
                UserRow(user: user)
            }
        }
        .scrollContentBackground(.hidden)
        .frame(maxHeight: 200)
    }
    
    init(sort: SortDescriptor<User>){
        _users = Query(sort: [sort])
    }
}

struct UserRow: View {
    @Bindable var user: User
    
    var body: some View {
        HStack(){
            Text("\(user.name) #\(user.tagline)")
            Spacer()
            Button(action: toggleFavourite){
                Image(systemName: user.isFavourite ? "star.fill" : "star")
            }
        }
    }
    
    func toggleFavourite(){
        user.isFavourite.toggle()
    }
}

#Preview {
    SearchedUsers(sort: SortDescriptor(\User.name))
}
