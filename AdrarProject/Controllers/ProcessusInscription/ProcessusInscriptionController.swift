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
    @IBOutlet weak var constraintWebView: NSLayoutConstraint!
    var loadingIV: LoadingView?
    
    
    private var textSituationSalarie: String! = "page html vide "
    private var textSituationDemandeur: String! = "page html vide "
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionWV.navigationDelegate = self
        imageWhileLoad()
        catchHtml()
        
    }
    //function qui gere la taille et l'animation de la vue de chargement
    func imageWhileLoad(){
        loadingIV = LoadingView(frame: CGRect(x: view.frame.width / 2 - 75  , y: view.frame.height / 2 - 75, width: 150, height: 150))
        loadingIV?.start()
        if loadingIV != nil {
            view.addSubview(loadingIV!)
        }
    }
    
    //Function qui va aller récuperer la data dans l'objet USERDEFAULT pour récuperer les données récupérées ou non et les afficher dans la webview sous format html.
    private func catchHtml(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            if UserDefaults.standard.string(forKey: "salarie_html") != nil && (UserDefaults.standard.string(forKey: "demandeurEmploi_html") != nil) {
                self.textSituationSalarie = UserDefaults.standard.string(forKey:"salarie_html")
                self.textSituationDemandeur = UserDefaults.standard.string(forKey:"demandeurEmploi_html")
                self.descriptionWV.loadHTMLString(self.textSituationDemandeur, baseURL: nil)
            }
            if let tel = UserDefaults.standard.string(forKey: "telephone") {
                self.telephoneTV.text = "Telephone :\n\(tel)"
            }
            if let email = UserDefaults.standard.string(forKey: "emailAdrar") {
                self.mailTV.text = "Email :\n\(email)"
            }
        }
    }
    // Sur le SegmentedControl un va rajouter un switch pour le nombre de possibilité de celui-ci, qui changera la valeur de zone de texte et cachera/montrera le button/contact.
    @IBAction func SegmentedSituation(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex{
        case 0:
            SituationLbl.text = "Demandeur d'Emploi"
        descriptionWV.loadHTMLString(textSituationDemandeur, baseURL: nil)
        contactSV.isHidden = true
        if UserDefaults.standard.string(forKey: "utilisateur") != nil {
            ButtonToinscrire.isHidden = true
            constraintWebView.constant = -((ButtonToinscrire.bounds.height)+8)
        } else {
            ButtonToinscrire.isHidden = false
        }
        case 1:
        SituationLbl.text = "Salarié"
        descriptionWV.loadHTMLString(textSituationSalarie, baseURL: nil)
        ButtonToinscrire.isHidden = true
        contactSV.isHidden = false
        constraintWebView.constant = 8
        default: break
        }
    }
    
    //Action pour revenir en arriere
    @IBAction func backMenu(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

//Gestion de l'image quand on attend la webview
extension ProcessusInscriptionController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loadingIV?.stop()
        loadingIV?.removeFromSuperview()
        loadingIV = nil
    }
}
