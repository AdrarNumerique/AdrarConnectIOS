//
//  Utilisateur.swift
//  AdrarProject
//
//  Created by Vincent Maldonado on 06/06/2019.
//  Copyright © 2019 Vincent Maldonado. All rights reserved.
//

import Foundation

class Utilisateur {
    var id:Int?
    var prenom:String
    var nom:String
    var email:String
    var mdp:String
    var adresse:Adresse?
    var ddn:Int?
    var telephone:Int?
    var numPoleEmploi:String?
    var files:Document?
    var souhaitFiliere:Int?
    var sessionCollective:SessionCollective?
    
    init(prenom: String, nom: String, email:String, mdp:String){
        self.prenom = prenom
        self.nom = nom
        self.email = email
        self.mdp = mdp
    }
//    init(jsValue: JSValue) {
//        id = jsonData["id"].string!
//        authId = jsonData["authId"].string!
//        emailAddress = jsonData["emailAddress"].string!
//        mobilePhoneNumber = jsonData["mobilePhoneNumber"].string!
//        firstName = jsonData["firstName"].string!
//        lastName = jsonData["lastName"].string!
//        countryCode = jsonData["countryCode"].string!
//        homepageUrl = jsonData["homepageUrl"].string!
//        tagline = jsonData["tagline"].string!
//        pictureUrl = jsonData["pictureUrl"].string!
//        accountState = convertAccountStateStringToEnum(jsonData["accountState"].string!)
//    }

}
