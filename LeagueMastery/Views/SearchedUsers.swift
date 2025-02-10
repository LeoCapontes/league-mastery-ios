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
    @Query(sort: [SortDescriptor(\User.name)]) var users: [User]
    
    var body: some View {
        List(){
            ForEach(users) { user in
                Text("\(user.name) #\(user.tagline)")
            }
        }.scrollContentBackground(.hidden)
    }
    
    init(sort: SortDescriptor<User>){
        _users = Query(sort: [sort])
    }
}

#Preview {
    SearchedUsers(sort: SortDescriptor(\User.name))
}
