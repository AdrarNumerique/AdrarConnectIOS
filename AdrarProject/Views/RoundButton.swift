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
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup(){
        clipsToBounds = true
        contentMode = .scaleAspectFill
        layer.cornerRadius = frame.height/15
        layer.borderColor = Gris.cgColor
        layer.borderWidth = 2
    }
    
}
