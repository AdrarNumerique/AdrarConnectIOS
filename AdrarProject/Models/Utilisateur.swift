//
//  Utilisateur.swift
//  AdrarProject
//
//  Created by Vincent Maldonado on 06/06/2019.
//  Copyright © 2019 Vincent Maldonado. All rights reserved.
//Swift's access control is not based on classes, but on source files and modules. The idea is that if you write a class, then you should have access to all of its members from another class in the same source file or module by default. If someone else extends your class, their code will be in a different module and source file, so they won't be able to access your base class members unless you give them access.

import Foundation
//Les classes sont des types par référence et les structures des types par valeur.
struct Utilisateur:Codable{
    var id: Int?
    var nom: String
    var prenom: String
    var ddn: Int?
    var email: String
    var telephone: String?
    var numeroPe: String?
    var mdp: String?
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
    var ID_avancementInscription: Int?
    var documents: [Document]?
}


