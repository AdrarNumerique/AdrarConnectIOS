//
//  InscriptionController.swift
//  AdrarProject
//
//  Created by Vincent Maldonado on 06/06/2019.
//  Copyright © 2019 Vincent Maldonado. All rights reserved.
//

import UIKit

class InscriptionController: UIViewController{
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var prenomTf: UITextField!
    @IBOutlet weak var nomTf: UITextField!
    @IBOutlet weak var emailTf: UITextField!
    @IBOutlet weak var mdpTf: UITextField!
    @IBOutlet weak var confirmMdpTf: UITextField!
    @IBOutlet weak var returnError:UILabel!
    
    @IBOutlet weak var constraintStackView: NSLayoutConstraint!
    let regex = NSRegularExpression()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        returnError.isEnabled = false
        
        self.prenomTf.delegate = self
        self.nomTf.delegate = self
        self.emailTf.delegate = self
        self.mdpTf.delegate = self
        self.confirmMdpTf.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //Gestion de l'affichage du clavier
    @objc func keyboardWillShow(sender: NSNotification) {

        if self.view.frame.origin.y == 0 {
            self.view.frame.origin.y -= 100
        }
    }
    @objc func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y += 100
    }
    
    func returnError(_ error:String){
        returnError.isEnabled = true
        returnError.text = error
    }
    
    //Regex utilisé pour Mot de passe
    func isValidPassword(_ password: String) -> Bool {
        //Regex 8 caractères une lettre majuscule, une lettre minuscule et un chiffre
        //let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[d$@$!%*?&#])[A-Za-z\\dd$@$!%*?&#]{8,}"
        let passwordRegex = "{4}"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
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
                            let utilisateur:Utilisateur = Utilisateur(id: nil, nom: nom, prenom: prenom, ddn: nil, email: email, telephone: nil, numeroPe: nil, mdp: mdp, numeroVoie: nil, adresse: nil, complementAdresse: nil, cp: nil, ville: nil, dev: nil, reseau: nil, admin: nil, idSessionConnexion: nil, ID_infoCollective: nil, ID_avancementInscription: nil,documents: nil)
                            DispatchQueue.main.async {
                                UtilisateurAPIHelper().signIn(utilisateur: utilisateur) { (utilisateurCompletion, erreur) in
                                    if utilisateurCompletion != nil {
                                        
                                        let utilisateurBytes = try! JSONEncoder().encode(utilisateurCompletion)
                                        
                                        let utilisateurJSON = String(decoding: utilisateurBytes, as: UTF8.self)
                                        print(utilisateurJSON)
                                        UserDefaults.standard.set(utilisateurCompletion!.idSessionConnexion, forKey: "idSession")
                                        UserDefaults.standard.set(self.mdpTf.text, forKey: "mdp")
                                        UserDefaults.standard.set(utilisateurJSON, forKey: "utilisateur")
                                        UserDefaults.standard.set(self.emailTf.text, forKey: "email")
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
                        returnError("Veuillez entrer un mot de passe valide (Le mot de passe doit comporter au minimum 6 caractères)")
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
