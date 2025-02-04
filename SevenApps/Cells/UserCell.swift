//
//  UserCell.swift
//  SevenApps
//
//  Created by Ömer Firat on 4.02.2025.
//
import UIKit

final class UserCell: UITableViewCell {
    static let identifier = "UserCell"

    private let nameLabel = UILabel()
    private let emailLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupCell() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(emailLabel)

        // Configure nameLabel and emailLabel styles
        nameLabel.font = UIFont.preferredFont(forTextStyle: .body)
        nameLabel.textColor = .darkText
        emailLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        emailLabel.textColor = .gray

        // Layout constraints for nameLabel and emailLabel
        nameLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(contentView).inset(16)
        }

        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
            make.leading.trailing.equalTo(contentView).inset(16)
            make.bottom.equalTo(contentView).inset(16)
        }
    }

    // Configure the cell with user data
    func configure(with user: UserModel) {
        nameLabel.text = user.name
        emailLabel.text = user.email
    }
}
