//
//  MainCoordinator.swift
//  TestTask
//
//  Created by Arsalan Iravani on 07/05/2020.
//  Copyright © 2020 Arsalan Iravani. All rights reserved.
//

import Foundation
import LocalAuthentication
import UIKit

class MainCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {
    
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.delegate = self
        let vc = LoginViewController()
        vc.loginVM.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func childDidFinish(_ child: Coordinator?) {
        for(index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
    
    func successfullyLoggedIn() {
        let child = ListCoordinator(navigationController: navigationController)
        child.parentCoordinator = self
        childCoordinators.append(child)
        child.start()
    }
    
    func unsuccessfullyLoggedin() {
        let ac = UIAlertController(title: "Authentication failed", message: "Sorry!", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        navigationController.viewControllers.first?.present(ac, animated: true)
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromVIewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else { return }
        
        if navigationController.viewControllers.contains(fromVIewController) { return }
        
        if let listViewController = fromVIewController as? ListViewController {
            childDidFinish(listViewController.listVM.coordinator)
        }
    }
    
}
