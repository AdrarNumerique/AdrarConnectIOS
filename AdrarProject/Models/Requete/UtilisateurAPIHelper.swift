//
//  UtilisateurAPIHelper.swift
//  AdrarProject
//
//  Created by Vincent Maldonado on 21/06/2019.
//  Copyright © 2019 Vincent Maldonado. All rights reserved.
//

import Foundation


class UtilisateurAPIHelper {
    typealias ApiCompletionAuth = (_ utilisateur:Utilisateur?,_ errorString:String?) -> Void//comprendre le typealias
    
    //récuperer un email et un mdp pour le post et recuperer un utilisateur dans le get
    func auth(email: String,mdp: String,_ completion:ApiCompletionAuth?){
        
        let parameters:[String:Any] = ["email":"\(email)","mdp":"\(mdp)"]
        let url = URL(string:"http://localhost:3000/ws/login")!
        var request = URLRequest(url:url)
        request.httpMethod = "POST"
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }
        //precise le type et format de donnée qu'on récupere avec le POST
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        //GET
        URLSession.shared.dataTask(with: request){(data,response,error) in
            if error != nil {
                completion?(nil,error!.localizedDescription)
            }
            if data != nil,((response as? HTTPURLResponse) != nil) {
                do{
                    let reponse = try JSONDecoder().decode(Utilisateur.self, from: data!)
                    completion?(reponse.self, nil)
                }catch{
                    completion?(nil,error.localizedDescription)
                    print(error)
                }
            } else {
                completion?(nil,"aucune data disponible")
            }
            
            }.resume()
    }
   

    
}



//doc:https://www.quora.com/How-is-a-HTTP-post-request-with-a-JSON-body-in-Swift
