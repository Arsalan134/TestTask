//
//  ListViewController.swift
//  TestTask
//
//  Created by Arsalan Iravani on 09/05/2020.
//  Copyright © 2020 Arsalan Iravani. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class ListViewController: UIViewController {
    
    weak var coordinator: ListCoordinator?
    
    lazy var listVM = ListViewModel()
    
    lazy var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .done, target: self, action: #selector(logout))
        navigationItem.title = "List"
        
        setupTableView()
        
        listVM.downloadMovies { [weak self] _ in
            self?.tableView.reloadData()
        }
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 10),
        ])
    }
    
    @objc func logout() {
        coordinator?.logout()
    }
    
    
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listVM.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! MovieTableViewCell
        cell.movie = listVM.movies[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
