//
//  CentreFormation.swift
//  AdrarProject
//
//  Created by Vincent Maldonado on 12/06/2019.
//  Copyright © 2019 Vincent Maldonado. All rights reserved.
//

import Foundation

struct CentreFormation:Codable{
    var id:Int
    var numeroVoie:String
    var adresse:String
    var complementAdresse:String?
    var cp: String
    var ville:String
    var telephone:String
    var coordoneeX:String?
    var coordoneeY:String?
}
