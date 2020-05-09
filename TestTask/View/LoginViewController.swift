//
//  ViewController.swift
//  TestTask
//
//  Created by Arsalan Iravani on 07/05/2020.
//  Copyright © 2020 Arsalan Iravani. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    weak var coordinator: MainCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        setupView()
    }
    
    func setupView() {
        setupTextFields()
        setupTouchIDView()
        setupDelegates()
        setupLoginButton()
    }
    
    func setupTextFields() {
        view.addSubview(usernameTextField)
        view.addSubview(passwordTextField)
        
        usernameTextField.returnKeyType = .next
        passwordTextField.returnKeyType = .done
        
        NSLayoutConstraint.activate([
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            usernameTextField.bottomAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: -40),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            passwordTextField.leadingAnchor.constraint(equalTo: usernameTextField.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: usernameTextField.trailingAnchor),
            passwordTextField.bottomAnchor.constraint(equalTo: view.centerYAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    
    func setupTouchIDView() {
        view.addSubview(touchIDView)
        
        touchIDView.addSubview(touchIDInfoLabel)
        touchIDView.addSubview(touchIDSwitch)
        
        NSLayoutConstraint.activate([
            touchIDView.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
            touchIDView.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),
            touchIDView.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 60),
            touchIDView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            touchIDInfoLabel.leadingAnchor.constraint(equalTo: touchIDView.leadingAnchor, constant: 20),
            touchIDInfoLabel.trailingAnchor.constraint(equalTo: touchIDSwitch.trailingAnchor, constant: -10),
            touchIDInfoLabel.centerYAnchor.constraint(equalTo: touchIDView.centerYAnchor),
            touchIDInfoLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            touchIDSwitch.trailingAnchor.constraint(equalTo: touchIDView.trailingAnchor, constant: -10),
            touchIDSwitch.centerYAnchor.constraint(equalTo: touchIDView.centerYAnchor),
        ])
        
    }
    
    func setupDelegates() {
        usernameTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    func setupLoginButton() {
        view.addSubview(loginButton)
        
        NSLayoutConstraint.activate([
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            loginButton.topAnchor.constraint(equalTo: touchIDView.bottomAnchor, constant: 60),
            loginButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    let usernameTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Username"
        tf.backgroundColor = .secondarySystemBackground
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.isSecureTextEntry = true
        tf.placeholder = "Password"
        tf.clearsOnBeginEditing = true
        tf.backgroundColor = .secondarySystemBackground
        tf.passwordRules = UITextInputPasswordRules(descriptor: "required: upper; required: lower; required: digit; max-consecutive: 2; minlength: 8;")
        return tf
    }()
    
    let touchIDView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .red
        return v
    }()
    
    let touchIDInfoLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "Enable Touch ID login"
        l.adjustsFontSizeToFitWidth = true
        return l
    }()
    
    let touchIDSwitch: UISwitch = {
        let s = UISwitch()
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()
    
    let loginButton: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle("Login", for: .normal)
        b.addTarget(self, action: #selector(loginPressed), for: .touchUpInside)
        b.setTitleColor(.label, for: .normal)
        b.backgroundColor = .secondarySystemBackground
        return b
    }()
    
    @objc func loginPressed() {
        coordinator?.loginPresed()
    }
    
}

extension LoginViewController: UITextFieldDelegate {
   
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case usernameTextField:
            usernameTextField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
        default:
            passwordTextField.resignFirstResponder()
        }
        return true
    }
}

