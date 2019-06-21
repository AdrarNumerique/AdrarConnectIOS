//
//  AuthentificationControllerViewController.swift
//  AdrarProject
//
//  Created by Vincent Maldonado on 12/06/2019.
//  Copyright © 2019 Vincent Maldonado. All rights reserved.
//

import UIKit

class AuthentificationControllerViewController: UIViewController {

    
    @IBOutlet weak var emailTf: UITextField!
    @IBOutlet weak var motDePasseTf: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
//    func compareEmail()->Bool{
//
//    }
//    func compareMDP() -> Bool{
//
//    }

    @IBAction func SeConnecter(_ sender: Any) {
//        if compareEmail() {
//            if compareMDP(){
//                dismiss(animated: true, completion: nil)
//            }
//        }
    }
    
    @IBAction func BackButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func MdpPerdu(_ sender: Any) {
    }
    
}
