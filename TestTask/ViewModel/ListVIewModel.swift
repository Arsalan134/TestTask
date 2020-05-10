//
//  ListVIewModel.swift
//  TestTask
//
//  Created by Arsalan Iravani on 09/05/2020.
//  Copyright © 2020 Arsalan Iravani. All rights reserved.
//

import Foundation

class ListViewModel {
    
    weak var coordinator: ListCoordinator?
    var dataModel: MovieDataModel?
    
    func logoutPressed() {
        coordinator?.logout()
    }

    func getData(completion: @escaping ([Movie]) -> Void) {
        dataModel?.downloadMovies(completion: { movies in
            completion(movies)
        })
    }
    
    
}
