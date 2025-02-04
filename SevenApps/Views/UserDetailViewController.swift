//
//  UserDetailViewController.swift
//  SevenApps
//
//  Created by Ömer Firat on 4.02.2025.
//

import UIKit
import SnapKit

final class UserDetailViewController: UIViewController {

    private let user: UserModel
    
    private let emailLabel = UILabel()
    private let phoneLabel = UILabel()
    private let websiteLabel = UILabel()

    // Initializer to accept user data
    init(user: UserModel) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }

    // Required initializer for storyboard-based navigation
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupNavigationBar()
        setupUI()
        populateData()
    }

    // Setup navigation bar title and appearance
    private func setupNavigationBar() {
        navigationItem.title = user.name
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .black
    }
    
    // Setup UI elements on the view
    private func setupUI() {
        view.addSubview(emailLabel)
        view.addSubview(phoneLabel)
        view.addSubview(websiteLabel)

        // Apply base font style
        emailLabel.font = UIFont.preferredFont(forTextStyle: .body)
        phoneLabel.font = UIFont.preferredFont(forTextStyle: .body)
        websiteLabel.font = UIFont.preferredFont(forTextStyle: .body)
        websiteLabel.textColor = .systemBlue
        websiteLabel.isUserInteractionEnabled = false  // Disable interactivity

        // Using SnapKit for layout
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            make.leading.trailing.equalTo(view).inset(16)
        }
        
        phoneLabel.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(8)
            make.leading.trailing.equalTo(view).inset(16)
        }
        
        websiteLabel.snp.makeConstraints { make in
            make.top.equalTo(phoneLabel.snp.bottom).offset(8)
            make.leading.trailing.equalTo(view).inset(16)
        }
    }

    // Populate the UI labels with user data
    private func populateData() {
        emailLabel.text = "Email: \(user.email)"
        phoneLabel.text = "Phone: \(user.phone)"
        websiteLabel.text = "Website: \(user.website)"
    }
}
