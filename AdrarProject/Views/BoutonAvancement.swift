//
//  BoutonAvancement.swift
//  AdrarProject
//
//  Created by Vincent Maldonado on 25/06/2019.
//  Copyright © 2019 Vincent Maldonado. All rights reserved.
//

import UIKit
//bouton arrondi sur progressBar dans AccueilEspace.Storyboard
class BoutonAvancement : UIButton {
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
        layer.cornerRadius = frame.height/2
        layer.borderColor = Gris.cgColor
        layer.borderWidth = 1
    }
}
