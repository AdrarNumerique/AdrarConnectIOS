//
//  SessionCollective.swift
//  AdrarProject
//
//  Created by Vincent Maldonado on 12/06/2019.
//  Copyright © 2019 Vincent Maldonado. All rights reserved.
//

import Foundation

struct InformationCollective:Decodable {
    var id:Int
    var date:String
    var nombrePlacesMax:Int
    var centreDeFormation:CentreFormation
    var complet: Bool
}
