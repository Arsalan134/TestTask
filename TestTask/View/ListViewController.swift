//
//  ListViewController.swift
//  TestTask
//
//  Created by Arsalan Iravani on 07/05/2020.
//  Copyright © 2020 Arsalan Iravani. All rights reserved.
//

// Fetch the list of images and data from below API:
// https://simplifiedcoding.net/demos/marvel/
// Should display the images in a Table view with images icon on left and name displayed on right.
// Option to delete row.
// Logout button on top to return to login screen.
// Ignore Search functionality.

import UIKit

class ListViewController: UIViewController {
    
    weak var coordinator: ListCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .done, target: self, action: #selector(ttt))

    }
    
    @objc func ttt() {
        coordinator?.logout()
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
