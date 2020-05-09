//
//  MovieTableViewCell.swift
//  TestTask
//
//  Created by Arsalan Iravani on 09/05/2020.
//  Copyright © 2020 Arsalan Iravani. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    var movie: Movie?
    
    private func setupViews() {
        setupImageView()
        setupLabels()
    }
    
    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    private func setupImageView() {
        addSubview(movieImageView)
        
        movieImageView.layer.cornerRadius = 5
        movieImageView.contentMode = .scaleAspectFill
        
        if let imageurl = movie?.imageURL, let url = URL(string: imageurl) {
            getData(from: url) { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async() {
                    self.movieImageView.image = UIImage(data: data)
                }
            }
        }
        
        NSLayoutConstraint.activate([
            movieImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            movieImageView.widthAnchor.constraint(equalToConstant: 80),
            movieImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            movieImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
    
    private func setupLabels() {
        addSubview(titleLabel)
        addSubview(detailLabel)
        
        titleLabel.text = movie?.name
        detailLabel.text = movie?.firstAppearance
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            titleLabel.topAnchor.constraint(equalTo: movieImageView.topAnchor, constant: 10),
            titleLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            detailLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            detailLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            detailLabel.heightAnchor.constraint(equalToConstant: 30),
            detailLabel.bottomAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: -10)
        ])
    }
    
    private let movieImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.clipsToBounds = true
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.adjustsFontSizeToFitWidth = true
        return l
    }()
    
    private let detailLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.adjustsFontSizeToFitWidth = true
        return l
    }()
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        setupViews()
    }
    
}

