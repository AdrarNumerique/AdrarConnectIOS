//
//  MenuViewCell.swift
//  AdrarProject
//
//  Created by Vincent Maldonado on 03/06/2019.
//  Copyright © 2019 Vincent Maldonado. All rights reserved.
//


// Pattern utilisé pour avoir un Boutton rond dans les Storyboards
import UIKit

class RoundButton: UIButton {
    //programmatique
    override init(frame: CGRect) {
        super.init(frame:frame)
        setup()
    }
    //storyboard/xib
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    //Changement graphique de manière programatique de bouton
    private func setup(){
        clipsToBounds = true
        contentMode = .scaleAspectFill
        layer.cornerRadius = frame.height/8
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 2
        self.setTitleShadowColor(.black, for: .normal)
    }
    
}


