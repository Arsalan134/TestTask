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
    
    weak var coordinator: MainCoordinator?
    
    func t() {
        
    }
    
    func loginPressed() {
        authenticateUser()
    }
    
    func authenticateUser() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Identify yourself!") { [weak self] success, authenticationError in
                
                DispatchQueue.main.async {
                    if success {
                        self?.coordinator?.successfullyLoggedIn()
                    } else {
                        self?.coordinator?.unsuccessfullyLoggedin()
                    }
                }
            }
        }
    }
    
}
