//
//  VCLogin.swift
//  ChatTest
//
//  Created by vigneswaran on 25/02/18.
//  Copyright © 2018 vigneswaran. All rights reserved.
//

import UIKit

class VCLogin: UIViewController {

    @IBOutlet weak var laUserName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func buLogin(_ sender: Any) {
        performSegue(withIdentifier: "chatRoom", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "chatRoom"{
            if let des = segue.destination as? ViewController {
                des.userName = laUserName.text
            }
        }
    }
}
