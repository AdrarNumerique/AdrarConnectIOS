//
//  Document.swift
//  AdrarProject
//
//  Created by Vincent Maldonado on 12/06/2019.
//  Copyright © 2019 Vincent Maldonado. All rights reserved.
//

import Foundation

struct Document: Decodable {
    var id:Int
    var chemin:String
    var etat:String?
    var idUser:Utilisateur
    var type:TypeDocument
}
