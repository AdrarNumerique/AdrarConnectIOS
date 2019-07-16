//
//  UtilisateurAPIHelper.swift
//  AdrarProject
//
//  Created by Vincent Maldonado on 21/06/2019.
//  Copyright © 2019 Vincent Maldonado. All rights reserved.
//

import Foundation


class UtilisateurAPIHelper {
    typealias ApiCompletionUser = (_ utilisateur:Utilisateur?,_ errorString:String?) -> Void//comprendre le typealias
    typealias ApiCompletionUpdateBool = (_ updateGood:Utilisateur?,_ errorString:String?) -> Void
    
    //récuperer un email et un mdp pour le post et recuperer un utilisateur dans le get
    func auth(email: String,mdp: String,_ completion:ApiCompletionUser?){
        
        let parameters:[String:Any] = ["email":"\(email)","mdp":"\(mdp)"]
        let url = URL(string:"http://localhost:3000/ws/login")!
        var request = URLRequest(url:url)
        request.httpMethod = "POST"
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }
        //precise le type et format de donnée qu'on envoie avec le POST
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
                    print("\(reponse) + hi")
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
    func signIn(utilisateur:Utilisateur,_ completion:ApiCompletionUser?){
        let parameters:[String:Any] = ["prenom":"\(utilisateur.prenom)","nom":"\(utilisateur.nom)", "email":"\(utilisateur.email)","mdp":"\(utilisateur.mdp!)"]
        let url = URL(string:"http://localhost:3000/ws/signin")!
        var request = URLRequest(url:url)
        request.httpMethod = "POST"
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }
        //precise le type et format de donnée qu'on envoie avec le POST
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
    
    func createDictioUser(utilisateur:Utilisateur) -> [String:Any]{
        //Creer le tableau avec non optionelles et pour chaque valeur on unwrap et on rajoute si non nul
        var parametersUpdate:[String:Any] = ["prenom":"\(utilisateur.prenom)","nom":"\(utilisateur.nom)", "email":"\(utilisateur.email)","idSessionConnexion":"\(utilisateur.idSessionConnexion!)"]
        
        if let numeroVoieUser = utilisateur.numeroVoie {
            parametersUpdate["numeroVoie"] = numeroVoieUser
        }
        //dans la valeur associé à la clé du dictionnaire : Si utiliateur.numeroVoie est egal à nil ou à "" je veux que le résultat soit nil si le résultat n'est pas égal à nil je veux que le résultat soit "utilisateur.numeroVoie"
        //parametersUpdat["numeroVoie"] = "\(numeroVoieUser)" = utilisateur.numeroVoie
        if let adresseUser = utilisateur.adresse {
            parametersUpdate["adresse"] = adresseUser
        }
        if let cpUser = utilisateur.cp {
            parametersUpdate["cp"] = cpUser
        }
        if let villeUser = utilisateur.ville {
            parametersUpdate["ville"] = villeUser
        }
        
        if let ddnUser = utilisateur.ddn {
            parametersUpdate["ddn"] = ddnUser
        }
        if let telephoneUser = utilisateur.telephone {
            parametersUpdate["telephone"] = telephoneUser
        }
        if let numeroPEUser = utilisateur.numeroPe {
            parametersUpdate["numeroPe"] = numeroPEUser
        }
        if let devUser = utilisateur.dev {
            parametersUpdate["dev"] = devUser
        }
        if let resUser = utilisateur.reseau {
            parametersUpdate["reseau"] = resUser
        }
        if let adminUser = utilisateur.admin {
            parametersUpdate["admin"] = adminUser
        }
        print(parametersUpdate)
        return parametersUpdate
        
    }
    func update(utilisateur:Utilisateur,_ completion:ApiCompletionUpdateBool?){
        let userDico = createDictioUser(utilisateur: utilisateur)
        let url = URL(string:"http://localhost:3000/ws/candidat/update/details/")!
        var request = URLRequest(url:url)
        request.httpMethod = "POST"
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: userDico, options: .prettyPrinted)
            print(userDico)
        } catch let error {
            print("erreur catch")
            print(error.localizedDescription)
        }
        //precise le type et format de donnée qu'on envoie avec le POST
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        //GET
        URLSession.shared.dataTask(with: request){(data,response,error) in
            if error != nil {
                completion?(nil,error!.localizedDescription)
            }
            if data != nil,((response as? HTTPURLResponse) != nil) {
                do{
                    print("do")
                    let reponse = try JSONDecoder().decode(Utilisateur.self, from: data!)
                    print(reponse)
                    completion?(reponse.self, nil)
                }catch{
                    print("catch")
                    completion?(nil,error.localizedDescription)
                    print(error)
                }
            } else {
                completion?(nil,"aucune data disponible")
            }

            }.resume()
    }
    func updateInfoCo(idInfoCo:Int,idSessionCo:String,_ completion:ApiCompletionUser?){
        let infoCoJson:[String:Any] = ["idSessionConnexion":idSessionCo,"ID_infoCollective":idInfoCo]
        print(infoCoJson)
        let url = URL(string:"http://localhost:3000/ws/infos-collectives/inscription")!
        var request = URLRequest(url:url)
        request.httpMethod = "POST"
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: infoCoJson, options: .prettyPrinted)
            print(infoCoJson)
        } catch let error {
            print(error.localizedDescription)
        }
        //precise le type et format de donnée qu'on envoie avec le POST
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
    //Not good
    func deleteInfoCo(idSessionCo:String,_ completion:ApiCompletionUser?){
        let infoCoJson:[String:String] = ["idSessionConnexion":idSessionCo]
        print(infoCoJson)
        let url = URL(string:"http://localhost:3000/ws/infos-collectives/delete")!
        var request = URLRequest(url:url)
        request.httpMethod = "GET"
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: infoCoJson, options: .prettyPrinted)
            print("good")
            print(infoCoJson)
        } catch let error {
            print(error.localizedDescription)
        }
        //precise le type et format de donnée qu'on envoie avec le POST
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        //GET
        URLSession.shared.dataTask(with: request){(data,response,error) in
            if error != nil {
                completion?(nil,error!.localizedDescription)
            }
            if data != nil,((response as? HTTPURLResponse) != nil) {
                do{
                    print("do")
                    let reponse = try JSONDecoder().decode(Utilisateur.self, from: data!)
                    print(reponse)
                    completion?(reponse.self, nil)
                }catch{
                    print("catch")
                    completion?(nil,error.localizedDescription)
                    print(error)
                }
            } else {
                completion?(nil,"aucune data disponible")
            }
            
            }.resume()
    }
}
