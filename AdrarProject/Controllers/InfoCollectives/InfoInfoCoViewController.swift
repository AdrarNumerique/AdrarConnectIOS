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

    @IBOutlet weak var infoCoWV: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //récuperation de donnée(string) dans le cache qu'on transforme en html.
        if let infoRecu = UserDefaults.standard.string(forKey: "infoCo_html") {
            infoCoWV.loadHTMLString(infoRecu, baseURL: nil)
        }
    }
    

    @IBAction func backbutton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    

}
