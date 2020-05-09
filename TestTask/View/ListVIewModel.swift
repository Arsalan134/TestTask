//
//  ListVIewModel.swift
//  TestTask
//
//  Created by Arsalan Iravani on 09/05/2020.
//  Copyright © 2020 Arsalan Iravani. All rights reserved.
//

import Foundation

class ListViewModel {
    
    private let url = "https://simplifiedcoding.net/demos/marvel/"
    var movies: [Movie] = []
    
    func downloadMovies(completion: @escaping ([Movie]) -> Void) {
        if let url = URL(string: url) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    let jsonDecoder = JSONDecoder()
                    do {
                        self.movies = try jsonDecoder.decode([Movie].self, from: data)
                        DispatchQueue.main.async {
                            completion(self.movies)
                        }
                    } catch {
                        print(error)
                    }
                }
            }.resume()
        }
    }
}
