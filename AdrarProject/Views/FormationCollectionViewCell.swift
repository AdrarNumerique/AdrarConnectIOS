//
//  FormationCollectionViewCell.swift
//  AdrarProject
//
//  Created by Vincent Maldonado on 07/06/2019.
//  Copyright © 2019 Vincent Maldonado. All rights reserved.
//

//une cellule d'une Collection View
import UIKit

class FormationCollectionViewCell: UICollectionViewCell {
    
    //Outlet d'un Label
    @IBOutlet weak var intituleFormation: UILabel!
    
    @IBOutlet weak var imageFormation: UIImageView!
    
   
//    var formation:Formation? {
//        //permet d'effectuer une  action quand la propriété est modifiée, observer la modification de propriété stockées.
//        didSet{
//            if formation != nil {
//                intituleFormation.text = formation!.intitule
//                imageFormation.image
//            }
//        }
//    }
}
