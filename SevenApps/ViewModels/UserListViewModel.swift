//
//  UserListViewModel.swift
//  SevenApps
//
//  Created by Ömer Firat on 4.02.2025.
//

import Foundation

class UserListViewModel {
    private var users: [UserModel] = []  // Store the list of users
    var reloadData: (() -> Void)?  // Closure to notify when the data is updated
    
    // Fetch users from the network
    func fetchUsers() {
        NetworkManager.shared.request(router: .getUsers) { (result: Result<[UserModel], NetworkError>) in
            switch result {
            case .success(let fetchedUsers):
                self.users = fetchedUsers  // Store the fetched users
                self.reloadData?()  // Trigger reloadData to update the UI
            case .failure(_): break  // Handle failure (no action taken here)
            }
        }
    }
    
    // Return the number of users
    func numberOfRows() -> Int {
        return users.count
    }
    
    // Return the user at a specific index
    func user(at index: Int) -> UserModel {
        return users[index]
    }
}
