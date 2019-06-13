//
//  Formations.swift
//  AdrarProject
//
//  Created by Vincent Maldonado on 06/06/2019.
//  Copyright © 2019 Vincent Maldonado. All rights reserved.
//


import Foundation


class Formation {
    private var _intitule : String
    private var _description : String
    private var _type:Int
    
    var intitule : String {
        return _intitule
    }
    
    var description : String {
        return _description
    }
    
    var type : Int {
        return _type
    }
    
    init(intitule: String, description: String, type:Int){
        _intitule = intitule
        _description = description
        _type = type
    }
}
