//
//  MenuController.swift
//  AdrarProject
//
//  Created by Vincent Maldonado on 03/06/2019.
//  Copyright © 2019 Vincent Maldonado. All rights reserved.
//

import UIKit

class MenuController: UIViewController {
    
    @IBOutlet weak var SeDecButton: UIButton!
    @IBOutlet weak var FAQButton: UIButton!
    @IBOutlet weak var SwitchButtonAuthOrEspace: UIButton!
    @IBOutlet weak var SwitchInscriptionUtiOrInfoCo: RoundButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        FAQButton.isHidden = true
        SeDecButton.isHidden = true
        
        //Mise en place de la barre de navigation , pour avoir un logo.
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "LOGO ADRAR CONNECT")
        imageView.image = image
        navigationItem.titleView = imageView
        userReceived(utilisateur: nil)
    }
    
    func userReceived(utilisateur: Utilisateur?){
        if let utilisateurReceived = utilisateur{
            SwitchButtonAuthOrEspace.setTitle("Espace", for: .normal)
            SwitchInscriptionUtiOrInfoCo.setTitle("Information Collective", for: .normal)
        }
    }
    
    @IBAction func espaceBtn(_ sender: Any) {
        //gerer quand on est co
    }
    
    @IBAction func infoCoBtn(_ sender: Any) {
        //créer les infoCo
    }
    
    @IBAction func testAdrartoMenu(_ sender: Any) {
        //??
    }
    
    @IBAction func SideMenu(_ sender: Any) {
        if FAQButton.isHidden == false {
            FAQButton.isHidden = true
            SeDecButton.isHidden = true
        } else {
            FAQButton.isHidden = false
            //SeDecButton.isHidden = false
        }
    }
    
}
//????
extension UITextView {
    override open func draw(_ rect: CGRect){
        super.draw(rect)
        setContentOffset(CGPoint.zero,animated: false)
    }
}

