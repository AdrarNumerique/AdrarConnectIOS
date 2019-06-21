//
//  Constants.swift
//  AdrarProject
//
//  Created by Vincent Maldonado on 22/05/2019.
//  Copyright © 2019 Vincent Maldonado. All rights reserved.
//

import UIKit


let Bleu = UIColor(red: 71/255, green: 195/255, blue: 241/255, alpha: 1)
let Jaune = UIColor(red: 250/255, green: 168/255, blue: 31/255, alpha: 1)
let Rouge = UIColor(red: 242/255, green: 54/255, blue: 34/255, alpha: 1)
let Vert = UIColor(red: 131/255, green: 197/255, blue: 92/255, alpha: 1)
let Gris = UIColor(red: 76/255, green: 76/255, blue: 76/255, alpha: 1)

let DATE_FORMAT = "E, dd MMM yyyy HH:mm:ss Z"

//Image
let Fleche = UIImage(named: "chevron")

//Test JSON 
let jsonString:[String : Any?] = [
    "id" : 1,
    
    "prenom" : "vincent",
    
    "nom" : "mald",
    
    "email" : "test@test.fr",
    
    "mdp" : "Azerty12&é",
    
    "numero" : "55",
    
    "voie" : "rue maran",
    
    "complement" : nil,
    
    "cp" : "31400",
    
    "ville" : "Toulouse",
    
    "ddn" : "6 /10 /1994",
    
    "telephone" : "0685648292",
    
    "numeroPe" : "0123",
    
    "dev" : true,

    "reseau" : false,

    "idSessionConnexion" : 0,

    "avancementInscription" : 0

]
