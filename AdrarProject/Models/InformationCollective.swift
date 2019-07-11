//
//  SessionCollective.swift
//  AdrarProject
//
//  Created by Vincent Maldonado on 12/06/2019.
//  Copyright © 2019 Vincent Maldonado. All rights reserved.
//

import Foundation

struct InformationCollective:Codable {
    var date:Int
    var nbreMaxParticipant:Int
    var complet: Int
    var centreDeFormation:CentreFormation
}
