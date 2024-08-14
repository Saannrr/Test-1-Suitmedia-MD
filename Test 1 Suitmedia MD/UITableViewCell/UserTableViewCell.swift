//
//  UserTableViewCell.swift
//  Test 1 Suitmedia MD
//
//  Created by Ihsan on 15/08/24.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    let userImageView = UIImageView()
    let nameLabel = UILabel()
    let emailLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        // Configure userImageView
        userImageView.layer.cornerRadius = 25
        userImageView.clipsToBounds = true
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(userImageView)
        
        // Configure nameLabel
        nameLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nameLabel)
        
        // Configure emailLabel
        emailLabel.font = UIFont.systemFont(ofSize: 14)
        emailLabel.textColor = .gray
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(emailLabel)
        
        // Setup constraints
        NSLayoutConstraint.activate([
            userImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            userImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            userImageView.widthAnchor.constraint(equalToConstant: 50),
            userImageView.heightAnchor.constraint(equalToConstant: 50),
            
            nameLabel.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            
            emailLabel.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: 16),
            emailLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            emailLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    func configure(with user: User) {
        nameLabel.text = "\(user.first_name) \(user.last_name)"
        emailLabel.text = user.email
        if let url = URL(string: user.avatar) {
            // Assuming you have a function to load image from URL
            loadImage(from: url) { image in
                self.userImageView.image = image
            }
        }
    }
    
    private func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    completion(image)
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
}
