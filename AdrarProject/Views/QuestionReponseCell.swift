//
//  QuestionReponseCell.swift
//  AdrarProject
//
//  Created by Vincent Maldonado on 14/06/2019.
//  Copyright © 2019 Vincent Maldonado. All rights reserved.
//

import UIKit
//affichage dans les cellules de la faq
class QuestionReponseCell: UITableViewCell {
    
    @IBOutlet weak var questionLbl: UILabel!
    @IBOutlet weak var reponseLbl: UILabel!
    @IBOutlet weak var voirReponseBtn: UIButton!
    var questionReponse:QuestionReponse!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupCell(_ questionReponse: QuestionReponse){
        self.questionReponse = questionReponse
        clipsToBounds = true
    }
    //changement sur le click, affichage reponse ou non et changement de l'icone fleche
//    @IBAction func cliqueReponsebtn(_ sender: Any) {
//        if reponseLbl.isHidden{
//            reponseLbl.isHidden = false
//            voirReponseBtn.setImage(UIImage(named: "icone-fleche-haut"), for: .normal)
//        } else {
//            reponseLbl.isHidden = true
//            voirReponseBtn.setImage(UIImage(named: "icone-fleche-bas"), for: .normal)
//        }
//    }
}
