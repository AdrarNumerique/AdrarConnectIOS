//
//  AdrarController.swift
//  AdrarProject
//
//  Created by Vincent Maldonado on 04/06/2019.
//  Copyright © 2019 Vincent Maldonado. All rights reserved.
//

import UIKit

class AdrarController: UIViewController {
    
    @IBOutlet weak var AdrarPresentation: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //Revenir en arriere
@IBAction func backMenuFromAdrar(_ sender: Any) {
       dismiss(animated: true, completion: nil)
        

    }
}
