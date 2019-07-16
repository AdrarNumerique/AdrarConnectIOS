//
//  MenuController.swift
//  AdrarProject
//
//  Created by Vincent Maldonado on 03/06/2019.
//  Copyright © 2019 Vincent Maldonado. All rights reserved.
//

import UIKit
class MenuController: UIViewController {
    
    private let stringError: String = "Pas d'html disponible"
    private var userConnected:Bool = false
    private var utilisateur:Utilisateur?
    
    @IBOutlet weak var SeDecButton: UIButton!
    @IBOutlet weak var FAQButton: UIButton!
    @IBOutlet weak var SwitchButtonAuthOrEspace: UIButton!
    @IBOutlet weak var SwitchInscriptionUtiOrInfoCo: RoundButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Mise en place de la barre de navigation , pour avoir un logo.
        let imageView = UIImageView(frame: CGRect(x:0, y: 0, width: 50, height: 50))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "LOGO ADRAR CONNECT")
        imageView.image = image
        navigationItem.titleView = imageView
        getAccueil()
    }
    //Quand la vue s'affiche on remet a jour la barre de navigation et on vérifie si un utilisateur est sauvegarder dans UserDefault ( cache )
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        FAQButton.isHidden = true
        SeDecButton.isHidden = true
        userReceived()
    }
    private func stockUser(){
        
    }
    //au lancement de l'application et au chargement du storyboard on va Get pour récuperer les formations, les infoco, les questions/Reponses et les json/html pour l'adrar l'infoCo et processusInscription. Gestion des données, si string stockage direct sinon transformation en json pour pouvoir stocker dans userDefault(qui ne permet pas de stocker des Custom Class directement)
    private func getAccueil(){
        AccueilAPIHelper().getAccueil("http://localhost:3000/ws/accueil") { (listeFormation, adrarHtml, infoCoHtml, processusInscription, listeInfoCo, listeFAQ, erreur) in

            if listeFormation != nil {
                let formationsBytes = try! JSONEncoder().encode(listeFormation)
                let formationsJSON = String(decoding: formationsBytes, as: UTF8.self)
                UserDefaults.standard.set(formationsJSON, forKey: "formations")
            }
            if adrarHtml != nil {
                UserDefaults.standard.set(adrarHtml, forKey:"adrar_html" )
            } else if adrarHtml == nil && UserDefaults.standard.string(forKey: "adrar_html") == nil {
                UserDefaults.standard.set(self.stringError, forKey: "adrar_html")
            }
            if infoCoHtml != nil {
                UserDefaults.standard.set(infoCoHtml, forKey:"infoCo_html" )
            } else if infoCoHtml == nil && UserDefaults.standard.string(forKey: "infoCo_html") == nil {
                UserDefaults.standard.set(self.stringError, forKey: "infoCo_html")
            }
            if processusInscription != nil {
                if processusInscription?.salarie_html != nil {
                    UserDefaults.standard.set(processusInscription?.salarie_html, forKey:"salarie_html" )
                }
                if processusInscription?.demandeurEmploi_html != nil {
                    UserDefaults.standard.set(processusInscription?.demandeurEmploi_html, forKey:"demandeurEmploi_html" )
                }
                if processusInscription?.telephone != nil {
                    UserDefaults.standard.set(processusInscription?.telephone, forKey:"telephone" )
                }
                if processusInscription?.email != nil {
                    UserDefaults.standard.set(processusInscription?.email, forKey:"email" )
                }
            }
            if listeInfoCo != nil {
                let infosCosBytes = try! JSONEncoder().encode(listeInfoCo)
                let infosCosJSON = String(decoding: infosCosBytes, as: UTF8.self)
                UserDefaults.standard.set(infosCosJSON, forKey: "infosCos")
            }
            if listeFAQ != nil {
                let faqBytes = try! JSONEncoder().encode(listeFAQ)
                let faqJSON = String(decoding: faqBytes, as: UTF8.self)
                UserDefaults.standard.set(faqJSON, forKey: "faq")
            }
            if erreur != nil {
                //????
            }

        }

    }

    //Vérification dans le cache si un utilisateur existe ou non
    private func userReceived(){
        if UserDefaults.standard.string(forKey: "utilisateur") != nil {
                updateSegueIfUserConnected()
        } else {
                updateSegueIfUserNotConnected()
        }
    }
    
    //Changement du texte sur les bouton qui permettent d'acceder à de nouvelles pages en fonction de si l'utilisateur est connecté
    private func updateSegueIfUserConnected(){
        userConnected = true
        SwitchButtonAuthOrEspace.setTitle("Mon Espace", for: .normal)
        SwitchInscriptionUtiOrInfoCo.setTitle("Information Collective", for: .normal)
        
    }
    //Changement du texte sur les bouton qui permettent d'acceder à de nouvelles pages en fonction de si l'utilisateur est connecté
    private func updateSegueIfUserNotConnected(){
        userConnected = false
        SwitchButtonAuthOrEspace.setTitle("Se Connecter", for: .normal)
        SwitchInscriptionUtiOrInfoCo.setTitle("S'inscrire", for: .normal)
    }
    //Si l'utilisateur appuie sur "Se déconnecter" présent dans la bar de navigation alors on supprime les données de l"utilisateur du cache.
    @IBAction func deconnectUser(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "utilisateur")
        UserDefaults.standard.removeObject(forKey: "mdp")
        UserDefaults.standard.removeObject(forKey: "idSession")
        userReceived()
        SeDecButton.isHidden = true
    }
    
    //Sur bouton on modifie la direction sur laquelle on va en fonction de si l'utilisateur est connecté ou non
    @IBAction func toSignOrInfoCo(_ sender: Any) {
        if userConnected {
            //send id infoCo si il en a une !
            let storyboard = UIStoryboard(name: "InformationCollective", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "infoCo")
            self.present(controller, animated: true, completion: nil)
            
        } else {
            let storyboard = UIStoryboard(name: "Inscription", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "Inscription")
            self.present(controller, animated: true, completion: nil)
        }
    }
    //Sur bouton on modifie la direction sur laquelle on va en fonction de si l'utilisateur est connecté ou non
    @IBAction func toConnectOrEspace(_ sender: Any) {
        if userConnected {
            let storyboard = UIStoryboard(name: "AccueilEspace", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "espace")
            self.present(controller, animated: true, completion: nil)
        } else {
            let storyboard = UIStoryboard(name: "Authentification", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "Authentification")
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    //Gestion du Menu
    @IBAction func SideMenu(_ sender: Any) {
        if FAQButton.isHidden == false {
            FAQButton.isHidden = true
            SeDecButton.isHidden = true
        } else {
            FAQButton.isHidden = false
            if userConnected == true{
                SeDecButton.isHidden = false
            }
        }
    }
    
}

