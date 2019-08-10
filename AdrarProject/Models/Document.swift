//
//  Document.swift
//  AdrarProject
//
//  Created by Vincent Maldonado on 12/06/2019.
//  Copyright © 2019 Vincent Maldonado. All rights reserved.
//

import Foundation

struct Document: Codable{
    var id: Int?
    var id_users: Int
    var id_typeDocument: Int
    var base64: String
    var etat: Int
}


