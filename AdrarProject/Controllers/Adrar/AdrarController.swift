//
//  AdrarController.swift
//  AdrarProject
//
//  Created by Vincent Maldonado on 04/06/2019.
//  Copyright © 2019 Vincent Maldonado. All rights reserved.
//

import UIKit
import WebKit

class AdrarController: UIViewController {
    
    @IBOutlet weak var infoAdrarWV: WKWebView!
    var loadingIV: LoadingView?
    override func viewDidLoad() {
        super.viewDidLoad()
        infoAdrarWV.navigationDelegate = self
        loadingIV = LoadingView(frame: CGRect(x: view.frame.width / 2 - 75  , y: view.frame.height / 2 - 75, width: 150, height: 150))
        loadingIV?.start()
        if loadingIV != nil {
            view.addSubview(loadingIV!)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0) { //Changement du timer de l'image d'attente.
            if let infoAdrarRecu = UserDefaults.standard.string(forKey: "adrar_html") {
                self.infoAdrarWV.loadHTMLString(infoAdrarRecu, baseURL: nil)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //tester l'affichage webview
    }
    
    //Revenir en arriere
@IBAction func backMenuFromAdrar(_ sender: Any) {
       dismiss(animated: true, completion: nil)
    }
}
//Gestion de l'image quand on attend la webview
extension AdrarController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loadingIV?.stop()
        loadingIV?.removeFromSuperview()
        loadingIV = nil
    }
    
}


