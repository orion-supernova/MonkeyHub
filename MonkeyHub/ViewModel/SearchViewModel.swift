//
//  SearchViewModel.swift
//  MonkeyHub
//
//  Created by Murat Can KOÇ on 26.05.2021.
//

import SwiftUI

class SearchViewModel: ObservableObject {

    @Published var users = [User]()

    init() {
        fetchUsers()
    }

    func fetchUsers() {
        COLLECTION_USERS.getDocuments { snapshot, error in
            if error != nil {
                print("Failed to fetch users \(error!.localizedDescription)")
            }
            guard let documents = snapshot?.documents else { return }
            self.users = documents.compactMap({ try? $0.data(as: User.self) })

        }
    }

    func filteredUsers(query: String) -> [User] {
        let lowercasedQuery = query.lowercased()
        return users.filter {( $0.fullname.lowercased().contains(lowercasedQuery) || $0.username.lowercased().contains(lowercasedQuery) )}
    }

}
