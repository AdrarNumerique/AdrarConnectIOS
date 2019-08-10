//
//  AuthentificationControllerViewController.swift
//  AdrarProject
//
//  Created by Vincent Maldonado on 12/06/2019.
//  Copyright © 2019 Vincent Maldonado. All rights reserved.
//

import UIKit

//Apres remplissage d'email et de mdp si l'utilisateur clique sur se connecter alors on va post et récuperer ses données?.
class AuthentificationControllerViewController: UIViewController {

    var erreurUtilisateur:Bool = false
    @IBOutlet weak var emailTf: UITextField!
    @IBOutlet weak var motDePasseTf: UITextField!
    @IBOutlet weak var authNonPossibleLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authNonPossibleLbl.isHidden = true
        self.motDePasseTf.delegate = self
        self.emailTf.delegate = self
//
//        var erreurUtilisateurDidSet:Bool = false {
//            didSet{
//
//                authNonPossibleLbl.text = "hi"
//            }
//        }
    }
    
    private func getUserAfterAuth(){
        //Si email et motdepasse n'est pas vide alors on lance de maniere asynchrone la méthode auth dans la classe UtilisateurAPIHelper
        if emailTf.text != "" , motDePasseTf.text != "" {
            DispatchQueue.main.async {
                UtilisateurAPIHelper().auth(email: self.emailTf.text!, mdp: self.motDePasseTf.text!, { (utilisateur, erreur) in
                    //Si utilisateur non nul alors on décode le json qu'on a et on le sauvegarde dans le cache.
                    if utilisateur != nil {
                        let utilisateurBytes = try! JSONEncoder().encode(utilisateur)
                        let utilisateurJSON = String(decoding: utilisateurBytes, as: UTF8.self)
                        UserDefaults.standard.set(utilisateurJSON, forKey: "utilisateur")
                        UserDefaults.standard.set(utilisateur!.idSessionConnexion, forKey: "idSession")
                        //Permet d'afficher que l'utilisateur n'est pas connu/bon quand on la tache asynchrone d'au dessus est fini.
                        DispatchQueue.main.async {
                            UserDefaults.standard.set(self.emailTf.text!, forKey: "email")
                            UserDefaults.standard.set(self.motDePasseTf.text!, forKey: "mdp")
                            self.authNonPossibleLbl.isHidden = true
                            self.dismiss(animated: true, completion: nil)
                        }
                    }
                    if erreur != nil {
                        self.erreurUtilisateur = true
                        DispatchQueue.main.async {
                            self.authNonPossibleLbl.isHidden = false
                            self.authNonPossibleLbl.text = "Utilisateur Inconnu"
                        }
                        
                    }
                })
            }
        //Si l'email et mot de passe pas bon.
        }else{
            authNonPossibleLbl.text = "Email ou Mot de passe vide"
            authNonPossibleLbl.isHidden = false
        }
    }
    //Si erreur alors affichage de l'erreur en question
    private func changeLblError(_ erreur:String){
        authNonPossibleLbl.text = erreur
        
    }
    
    @IBAction func SeConnecter(_ sender: Any) {
        UserDefaults.standard.set(motDePasseTf.text, forKey: "mdp")
        getUserAfterAuth()
    }
    
    @IBAction func BackButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func MdpPerdu(_ sender: Any) {
    }
    
}
