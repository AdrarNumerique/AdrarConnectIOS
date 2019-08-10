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
    //typealias ApiCompletionUpdateUser = (_ updateGood:Utilisateur?,_ errorString:String?) -> Void // same
    
    var urlUserLogin : String {
        return _urlBase + "login" // récuper l'url ou se situe le json
    }
    var urlUserSignIn : String {
        return _urlBase + "signin" // récuper l'url ou se situe le json
    }
    var urlUserUpdateInfo : String {
        return _urlBase + "candidat/update/details/" // récuper l'url ou se situe le json
    }
    var urlInscriptionInfoCo : String {
        return _urlBase + "infos-collectives/inscription" // récuper l'url ou se situe le json
    }
    var urlDeleteInfoCo : String {
        return _urlBase + "infos-collectives/delete"
    }
    var urlUserUpdateDoc : String {
        return _urlBase + "candidat/update/doc/"
    }
    
    //attend en paramètre un email et un mdp utile pour POST et recuperer un utilisateur ou erreur dans le GET de
    func auth(email: String,mdp: String,_ completion:ApiCompletionUser?){
        
        let parameters:[String:Any] = ["email":"\(email)","mdp":"\(mdp)"]
        let url = URL(string:urlUserLogin)!
        var request = URLRequest(url:url)
        request.httpMethod = "POST"
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }
        //precise le type et format de donnée qu'on envoie avec le POST(JSON)
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
    //Inscription
    func signIn(utilisateur:Utilisateur,_ completion:ApiCompletionUser?){
        let parameters:[String:Any] = ["prenom":"\(utilisateur.prenom)","nom":"\(utilisateur.nom)", "email":"\(utilisateur.email)","mdp":"\(utilisateur.mdp!)"]
        let url = URL(string:urlUserSignIn)!
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
    //Dictionnaire appelé dans function si dessous update() permet de créer un dictionnaire transformable en JSON avec un Utilisateur
    func createDictioUser(utilisateur:Utilisateur) -> [String:Any]{
        //Creer le tableau avec valeur si existe ou null si existe pas
        var parametersUpdate:[String:Any] = ["prenom":"\(utilisateur.prenom)","nom":"\(utilisateur.nom)", "email":"\(utilisateur.email)","idSessionConnexion":"\(utilisateur.idSessionConnexion!)"]
        parametersUpdate["numeroVoie"] = utilisateur.numeroVoie ?? NSNull()
        parametersUpdate["adresse"] = utilisateur.adresse ?? NSNull()
        parametersUpdate["cp"] = utilisateur.cp ?? NSNull()
        parametersUpdate["complementAdresse"] = utilisateur.complementAdresse ?? NSNull()
        parametersUpdate["ville"] = utilisateur.ville ?? NSNull()
        parametersUpdate["ddn"] = utilisateur.ddn ?? NSNull()
        parametersUpdate["telephone"] = utilisateur.telephone ?? NSNull()
        parametersUpdate["numeroPe"] = utilisateur.numeroPe ?? NSNull()
        if let devUser = utilisateur.dev {
            parametersUpdate["dev"] = devUser
        }
        if let resUser = utilisateur.reseau {
            parametersUpdate["reseau"] = resUser
        }
        if let adminUser = utilisateur.admin {
            parametersUpdate["admin"] = adminUser
        }
        if utilisateur.telephone != nil, !utilisateur.telephone!.isEmpty, utilisateur.numeroPe != nil,!utilisateur.numeroPe!.isEmpty, let avancementUser = utilisateur.ID_avancementInscription {
            parametersUpdate["ID_avancementInscription"] = avancementUser
        }
        return parametersUpdate
    }
    
    //Mise à jour de l'utilisateur (Info Supp)
    func update(utilisateur:Utilisateur,_ completion:ApiCompletionUser?){
        let userDico = createDictioUser(utilisateur: utilisateur)
        let url = URL(string:urlUserUpdateInfo)!
        var request = URLRequest(url:url)
        request.httpMethod = "POST"
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: userDico, options: .prettyPrinted)
        } catch let error {
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
    //Inscription InfoCo Modification InfoCo
    func updateInfoCo(idInfoCo:Int,idSessionCo:String,_ completion:ApiCompletionUser?){
        let infoCoJson:[String:Any] = ["idSessionConnexion":idSessionCo,"ID_infoCollective":idInfoCo]
        let url = URL(string:urlInscriptionInfoCo)!
        var request = URLRequest(url:url)
        request.httpMethod = "POST"
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: infoCoJson, options: .prettyPrinted)
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
    //Suppression d'une infoCo pour l'utilisateur connecté
    func deleteInfoCo(idSessionCo:String,_ completion:ApiCompletionUser?){
        let infoCoJson:[String:String] = ["idSessionConnexion":idSessionCo]
        let url = URL(string:urlDeleteInfoCo)!
        var request = URLRequest(url:url)
        request.httpMethod = "POST"
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: infoCoJson, options: .prettyPrinted)
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
    //Rajoute un document lié a un utilisateur en BD
    func addDocument(utilisateur:Utilisateur, idTypeDoc:Int, base64Image:String,_ completion:ApiCompletionUser?){
        let docDic:[String:Any] = ["base64":base64Image,"etat":1,"id_users":utilisateur.id!,"id_typeDocument":idTypeDoc]
        
        let url = URL(string:urlUserUpdateDoc)!
        var request = URLRequest(url:url)
        request.httpMethod = "POST"
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: docDic, options: .prettyPrinted)
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
    //Transforme string(json) en Utilisateur
    func getUserDefautForKeyUtilisateur()->Utilisateur{
            let userStringify = UserDefaults.standard.string(forKey: "utilisateur")
            let data = userStringify!.data(using: .utf8)
            return try! JSONDecoder().decode(Utilisateur.self, from: data!)
    }
    
    
//    func updateDocumentForUser(utilisateur:Utilisateur, idTypeDoc:Int, base64Image:String){
//        let doc:Document = Document(id: nil, id_users: utilisateur.id! , id_typeDocument: idTypeDoc, chemin: base64Image, etat: 1)
//            if erreur != nil {
//                print(erreur!)
//            }
//            if user != nil {
//                let utilisateurBytes = try! JSONEncoder().encode(user)
//                let utilisateurJSON = String(decoding: utilisateurBytes, as: UTF8.self)
//                UserDefaults.standard.set(utilisateurJSON, forKey: "utilisateur")
//            }
//        }
//    }
}
