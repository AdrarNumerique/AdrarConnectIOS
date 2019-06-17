//
//  InscriptionController.swift
//  AdrarProject
//
//  Created by Vincent Maldonado on 06/06/2019.
//  Copyright © 2019 Vincent Maldonado. All rights reserved.
//

import UIKit

class InscriptionController: UIViewController {
    let myCollec = UtilisateurCollection()
    
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

        // Do any additional setup after loading the view.
    }
    
    func returnError(_ error:String){
        returnError.isEnabled = true
        returnError.text = error
    }
    
    func isValidPassword(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[d$@$!%*?&#])[A-Za-z\\dd$@$!%*?&#]{8,}"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    //Mise en place d'une action pour revenir en arriere
    @IBAction func backMenu(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
   // isValidEmail(testStr: email)
    //, isValidPassword(mdp)
    @IBAction func inscriptionBtn(_ sender: Any) {
        if let prenom = prenomTf.text, prenom != "" {
            if let nom = nomTf.text, nom != "" {
                if let email = emailTf.text{
                    if let mdp = mdpTf.text{
                       
                        if mdp == confirmMdpTf.text {
                            let myUser = Utilisateur(prenom: prenom, nom: nom, email: email, mdp: mdp)
                            
                            myCollec.push(utilisateur: myUser)
                            UtilisateurCollection().push(utilisateur: myUser)
                            print(myCollec)
                            print(myCollec.getNb())
                            //dismiss(animated: true, completion: nil)
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
