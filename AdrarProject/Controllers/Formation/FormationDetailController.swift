//
//  FormationDetailController.swift
//  AdrarProject
//
//  Created by Vincent Maldonado on 06/06/2019.
//  Copyright © 2019 Vincent Maldonado. All rights reserved.
//

import UIKit
//Renvoie à un storyboards de type FormationDetailController des informations sur les Formations
class FormationDetailController: UIViewController {
    
        @IBOutlet weak var nameAndDesc: UITextView!
        var formationReceived: Formation?
    
        //Cicle de vie du controller. Loadview en premier (fait automatiquement avec storyboards). viewdidload qui charge en mémoire la vue mais qui ne l'affiche pas
        override func viewDidLoad() {
            super.viewDidLoad()
            //guard permet de verifié que formationReceived n'est pas nulle vu qu'elle est optionnelle de base.
            guard let formation = formationReceived else { return }
            //on déclare des attributs qu'on ajoute ensuite dans notre Outlet " nameAndDesc"
            let mutable = NSMutableAttributedString(string: formation.intitule + "\n\n", attributes: [.foregroundColor:Rouge
                ,.font:UIFont.boldSystemFont(ofSize: 20)])
            mutable.append(NSAttributedString(string: formation.description, attributes: [.font:UIFont.boldSystemFont(ofSize: 16),
                                                                               .foregroundColor:UIColor.darkGray]))
            nameAndDesc.attributedText = mutable
            nameAndDesc.textAlignment = .center
            //Permet que le textfield scrollable affiche le haut en premier
        }
}
