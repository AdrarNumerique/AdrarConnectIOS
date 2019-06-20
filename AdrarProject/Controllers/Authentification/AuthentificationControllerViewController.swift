//
//  AuthentificationControllerViewController.swift
//  AdrarProject
//
//  Created by Vincent Maldonado on 12/06/2019.
//  Copyright © 2019 Vincent Maldonado. All rights reserved.
//

import UIKit

class AuthentificationControllerViewController: UIViewController {

    var utilisateurs:[Utilisateur] = myCollec.utilisateurs
    var utilisateurRecu:Utilisateur?
    
    @IBOutlet weak var emailTf: UITextField!
    @IBOutlet weak var motDePasseTf: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func compareEmail()->Bool{
        for user in utilisateurs {
            if let email = emailTf.text, email == user._email {
                print(" email good")
                utilisateurRecu = user
                return true
            }
        }
        print("email not good")
        return false
    }
    func compareMDP() -> Bool{
        if let utilisateur = utilisateurRecu, utilisateur.mdp == motDePasseTf.text {
            print("mdp good")
            return true
        }
        print("mdp not good")
        return false
    }

    @IBAction func SeConnecter(_ sender: Any) {
        if compareEmail() {
            if compareMDP(){
                dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func BackButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func MdpPerdu(_ sender: Any) {
    }
    
}
