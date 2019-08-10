//
//  APIAccueil.swift
//  AdrarProject
//
//  Created by Vincent Maldonado on 21/06/2019.
//  Copyright © 2019 Vincent Maldonado. All rights reserved.
//


// Le but ici est de recuperer certaines informations quand l'application se lance. Ces informations sont : les formations, la webview de l'adrarInfo, les process d'inscription, la webview informative sur les infocCo et les infoCollective


import Foundation

class AccueilAPIHelper {
    typealias ApiCompletionAccueil = (_ formations:[Formation]?,_ adrarWebView: String?,_ infoCoWebView: String?,_ salarie:ProcessusInscription?,_ listInfoCo:[InformationCollective]?,_ listeFAQ:[QuestionReponse]? ,_ errorString:String?) -> Void//comprendre le typealias
    
    var urlAccueil : String {
        return _urlBase + "accueil" // récuper l'url ou se situe le json
    }
    
    //Requete GET qui prend en paramètre le type attendu en retour 
    func getAccueil( completion :ApiCompletionAccueil?){
        if let url = URL(string: urlAccueil){
            //Recuperation de donnée
            URLSession.shared.dataTask(with: url){(data,response,error) in
                //si erreur existe alors tout est nul et on renvoie l'erreur et sa description
                if error != nil {
                    completion?(nil,nil,nil,nil,nil,nil,error!.localizedDescription)
                }
                //si data non nul alors récupere les données. dans la completion on recupere les reponses qui sont de type formations etc. Si erreur alors on récupere encore l'erreur
                if data != nil {
                    do{
                        let reponse = try JSONDecoder().decode(Accueil.self, from: data!)
                        completion?(reponse.formations , reponse.adrar_html, reponse.infosCollectives_html,reponse.processusInscription,reponse.listeInfosCollectives,reponse.faq, nil)
                    }catch{
                        completion?(nil,nil,nil,nil,nil,nil,error.localizedDescription)
                        print(error)
                    }
                } else {
                    completion?(nil,nil,nil,nil,nil,nil,"aucune data disponible")
                }
                }.resume()
        }else {
            completion?(nil,nil,nil,nil,nil,nil,"Url Invalide")
        }
    }
    
}
