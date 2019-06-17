//
//  ProgressBarCustom.swift
//  AdrarProject
//
//  Created by Vincent Maldonado on 13/06/2019.
//  Copyright © 2019 Vincent Maldonado. All rights reserved.
//

import UIKit

class ProgressBarCustom : UIProgressView {
    override init(frame: CGRect) {
        super.init(frame:frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup(){
        layer.borderColor = Gris.cgColor
        
    
    }
}
