//
//  ViewController.swift
//  ChatTest
//
//  Created by vigneswaran on 25/02/18.
//  Copyright © 2018 vigneswaran. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    var ref = DatabaseReference.init() //creating instance from firebase database
    //label for chat text enter
    @IBOutlet weak var txtChat: UITextField!
    var userName:String?
    @IBOutlet weak var laChatList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        loginAnomynous()
        self.ref = Database.database().reference()
        
        laChatList.delegate = self
        laChatList.dataSource = self
    }


    func loginAnomynous(){
        Auth.auth().signInAnonymously(){
            (user,error) in
            
            if let error = error{
                print("cannot login \(error)")
            }else{
                print("User UID \(user?.uid)")
                self.loadChatRoom()
            }
        }
    }
    
    //button action to send text to chat room
    @IBAction func buSend(_ sender: Any) {
        
        let dic = ["text": txtChat.text,
                   "name": userName,
                   "postdate": ServerValue.timestamp()] as [String : Any]  //creating a dictionary and getting the child
        self.ref.child("chat").childByAutoId().setValue(dic)  //creating a node and setting the value to it in firebase
    }
    
    
    var listOfChatInfo = [Chat]()
    func loadChatRoom(){
        
        self.ref.child("chat").queryOrdered(byChild: "postdate").observe(.value, with: {
            (snapshot ) in
            
            self.listOfChatInfo.removeAll()
            
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot]{
                
                for snap in snapshot{
                    if let postData = snap.value as? [String:AnyObject]{
                        
                        let username = postData["name"] as? String
                        let text = postData["text"] as? String
                        
                        var postDate:CLong?
                        if let postDateIn = postData["postdate"] as? CLong{
                            postDate = postDateIn
                        }
                        self.listOfChatInfo.append(Chat(userName:username!, text:text!, date: "\(postDate!)"))
                    }
                }
                self.laChatList.reloadData()
                let indexpath = IndexPath(row:self.listOfChatInfo.count-1, section: 0)
                self.laChatList.scrollToRow(at: indexpath, at: .bottom, animated: true)
            }
        })
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfChatInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellChat:TVCChat = tableView.dequeueReusableCell(withIdentifier: "cellChat", for: indexPath) as! TVCChat
        cellChat.setChat(chat: listOfChatInfo[indexPath.row])
        return cellChat
    }
    
}

