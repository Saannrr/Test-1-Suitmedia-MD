//
//  ThirdViewController.swift
//  Test 1 Suitmedia MD
//
//  Created by Ihsan on 14/08/24.
//

import UIKit

protocol UserSelectionDelegate: AnyObject {
    func didSelectUser(name: String)
}

class ThirdViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    weak var delegate: UserSelectionDelegate?
    
    let tableView = UITableView()
    var users: [User] = []
    var page = 1
    var isLoading = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupUI()
        fetchUsers()
    }
    
    private func setupNavigationBar() {
        // Set the title
        let titleLabel = UILabel()
        titleLabel.text = "Third Screen"
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
        
        // Configure tableView
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UserTableViewCell.self, forCellReuseIdentifier: "UserCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        // Setup constraints
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // Add pull to refresh
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshUsers), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    @objc private func refreshUsers() {
        page = 1
        users.removeAll()
        fetchUsers()
    }
    
    private func fetchUsers() {
        guard !isLoading else { return }
        
        isLoading = true
        let url = URL(string: "https://reqres.in/api/users?page=\(page)")!
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            self.isLoading = false
            
            if let data = data, let response = try? JSONDecoder().decode(UserResponse.self, from: data) {
                DispatchQueue.main.async {
                    if self.page == 1 {
                        self.users = response.data
                        self.tableView.refreshControl?.endRefreshing()
                    } else {
                        self.users.append(contentsOf: response.data)
                    }
                    self.tableView.reloadData()
                    self.page += 1
                }
            }
        }
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! UserTableViewCell
        let user = users[indexPath.row]
        cell.configure(with: user)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = users[indexPath.row]
        delegate?.didSelectUser(name: "\(user.first_name) \(user.last_name)")
        navigationController?.popViewController(animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.height * 4 {
            fetchUsers()
        }
    }
}
