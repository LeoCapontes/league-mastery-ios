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
        VStack(alignment: .leading, spacing: 4){
            Text("Previously Searched")
                .font(.headline)
                .padding(.leading, 2)
            ScrollView(){
                VStack(spacing: 0){
                    ForEach(users) { user in
                        UserRow(user: user, onRowPress: startSearch)
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
        .padding(.horizontal)
        .padding(.top, 8)
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
