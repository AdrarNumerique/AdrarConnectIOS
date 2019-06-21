//
//  QuestionReponseCell.swift
//  AdrarProject
//
//  Created by Vincent Maldonado on 14/06/2019.
//  Copyright © 2019 Vincent Maldonado. All rights reserved.
//

import UIKit

class QuestionReponseCell: UITableViewCell {
    
    @IBOutlet weak var questionLbl: UILabel!
    @IBOutlet weak var reponseLbl: UILabel!
    var questionReponse:QuestionReponse!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupCell(_ questionReponse: QuestionReponse){
        self.questionReponse = questionReponse
    
        
    }
}
