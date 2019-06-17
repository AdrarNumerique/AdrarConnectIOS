//
//  UtilisateurCollection.swift
//  AdrarProject
//
//  Created by Vincent Maldonado on 14/06/2019.
//  Copyright © 2019 Vincent Maldonado. All rights reserved.
//

import UIKit

// Utilisé pour Tester sur rendu graphique tant que la BD n'est pas mise en place.

class UtilisateurCollection{
    var utilisateurs: [Utilisateur] = []
    
    func push(utilisateur: Utilisateur) {
        utilisateurs.append(utilisateur)
    }
    
    func getNb ()->Int{
        return utilisateurs.count
    }
    
   
    
}

