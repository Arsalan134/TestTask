//
//  LoginViewModel.swift
//  TestTask
//
//  Created by Arsalan Iravani on 10/05/2020.
//  Copyright © 2020 Arsalan Iravani. All rights reserved.
//

import Foundation
import LocalAuthentication

class LoginViewModel {
    
    weak var coordinator: LoginCoordinator?
    
    func loginPressed(with switchIsOn: Bool, username: String?, password: String?) {
        if switchIsOn {
            authenticateUserWithTouchID(username: username)
        } else {
            authenticateUserWithoutTouchID(username: username, password: password)
        }
    }
    
    private func authenticateUserWithoutTouchID(username: String?, password: String?) {
        if let username = username {
            let passwordKeychain = KeychainWrapper.standard.string(forKey: "\(username)Password")
            if passwordKeychain == password {
                coordinator?.successfullyLoggedIn()
                saveLastLoggedUsername(username)
            } else {
                coordinator?.unsuccessfullyLoggedIn(error: "Password is incorrect")
            }
        }
    }
    
    func lastLoggedUsername() -> String? {
        return KeychainWrapper.standard.string(forKey: "lastLoggedUser")
    }
    
    private func saveLastLoggedUsername(_ username: String) {
        KeychainWrapper.standard.set(username, forKey: "lastLoggedUser")
    }
    
    private func savePassword(_ password: String, for username: String) {
        KeychainWrapper.standard.set(password, forKey: "\(username)Password")
    }
    
    private func authenticateUserWithTouchID(username: String?) {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Identify yourself") { [weak self] success, authenticationError in
                
                DispatchQueue.main.async {
                    if success {
                        if let username = username {
                            self?.saveLastLoggedUsername(username)
                        }
                        self?.coordinator?.successfullyLoggedIn()
                    }
                }
            }
        }
    }
     
}
