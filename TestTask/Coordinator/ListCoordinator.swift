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
    
    weak var parentCoordinator: LoginCoordinator?
    
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vm = ListViewModel()
        vm.coordinator = self
        vm.dataModel = MovieDataModel()
        
        let vc = ListViewController()
        vc.listVM = vm
        navigationController.viewControllers = [vc]
    }
    
    func logout() {
        let vm = LoginViewModel()
        vm.coordinator = parentCoordinator
        
        let vc = LoginViewController()
        vc.loginVM = vm
        navigationController.viewControllers = [vc]
    }
    
}
