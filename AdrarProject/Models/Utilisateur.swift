//
//  Utilisateur.swift
//  AdrarProject
//
//  Created by Vincent Maldonado on 06/06/2019.
//  Copyright © 2019 Vincent Maldonado. All rights reserved.
//

import Foundation

struct  Utilisateur{
    var _id:Int?
    var _nom:String
    var _prenom:String
    var _telephone:Int?
    var _email:String
    var _mdp:String
    var _ddn:Date?
    var _numeroVoie:String?
    var _adresse:String?
    var _complementAdresse:String?
    var _cp:String?
    var _ville:String?
    var _dev:Bool?
    var _reseau:Bool?
    var _admin:Bool?
    var _numPoleEmploi:String?
    var _idSessionConnexion:Int?//à changer
    var _avancementInscription:Int?//à changer aussi
    var _informationCollective:InformationCollective?
    
    
    init(prenom: String, nom: String, email:String, mdp:String){
        _prenom = prenom
        _nom = nom
        _email = email
        _mdp = mdp
    }
    var email : String {
        return _email
    }
    var mdp : String {
        return _mdp
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
