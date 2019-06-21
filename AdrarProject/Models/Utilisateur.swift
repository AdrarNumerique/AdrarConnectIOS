//
//  Utilisateur.swift
//  AdrarProject
//
//  Created by Vincent Maldonado on 06/06/2019.
//  Copyright © 2019 Vincent Maldonado. All rights reserved.
//

import Foundation

struct Utilisateur:Decodable{
    var id: Int?
    var nom: String
    var prenom: String
    var telephone: Int?
    var email: String
    var mdp: String
    var ddn: Date?
    var voie: String?
    var complement: String?
    var cp: String?
    var ville: String?
    var dev: Bool?
    var reseau: Bool?
    var admin: Bool?
    var numeroPe: String?
    var idSessionConnexion: Int?
    var avancementInscription: Int?
    var infoCollective: InformationCollective?
    
    
}
