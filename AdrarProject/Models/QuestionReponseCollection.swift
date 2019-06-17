//
//  QuestionReponseCollection.swift
//  AdrarProject
//
//  Created by Vincent Maldonado on 14/06/2019.
//  Copyright © 2019 Vincent Maldonado. All rights reserved.
//

// Utilisé pour Tester sur rendu graphique tant que la BD n'est pas mise en place.
import UIKit

class QuestionReponseCollection{
    func all() -> [QuestionReponse]{
        var questionsReponses: [QuestionReponse] = []
        
        questionsReponses.append(QuestionReponse(
            question:"maquestion0",
            reponse:"mareponse0"
            )
        )
        questionsReponses.append(QuestionReponse(
            question:"maquestion1",
            reponse:"mareponse1"
            )
        )
        return questionsReponses
    }
    
    
    
}
