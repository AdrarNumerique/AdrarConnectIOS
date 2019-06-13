//
//  MenuController.swift
//  AdrarProject
//
//  Created by Vincent Maldonado on 03/06/2019.
//  Copyright © 2019 Vincent Maldonado. All rights reserved.
//

import UIKit

class MenuController: UIViewController {
    
    @IBOutlet weak var SeDecButton: UIButton!
    @IBOutlet weak var FAQButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FAQButton.isHidden = true
        SeDecButton.isHidden = true
        
        //Mise en place de la barre de navigation , pour avoir un logo.
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "LOGO ADRAR CONNECT")
        imageView.image = image
        navigationItem.titleView = imageView
    }
    
    
    @IBAction func testAdrartoMenu(_ sender: Any) {
    }
    
    @IBAction func SideMenu(_ sender: Any) {
        if FAQButton.isHidden == false {
            FAQButton.isHidden = true
            SeDecButton.isHidden = true
        } else {
            FAQButton.isHidden = false
            SeDecButton.isHidden = false
        }
    }
    
}

extension UITextView {
    override open func draw(_ rect: CGRect){
        super.draw(rect)
        setContentOffset(CGPoint.zero,animated: false)
    }
}

