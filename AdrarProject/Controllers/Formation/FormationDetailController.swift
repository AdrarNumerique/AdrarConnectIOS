//
//  FormationDetailController.swift
//  AdrarProject
//
//  Created by Vincent Maldonado on 06/06/2019.
//  Copyright © 2019 Vincent Maldonado. All rights reserved.
//

import UIKit
import WebKit
//Renvoie à un storyboards de type FormationDetailController des informations sur les Formations
class FormationDetailController: UIViewController {
    
        @IBOutlet weak var titleLbl: UILabel!
        @IBOutlet weak var descriptionWebView: WKWebView!
    
        private var loadingIV: LoadingView?
        var formationRecue: Formation?
    
        //Cycle de vie du controller. Loadview en premier (fait automatiquement avec storyboards). viewdidload qui charge en mémoire la vue mais qui ne l'affiche pas
        override func viewDidLoad() {
            super.viewDidLoad()
            
            loadingIV = LoadingView(frame: CGRect(x: view.frame.width / 2 - 75  , y: view.frame.height / 2 - 75, width: 150, height: 150))
            loadingIV?.start()
            if loadingIV != nil {
                view.addSubview(loadingIV!)
            }
            
            //guard permet de verifié que formationReceived n'est pas nulle vu qu'elle est optionnelle de base.
            guard let formation = formationRecue else { return }
            titleLbl.text = formation.intitule
            descriptionWebView.loadHTMLString(formation.html, baseURL: nil)
            descriptionWebView.navigationDelegate = self
            
            //on déclare des attributs qu'on ajoute ensuite dans notre Outlet " titleLbl"
            let mutable = NSMutableAttributedString(string: formation.intitule , attributes: [.foregroundColor:UIColor.black, .font:UIFont.boldSystemFont(ofSize: 20)])
            titleLbl.attributedText = mutable
            titleLbl.textAlignment = .center
            titleLbl.backgroundColor = Jaune
        }
}
//Extension faites pour la l'icone de chargement (Adrar)
extension FormationDetailController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loadingIV?.stop()
        loadingIV?.removeFromSuperview()
        loadingIV = nil
    }
    
}
