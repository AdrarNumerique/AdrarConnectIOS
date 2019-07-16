//
//  InscriptionController.swift
//  AdrarProject
//
//  Created by Vincent Maldonado on 06/06/2019.
//  Copyright © 2019 Vincent Maldonado. All rights reserved.
//

import UIKit

class InscriptionController: UIViewController {
    
    
    @IBOutlet weak var prenomTf: UITextField!
    @IBOutlet weak var nomTf: UITextField!
    @IBOutlet weak var emailTf: UITextField!
    @IBOutlet weak var mdpTf: UITextField!
    @IBOutlet weak var confirmMdpTf: UITextField!
    @IBOutlet weak var returnError:UILabel!
    
    let regex = NSRegularExpression()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        returnError.isEnabled = false
        if #available(iOS 12.0, *) {
            mdpTf.textContentType = .oneTimeCode
            confirmMdpTf.textContentType = .oneTimeCode
        }
    }
    
    func returnError(_ error:String){
        returnError.isEnabled = true
        returnError.text = error
    }
    
    //Regex utilisé pour Mot de passe
    func isValidPassword(_ password: String) -> Bool {
        //let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[d$@$!%*?&#])[A-Za-z\\dd$@$!%*?&#]{8,}"
        //return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
        return true
    }
    //Regex utilisé pour email
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    //Mise en place d'une action pour revenir en arriere
    @IBAction func backMenu(_ sender: Any) {
       dismiss(animated: true, completion: nil)
    }
    //Condition pour pouvoir faire la requete post 
    @IBAction func inscriptionBtn(_ sender: Any) {
        
        if let prenom = prenomTf.text, prenom != "" {
            if let nom = nomTf.text, nom != "" {
                if let email = emailTf.text, isValidEmail(testStr: email){
                    if let mdp = mdpTf.text, isValidPassword(mdp){
                        if mdp == confirmMdpTf.text {
                            let utilisateur:Utilisateur = Utilisateur(id: nil, nom: nom, prenom: prenom, ddn: nil, email: email, telephone: nil, numeroPe: nil, mdp: mdp, numeroVoie: nil, adresse: nil, complementAdresse: nil, cp: nil, ville: nil, dev: nil, reseau: nil, admin: nil, idSessionConnexion: nil, ID_infoCollective: nil, ID_avancementInscription: nil)
                            DispatchQueue.main.async {
                                UtilisateurAPIHelper().signIn(utilisateur: utilisateur) { (utilisateurCompletion, erreur) in
                                    if utilisateurCompletion != nil {
                                        
                                        let utilisateurBytes = try! JSONEncoder().encode(utilisateurCompletion)
                                        
                                        let utilisateurJSON = String(decoding: utilisateurBytes, as: UTF8.self)
                                        print(utilisateurJSON)
                                        UserDefaults.standard.set(utilisateurCompletion!.idSessionConnexion, forKey: "idSession")
                                        UserDefaults.standard.set(self.mdpTf.text, forKey: "mdp")
                                        UserDefaults.standard.set(utilisateurJSON, forKey: "utilisateur")
                                        //Permet d'afficher que l'utilisateur n'est pas connu/bon quand on la tache asynchrone d'au dessus est fini.
                                        DispatchQueue.main.async {
                                            self.dismiss(animated: true, completion: nil)
                                        }
                                    }
                                    if erreur != nil {
                                        print(erreur!)
                                    }
                                }
                            }
                            
                        } else {
                            returnError("Les deux mots de passes sont différents")
                        }
                    } else {
                        returnError("Veuillez entrer un mot de passe valide (Le mot de passe doit comporter au minimum 8 caractères, une lettre majuscule, une lettre minuscule et un chiffre)")
                    }
                }else{
                    returnError("Veuillez entrer une adresse email valide")
                }
            }else {
                returnError("Veuillez entrer un nom valide (Non vide)")
            }
        }else {
            returnError("Veuillez entrer un prenom valide (Non vide)")
        }
    }
}
