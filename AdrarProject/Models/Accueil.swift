//
//  Accueil.swift
//  AdrarProject
//
//  Created by Vincent Maldonado on 21/06/2019.
//  Copyright © 2019 Vincent Maldonado. All rights reserved.
//

import Foundation

struct Accueil: Codable {
    var processusInscription: ProcessusInscription
    var listeInfosCollectives: [InformationCollective]
    var formations:[Formation]
    var adrar_html: String
    var faq: [QuestionReponse]
    var infosCollectives_html: String
}
