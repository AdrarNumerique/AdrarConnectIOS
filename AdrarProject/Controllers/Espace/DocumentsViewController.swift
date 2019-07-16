//
//  DocumentsViewController.swift
//  AdrarProject
//
//  Created by Vincent Maldonado on 12/06/2019.
//  Copyright © 2019 Vincent Maldonado. All rights reserved.
//

import UIKit
//Gestion d'envoie des documents.
class DocumentsViewController: UIViewController {
    
    private var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func libraryAction(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
   
    @IBAction func validerEtRetour(_ sender: Any) {
        //valider
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    
}
