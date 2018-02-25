//
//  TVCChat.swift
//  ChatTest
//
//  Created by vigneswaran on 25/02/18.
//  Copyright © 2018 vigneswaran. All rights reserved.
//

import UIKit

class TVCChat: UITableViewCell {

    @IBOutlet weak var laUserName: UILabel!
    @IBOutlet weak var laText: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setChat(chat:Chat){
        laUserName.text = chat.userName
        laText.text = chat.text
    }

}
