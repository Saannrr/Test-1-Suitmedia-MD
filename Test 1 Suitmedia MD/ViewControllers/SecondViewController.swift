//
//  SecondViewController.swift
//  Test 1 Suitmedia MD
//
//  Created by Ihsan on 14/08/24.
//

import UIKit

class SecondViewController: UIViewController {
    
    var userName: String = ""
    var selectedUserName: String = ""
    
    let welcomeLabel = UILabel()
    let userNameLabel = UILabel()
    let selectedUserLabel = UILabel()
    let chooseUserButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupUI()
    }
    
    private func setupNavigationBar() {
        // Set the title
        let titleLabel = UILabel()
        titleLabel.text = "Second Screen"
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        titleLabel.textColor = .black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        navigationItem.titleView = titleLabel
        
        // Center the title label
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: (navigationItem.titleView?.centerXAnchor)!),
            titleLabel.centerYAnchor.constraint(equalTo: (navigationItem.titleView?.centerYAnchor)!)
        ])
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        // Configure welcomeLabel
        welcomeLabel.text = "Welcome"
        welcomeLabel.font = UIFont.systemFont(ofSize: 14)
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(welcomeLabel)
        
        // Configure userNameLabel
        userNameLabel.text = userName
        userNameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(userNameLabel)
        
        // Configure selectedUserLabel
        selectedUserLabel.text = "Selected User Name"
        selectedUserLabel.font = UIFont.boldSystemFont(ofSize: 24)
        selectedUserLabel.textColor = UIColor.black
        selectedUserLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(selectedUserLabel)
        
        // Configure chooseUserButton
        chooseUserButton.setTitle("Choose a User", for: .normal)
        chooseUserButton.setTitleColor(.white, for: .normal)
        chooseUserButton.backgroundColor = UIColor(red: 42/255.0, green: 99/255.0, blue: 123/255.0, alpha: 1.0)
        chooseUserButton.layer.cornerRadius = 10
        chooseUserButton.addTarget(self, action: #selector(goToThirdScreen), for: .touchUpInside)
        chooseUserButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(chooseUserButton)
        
        // Setup constraints
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            welcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            userNameLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 4),
            userNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            selectedUserLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            selectedUserLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            chooseUserButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            chooseUserButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            chooseUserButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            chooseUserButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func goToThirdScreen() {
        let thirdVC = ThirdViewController()
        thirdVC.delegate = self
        navigationController?.pushViewController(thirdVC, animated: true)
    }
}

extension SecondViewController: UserSelectionDelegate {
    func didSelectUser(name: String) {
        selectedUserLabel.text = name
    }
}
