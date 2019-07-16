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
        emailTF.isUserInteractionEnabled = false
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if let user = UserDefaults.standard.string(forKey: "utilisateur") {
            print("testuser \(user)")
            jsonToUser(user)
        }
    }
    
    //Transformation du json en données de type Utilisateur.
    private func jsonToUser(_ userString:String){
        if let result: Data = userString.data(using: .utf8) {
            do {
                userReceived = try JSONDecoder().decode(Utilisateur.self, from: result)
                print("2")
                if userReceived != nil {
                    injectInfo(userReceived!)
                }
            } catch {
                print("whut")
                print(error.localizedDescription)
            }
        }
    }
    
    //On affiche les données récuperer dans chaques textfield.
    private func injectInfo(_ user:Utilisateur){
        nomTF.text = user.nom
        prenomTF.text = user.prenom
        emailTF.text = user.email
        if user.ddn != nil {
            dateNaissanceTF.text = user.ddn
        }
        if user.telephone != nil {
            numeroTelTF.text = user.telephone
        }
        if user.numeroPe != nil {
            numeroPETF.text = user.numeroPe
        }
        if user.numeroVoie != nil {
            numeroDeVoieTF.text = user.numeroVoie
        }
        if user.adresse != nil {
            nomDeVoieTF.text = user.adresse
        }
        if user.complementAdresse != nil {
            complementAdresseTF.text = user.complementAdresse
        }
        if user.ville != nil {
            villeTF.text = user.ville
        }
        if user.cp != nil {
            codePostalTF.text = user.cp
        }
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
            checkedRes = false
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
        if self.checkedRes == false {
            sender.setImage(checkBoxRemplie, for: .normal)
            self.checkedRes = true
        } else {
            sender.setImage(checkBoxVide, for: .normal)
            self.checkedRes = false
        }
    }
    
    private func updateUser(){
        if userReceived != nil {
            DispatchQueue.main.async {
                UtilisateurAPIHelper().update(utilisateur: self.userReceived!) { (utilisateur, erreur) in
                    if erreur != nil {
                        print(erreur!)
                    }
                    if utilisateur != nil {
                        let utilisateurBytes = try! JSONEncoder().encode(utilisateur)
                        let utilisateurJSON = String(decoding: utilisateurBytes, as: UTF8.self)
                        UserDefaults.standard.set(utilisateurJSON, forKey: "utilisateur")
                    }
                }
            }
            
        }
        
    }
    
    private func updateUserReceived(){
        //utilise ?
        let mdp = UserDefaults.standard.string(forKey: "mdp")
        var ddn:String? = nil
        if let ddnUser = dateNaissanceTF.text, !ddnUser.isEmpty{
            ddn = ddnUser
        }
        var tel:String? = nil
        if let telUser = numeroTelTF.text, !telUser.isEmpty{
            tel = telUser
        }
        var numVoie:String? = nil
        if let numVoieUser = numeroDeVoieTF.text, !numVoieUser.isEmpty{
            numVoie = numVoieUser
        }
        var numPE:String? = nil
        if let numPEUser = numeroPETF.text, !numPEUser.isEmpty{
            numPE = numPEUser
        }
        var adresse:String? = nil
        if let adresseUser = nomDeVoieTF.text, !adresseUser.isEmpty{
            adresse = adresseUser
        }
        var complAdresse:String? = nil
        if let complAdresseUser = complementAdresseTF.text, !complAdresseUser.isEmpty{
            complAdresse = complAdresseUser
        }
        var cp:String? = nil
        if let cpUser = codePostalTF.text, !cpUser.isEmpty{
            cp = cpUser
        }
        var ville:String? = nil
        if let villeUser = villeTF.text, !villeUser.isEmpty{
            ville = villeUser
        }
        var dev:Int = 0
        if checkedDev == true {
            dev = 1
        }
        var res:Int = 0
        if checkedRes == true {
            res = 1
        }
        let newUser = Utilisateur(id: userReceived!.id, nom: nomTF.text!, prenom: prenomTF.text!, ddn: ddn, email: emailTF.text!, telephone: tel, numeroPe: numPE ,mdp:mdp ?? "", numeroVoie: numVoie, adresse: adresse, complementAdresse: complAdresse, cp: cp, ville: ville, dev: dev, reseau:res, admin: nil, idSessionConnexion: userReceived?.idSessionConnexion, ID_infoCollective: userReceived?.ID_infoCollective, ID_avancementInscription: userReceived?.ID_avancementInscription)
        userReceived = newUser
    }
    
    //Post les nouvelles informations
    @IBAction func ValiderInfoSupp(_ sender: Any) {
        updateUserReceived()
        updateUser()
        self.navigationController?.popToRootViewController(animated: true)
    }
    
   
    
}
