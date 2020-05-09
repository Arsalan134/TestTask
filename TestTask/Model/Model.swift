//
//  Model.swift
//  TestTask
//
//  Created by Arsalan Iravani on 09/05/2020.
//  Copyright © 2020 Arsalan Iravani. All rights reserved.
//

import Foundation

struct Model: Decodable {
    var name: String?
    var realname: String?
    var team: String?
    var firstAppearance: String?
    var createdby: String?
    var publisher: String?
    var imageURL: String?
    var bio: String?
}
