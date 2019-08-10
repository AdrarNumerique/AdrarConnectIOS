//
//  InfoCollectiveTableViewCell.swift
//  AdrarProject
//
//  Created by Vincent Maldonado on 05/07/2019.
//  Copyright © 2019 Vincent Maldonado. All rights reserved.
//

import UIKit
import EventKit
//Gestion cellules des infocollectives.
class InfoCollectiveTableViewCell: UITableViewCell {
    
    var infoCo:InformationCollective!
    var userReservation:Int?
    
    @IBOutlet weak var descView: UIView!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var lieuLbl: UILabel!
    @IBOutlet weak var etatInfoCo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    //changement de couleur et de texte en fonction de si l'infoCo est complete ou non
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if infoCo.id == userReservation {
            descView.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            etatInfoCo.text = "Vous êtes inscrit à cette session \n"
            if infoCo.complet == 1 {
                etatInfoCo.text = "Vous êtes inscrit à cette session \n Complet"
                etatInfoCo.textColor = #colorLiteral(red: 1, green: 0.2705882353, blue: 0.2274509804, alpha: 1)
            }
        }else if infoCo.complet == 1 {
            descView.backgroundColor = #colorLiteral(red: 1, green: 0.3098039216, blue: 0.2666666667, alpha: 1)
            etatInfoCo.text = "Complet"
        }
    }
    
    //En fonction de ce que l'on récupere on change l'affichage complet ou non.
    func setupCell(_ infoCo: InformationCollective){
        self.infoCo = infoCo
        clipsToBounds = true
        descView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        descView.layer.cornerRadius = frame.height/20
    }
    
    
    
    
}
