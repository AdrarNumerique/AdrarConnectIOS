//
//  ProcessusInscriptionController.swift
//  AdrarProject
//
//  Created by Vincent Maldonado on 05/06/2019.
//  Copyright © 2019 Vincent Maldonado. All rights reserved.
//

import UIKit
import WebKit


class ProcessusInscriptionController: UIViewController {
    //Outlet
    @IBOutlet weak var SituationLbl: UILabel!
    @IBOutlet weak var descriptionWV: WKWebView!
    @IBOutlet weak var MoreInformation: UIView!
    @IBOutlet weak var ButtonToinscrire: RoundButton!
    @IBOutlet weak var contactSV: UIStackView!
    @IBOutlet weak var telephoneTV: UITextView!
    @IBOutlet weak var mailTV: UITextView!
    
    private var textSituationSalarie: String! = "page html vide "
    private var textSituationDemandeur: String! = "page html vide "
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionWV.loadHTMLString(textSituationSalarie, baseURL: nil)
    }
    //checker ou le plus rapide
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        catchHtml()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //catchHtml("salarie_html", true)
    }
    
    //Function qui va aller récuperer la data dans l'objet USERDEFAULT pour récuperer les données récupérées ou non et les afficher dans la webview sous format html.
    private func catchHtml(){
        if UserDefaults.standard.string(forKey: "salarie_html") != nil && (UserDefaults.standard.string(forKey: "demandeurEmploi_html") != nil) {
            self.textSituationSalarie = UserDefaults.standard.string(forKey:"salarie_html")
            self.textSituationDemandeur = UserDefaults.standard.string(forKey:"demandeurEmploi_html")
            descriptionWV.loadHTMLString(textSituationSalarie, baseURL: nil)
        }
        
        if let tel = UserDefaults.standard.string(forKey: "telephone") {
            telephoneTV.text = "Telephone :\n\(tel)"
        }
        if let email = UserDefaults.standard.string(forKey: "email") {
            mailTV.text = "Email :\n\(email)"
        }
    }
    // Sur le SegmentedControl un va rajouter un switch pour le nombre de possibilité de celui-ci, qui changera la valeur de zone de texte et cachera/montrera le button/contact.
    @IBAction func SegmentedSituation(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex{
        case 0: SituationLbl.text = "Salarié"
        descriptionWV.loadHTMLString(textSituationSalarie, baseURL: nil)
        ButtonToinscrire.isHidden = true
        contactSV.isHidden = false
            
        case 1: SituationLbl.text = "Demandeur d'Emploi"
        descriptionWV.loadHTMLString(textSituationDemandeur, baseURL: nil)
        ButtonToinscrire.isHidden = false
        contactSV.isHidden = true
            
        default: break
        }
        
    }
    
    
    
    //Action pour revenir en arriere
    @IBAction func backMenu(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

