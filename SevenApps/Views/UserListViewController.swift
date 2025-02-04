//
//  UserListViewController.swift
//  SevenApps
//
//  Created by Ömer Firat on 4.02.2025.
//

import UIKit
import SnapKit

final class UserListViewController: UIViewController {

    private lazy var viewModel = UserListViewModel()
    private lazy var tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupNavigationBar()
        setupTableView()
        bindViewModel()
        viewModel.fetchUsers()  // Fetch user data when the view is loaded
    }
    
    // Setup the navigation bar
    private func setupNavigationBar() {
        navigationItem.title = "User List"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    // Setup and configure the table view
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UserCell.self, forCellReuseIdentifier: UserCell.identifier)
        
        tableView.rowHeight = 80  // Adjusted row height for better readability
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .lightGray
        tableView.backgroundColor = .systemGroupedBackground
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()  // Full screen constraints
        }
    }
    
    // Bind the ViewModel to reload the table view when data changes
    private func bindViewModel() {
        viewModel.reloadData = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()  // Reload table view on main thread
            }
        }
    }
}

extension UserListViewController: UITableViewDataSource, UITableViewDelegate {
    // Return the number of rows based on the number of users
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    // Configure each table view cell with user data
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.identifier, for: indexPath) as! UserCell
        let user = viewModel.user(at: indexPath.row)  // Get the user for this row
        cell.configure(with: user)  // Configure the cell with user data
        return cell
    }
    
    // Handle row selection to navigate to the detail view
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = viewModel.user(at: indexPath.row)  // Get selected user
        let detailVC = UserDetailViewController(user: user)  // Create detail VC
        navigationController?.pushViewController(detailVC, animated: true)  // Push detail VC
    }
}
