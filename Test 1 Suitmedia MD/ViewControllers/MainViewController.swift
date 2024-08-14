//
//  ViewController.swift
//  Test 1 Suitmedia MD
//
//  Created by Ihsan on 14/08/24.
//

import UIKit

class MainViewController: UIViewController {
    
    let profileImageView = UIImageView()
    let nameTextField = UITextField()
    let palindromeTextField = UITextField()
    let checkButton = UIButton(type: .system)
    let nextButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackground()
        setupUI()
    }
    
    private func setupBackground() {
            let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
            backgroundImage.image = UIImage(named: "background")
            backgroundImage.contentMode = .scaleAspectFill
            view.addSubview(backgroundImage)
            view.sendSubviewToBack(backgroundImage)
        }
    
    private func setupUI() {
        
        // Configure profileImageView
        profileImageView.image = UIImage(named: "profileAdd")
        profileImageView.contentMode = .scaleAspectFit
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(profileImageView)
        
        // Configure nameTextField
        nameTextField.placeholder = "Name"
        nameTextField.borderStyle = .roundedRect
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        // Create a padding view
        let namePaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: nameTextField.frame.height))
        nameTextField.leftView = namePaddingView
        nameTextField.leftViewMode = .always
        
        view.addSubview(nameTextField)
        
        // Configure palindromeTextField
        palindromeTextField.placeholder = "Palindrome"
        palindromeTextField.borderStyle = .roundedRect
        palindromeTextField.translatesAutoresizingMaskIntoConstraints = false
        // Create a padding view
        let palindromePaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: palindromeTextField.frame.height))
        palindromeTextField.leftView = palindromePaddingView
        palindromeTextField.leftViewMode = .always
        
        view.addSubview(palindromeTextField)
        
        // Configure checkButton
        checkButton.setTitle("Check", for: .normal)
        checkButton.addTarget(self, action: #selector(checkPalindrome), for: .touchUpInside)
        checkButton.translatesAutoresizingMaskIntoConstraints = false
        setupButtonBox(button: checkButton)
        view.addSubview(checkButton)
        
        // Configure nextButton
        nextButton.setTitle("Next", for: .normal)
        nextButton.addTarget(self, action: #selector(goToSecondScreen), for: .touchUpInside)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        setupButtonBox(button: nextButton)
        view.addSubview(nextButton)
        
        // Setup constraints
        NSLayoutConstraint.activate([
            
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageView.bottomAnchor.constraint(equalTo: nameTextField.topAnchor, constant: -70),
            profileImageView.widthAnchor.constraint(equalToConstant: 120),
            profileImageView.heightAnchor.constraint(equalToConstant: 120),
            
            nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -60),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            
            palindromeTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            palindromeTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            palindromeTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            palindromeTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            
            checkButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            checkButton.topAnchor.constraint(equalTo: palindromeTextField.bottomAnchor, constant: 60),
            checkButton.widthAnchor.constraint(equalToConstant: 300),
            checkButton.heightAnchor.constraint(equalToConstant: 50),
            
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.topAnchor.constraint(equalTo: checkButton.bottomAnchor, constant: 20),
            nextButton.widthAnchor.constraint(equalToConstant: 300),
            nextButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    private func setupButtonBox(button: UIButton) {
        button.backgroundColor = UIColor(red: 42/255.0, green: 99/255.0, blue: 123/255.0, alpha: 1.0)
            button.setTitleColor(.white, for: .normal)
            button.layer.cornerRadius = 10
            button.layer.shadowColor = UIColor.black.cgColor
            button.layer.shadowOffset = CGSize(width: 0, height: 2)
            button.layer.shadowOpacity = 0.3
            button.layer.shadowRadius = 4
        }
    
    @objc private func checkPalindrome() {
        let text = palindromeTextField.text?.replacingOccurrences(of: " ", with: "").lowercased() ?? ""
        let isPalindrome = text == String(text.reversed())
        let message = isPalindrome ? "isPalindrome" : "not palindrome"
        
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @objc private func goToSecondScreen() {
        let secondVC = SecondViewController()
        secondVC.userName = nameTextField.text ?? ""
        navigationController?.pushViewController(secondVC, animated: true)
    }
}
