//
//  InfoInfoCoViewController.swift
//  AdrarProject
//
//  Created by Vincent Maldonado on 27/06/2019.
//  Copyright © 2019 Vincent Maldonado. All rights reserved.
//

import UIKit
import WebKit
//page d'information sur les infocollectives.
class InfoInfoCoViewController: UIViewController {

    @IBOutlet weak var buttonContinueInfoCo: UIButton!
    @IBOutlet weak var infoCoWV: WKWebView!
    var loadingIV: LoadingView?
    var userReceived: Utilisateur?
    
    //cycle de vie , chargement page
    override func viewDidLoad() {
        super.viewDidLoad()
        //récuperation de donnée(string) dans le cache qu'on transforme en html.
        chargeHtml()
        
    }
    //cycle de vie, affichage vue
    override func viewWillAppear(_ animated: Bool) {
        userIsReceived()
        if userReceived?.ID_avancementInscription != nil{
            if userReceived!.ID_avancementInscription! < 3{
                buttonContinueInfoCo.setTitle("En attente de la validation de vos documents par l'Adrar", for: .normal)
                buttonContinueInfoCo.setTitleColor(.red, for: .normal)
            }
        }
    }
    func chargeHtml(){
        infoCoWV.navigationDelegate = self
        loadingIV = LoadingView(frame: CGRect(x: view.frame.width / 2 - 75  , y: view.frame.height / 2 - 75, width: 150, height: 150))
        loadingIV?.start()
        if loadingIV != nil {
            view.addSubview(loadingIV!)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { //Changement du timer de l'image d'attente.
            if let infoRecu = UserDefaults.standard.string(forKey: "infoCo_html") {
                self.infoCoWV.loadHTMLString(infoRecu, baseURL: nil)
            }
        }
    }
    func userIsReceived(){
        if UserDefaults.standard.string(forKey: "utilisateur") != nil {
            userReceived = UtilisateurAPIHelper().getUserDefautForKeyUtilisateur()
        }
    }
    @IBAction func checkIfStepIsMoreThan3(_ sender: Any) {
        if userReceived != nil {
            if userReceived?.ID_avancementInscription != nil{
                if userReceived!.ID_avancementInscription! >= 3{
                    let storyboard = UIStoryboard(name: "InformationCollective", bundle: nil)
                    let controller = storyboard.instantiateViewController(withIdentifier: "listeInfoCo")
                    self.show(controller, sender: nil)
                }
            }
        }
    }

    @IBAction func backbutton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension InfoInfoCoViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loadingIV?.stop()
        loadingIV?.removeFromSuperview()
        loadingIV = nil
    }
    
}
