//
//  ListCoordinator.swift
//  TestTask
//
//  Created by Arsalan Iravani on 09/05/2020.
//  Copyright © 2020 Arsalan Iravani. All rights reserved.
//

import Foundation
import UIKit

class ListCoordinator: Coordinator {
    
    weak var parentCoordinator: MainCoordinator?
    
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = ListViewController()
        vc.listVM.coordinator = self
        navigationController.viewControllers = [vc]
    }
    
    func logout() {
        let vc = LoginViewController()
        vc.loginVM.coordinator = parentCoordinator
        navigationController.viewControllers = [vc]
    }
    
}
