//
//  ViewController.swift
//  TestTask
//
//  Created by Arsalan Iravani on 07/05/2020.
//  Copyright © 2020 Arsalan Iravani. All rights reserved.
//

import UIKit
import LocalAuthentication


class LoginViewController: UIViewController {
    
    weak var coordinator: MainCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        setupView()
        authenticateUser()
    }
    
    func authenticateUser() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            let reason = "Identify yourself!"
            
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { [weak self] success, authenticationError in
                
                DispatchQueue.main.async {
                    if success {
                        print("Sucesssss")
                        self?.coordinator?.buySubscription()
                    } else {
                        let ac = UIAlertController(title: "Authentication failed", message: "Sorry!", preferredStyle: .alert)
                        ac.addAction(UIAlertAction(title: "OK", style: .default))
                        self?.present(ac, animated: true)
                    }
                }
            }
        } else {
            let ac = UIAlertController(title: "Touch ID is not available", message: "Your device is not configured for Touch ID.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
        
    }
    
    func setupView() {
        setupTextFields()
        setupTouchIDView()
        setupDelegates()
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
    
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("salam")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case usernameTextField:
            passwordTextField.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        
        return true
    }
}

