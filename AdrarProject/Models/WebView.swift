//
//  WebView.swift
//  AdrarProject
//
//  Created by Vincent Maldonado on 19/06/2019.
//  Copyright © 2019 Vincent Maldonado. All rights reserved.
//

import Foundation

struct WebView:Decodable{
    var id:Int
    var nom:Int
    var html:text_encoding_t
    var tel:String?
    var email:String?
}
