//
//  CentreFormation.swift
//  AdrarProject
//
//  Created by Vincent Maldonado on 12/06/2019.
//  Copyright © 2019 Vincent Maldonado. All rights reserved.
//

import Foundation

struct CentreFormation:Decodable{
    private var _id:Int
    private var _numeroVoie:String
    private var _adresse:String
    private var _complementAdresse:String
    private var _cP: String
    private var _ville:String
    private var _telephone:String
    private var _coordonnerX:Int
    private var _coordonneeY:Int
}
