//
//  QuestionReponse.swift
//  AdrarProject
//
//  Created by Vincent Maldonado on 12/06/2019.
//  Copyright © 2019 Vincent Maldonado. All rights reserved.
//

import Foundation


class QuestionReponse {
    private var _question:String
    private var _reponse:String
    
    var question:String {
        return _question
    }
    var reponse:String {
        return _reponse
    }
    
    init(question:String,reponse:String) {
        _question = question
        _reponse = reponse
    }
}
