//
//  InformationsSuppViewController.swift
//  AdrarProject
//
//  Created by Vincent Maldonado on 12/06/2019.
//  Copyright © 2019 Vincent Maldonado. All rights reserved.

import UIKit
//InformationPerso
class InformationsSuppViewController: UIViewController {
    
    var checkedDev:Bool = false
    var checkedRes:Bool = false
    var userReceived:Utilisateur?
    
    @IBOutlet weak var nomTF: UITextField!
    @IBOutlet weak var prenomTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var motDePasseTF: UITextField!
    @IBOutlet weak var dateNaissanceTF: UITextField!
    @IBOutlet weak var numeroTelTF: UITextField!
    @IBOutlet weak var numeroPETF: UITextField!
    @IBOutlet weak var nomDeVoieTF: UITextField!
    @IBOutlet weak var numeroDeVoieTF: UITextField!
    @IBOutlet weak var complementAdresseTF: UITextField!
    @IBOutlet weak var villeTF: UITextField!
    @IBOutlet weak var codePostalTF: UITextField!
    @IBOutlet weak var devBtn: UIButton!
    @IBOutlet weak var resBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let user = UserDefaults.standard.string(forKey: "utilisateur") {
            jsonToUser(user)
        }
    }
    
    //Transformation du json en données de type Utilisateur.
    func jsonToUser(_ userString:String){
        if let result: Data = userString.data(using: .utf8) {
            do {
                userReceived = try JSONDecoder().decode(Utilisateur.self, from: result)
                if userReceived != nil {
                    injectInfo(userReceived!)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    //On affiche les données récuperer dans chaques textfield.
    func injectInfo(_ user:Utilisateur){
        nomTF.text = user.nom
        prenomTF.text = user.prenom
        emailTF.text = user.email
        motDePasseTF.text = user.mdp
        dateNaissanceTF.text = user.ddn ?? ""
        numeroTelTF.text = user.telephone ?? ""
        numeroPETF.text = user.numeroPe ?? ""
        nomDeVoieTF.text = user.adresse ?? ""
        numeroDeVoieTF.text = user.numeroVoie ?? ""
        complementAdresseTF.text = user.complementAdresse ?? ""
        villeTF.text = user.ville ?? ""
        codePostalTF.text = user.cp ?? ""
        if user.dev == 1 {
            checkedDev = true
            devBtn.setImage(checkBoxRemplie, for: .normal)
        } else {
            checkedDev = false
            devBtn.setImage(checkBoxVide, for: .normal)
        }
        if user.reseau == 1 {
            checkedRes = true
            resBtn.setImage(checkBoxRemplie, for: .normal)
        } else {
            resBtn.setImage(checkBoxVide, for: .normal)
        }
    }
    
    //Gestion du clique sur les checkBox
    @IBAction func changeImageDev(_ sender: UIButton) {
        if self.checkedDev == false{
            sender.setImage(checkBoxRemplie, for: .normal)
            self.checkedDev = true
        } else {
            sender.setImage(checkBoxVide, for: .normal)
            self.checkedDev = false
        }
        
    }
    
    @IBAction func changeImageReseau(_ sender: UIButton) {
        print("hi")
        if self.checkedRes == false {
            sender.setImage(checkBoxRemplie, for: .normal)
            self.checkedRes = true
        } else {
            sender.setImage(checkBoxVide, for: .normal)
            self.checkedRes = false
        }
    }
    
    //Post les nouvelles informations.
    @IBAction func ValiderInfoSupp(_ sender: Any) {
        //envoyer les valeurs dans bd
       self.navigationController?.popToRootViewController(animated: true)
    }
    
}
