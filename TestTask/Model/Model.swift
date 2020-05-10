//
//  Model.swift
//  TestTask
//
//  Created by Arsalan Iravani on 09/05/2020.
//  Copyright © 2020 Arsalan Iravani. All rights reserved.
//

import Foundation

struct Movie: Decodable {
    var name: String?
    var realname: String?
    var team: String?
    var firstAppearance: String?
    var createdBy: String?
    var publisher: String?
    var imageURL: String?
    var bio: String?
    
    enum CodingKeys: String, CodingKey {
      case name, realname, team, firstAppearance = "firstappearance", createdBy = "createdby", publisher, imageURL = "imageurl", bio
    }
    
    
}


