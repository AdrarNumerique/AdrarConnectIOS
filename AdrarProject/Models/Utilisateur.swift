//
//  Utilisateur.swift
//  AdrarProject
//
//  Created by Vincent Maldonado on 06/06/2019.
//  Copyright © 2019 Vincent Maldonado. All rights reserved.
//

import Foundation

struct Utilisateur:Codable{
    var id: Int?
    var nom: String
    var prenom: String
    var ddn: String?
    var email: String
    var telephone: String?
    var numeroPe: String?
    var mdp: String
    var numeroVoie: String?
    var adresse: String?
    var complementAdresse: String?
    var cp: String?
    var ville: String?
    var dev: Int?
    var reseau: Int?
    var admin: Int?
    var idSessionConnexion:String?
    var ID_infoCollective: Int?
    var ID_avancementInscription:Int?
}
