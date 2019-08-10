//
//  LaunchScreenViewController.swift
//  AdrarProject
//
//  Created by Vincent Maldonado on 28/06/2019.
//  Copyright © 2019 Vincent Maldonado. All rights reserved.
//

import UIKit

class LaunchScreenViewController: UIViewController {

    @IBOutlet var globalView: UIView!
    @IBOutlet weak var imageLaunch: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        reauth()
        UIView.animate(withDuration: 1, delay: 0, options: .curveLinear, animations: {
            self.imageLaunch.center = CGPoint(x: self.imageLaunch.center.x, y: -self.view.center.y +  self.imageLaunch.bounds.height)
            self.imageLaunch.transform = CGAffineTransform(scaleX: 0.4, y: 0.4)
        })
    }
    
    func reauth(){
        //        print(UserDefaults.standard.string(forKey: "mdp"))
        //        print(UserDefaults.standard.string(forKey: "utilisateur"))
        //        print(UserDefaults.standard.string(forKey: "email"))
        if let mdp = UserDefaults.standard.string(forKey: "mdp") , let email = UserDefaults.standard.string(forKey: "email"), UserDefaults.standard.string(forKey: "utilisateur") == nil {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                UtilisateurAPIHelper().auth(email: email, mdp: mdp) { (utilisateur, erreur) in
                    if utilisateur != nil {
                        let utilisateurBytes = try! JSONEncoder().encode(utilisateur)
                        let utilisateurJSON = String(decoding: utilisateurBytes, as: UTF8.self)
                        DispatchQueue.main.async {
                            UserDefaults.standard.set(utilisateurJSON, forKey: "utilisateur")
                            UserDefaults.standard.set(utilisateur!.idSessionConnexion, forKey: "idSession")
                            self.goToMenu()
                        }
                    }
                    if erreur != nil {
                        print(erreur!)
                        self.goToMenu()
                    }
                }
            }
//            DispatchQueue.main.async {
//                UtilisateurAPIHelper().auth(email: email, mdp: mdp) { (utilisateur, erreur) in
//                    if utilisateur != nil {
//                        let utilisateurBytes = try! JSONEncoder().encode(utilisateur)
//                        let utilisateurJSON = String(decoding: utilisateurBytes, as: UTF8.self)
//                        DispatchQueue.main.async {
//                            UserDefaults.standard.set(utilisateurJSON, forKey: "utilisateur")
//                            UserDefaults.standard.set(utilisateur!.idSessionConnexion, forKey: "idSession")
//                            self.goToMenu()
//                        }
//                    }
//                    if erreur != nil {
//                        print(erreur!)
//                        self.goToMenu()
//                    }
//                }
//            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.goToMenu()
            }
        }
    }
    func goToMenu(){
        let storyboard = UIStoryboard(name: "Menu", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "Menu")
        self.present(controller, animated: false, completion: nil)
    }
}


