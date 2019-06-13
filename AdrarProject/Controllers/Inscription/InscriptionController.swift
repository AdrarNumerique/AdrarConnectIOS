//
//  InscriptionController.swift
//  AdrarProject
//
//  Created by Vincent Maldonado on 06/06/2019.
//  Copyright © 2019 Vincent Maldonado. All rights reserved.
//

import UIKit

class InscriptionController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    //Mise en place d'une action pour revenir en arriere
    @IBAction func backMenu(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
