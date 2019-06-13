//
//  Utilisateur.swift
//  AdrarProject
//
//  Created by Vincent Maldonado on 06/06/2019.
//  Copyright © 2019 Vincent Maldonado. All rights reserved.
//

import Foundation

struct Utilisateur {
    private var id:Int
    private var prenom:String
    private var nom:String
    private var email:String
    private var mdp:String
    private var adresse:Adresse?
    private var ddn:Int?
    private var telephone:Int?
    private var numPoleEmploi:String?
    private var files:Document?
    private var souhaitFiliere:Int?
    private var sessionCollective:SessionCollective?
}
