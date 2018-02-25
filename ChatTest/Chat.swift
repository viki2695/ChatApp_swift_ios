//
//  Chat.swift
//  ChatTest
//
//  Created by vigneswaran on 25/02/18.
//  Copyright © 2018 vigneswaran. All rights reserved.
//

import UIKit

class Chat{
    var userName:String?
    var text:String?
    var date:String?
    
    init(userName:String,text:String,date:String) {
        self.userName = userName
        self.text = text
        self.date = date
    }
}
