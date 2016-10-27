
//
//  ChatLogController.swift
//  Expresso
//
//  Created by Viraj Shah on 10/23/16.
//  Copyright © 2016 Expresso. All rights reserved.
//

import UIKit
import Firebase

class ChatLogController: UICollectionViewController, UITextFieldDelegate {
    
    var adminId: String?
    var uid: String?
    
    var roomId: String? {
        didSet {
            getRoomInfo()
            observeMessages()
        }
    }
    
    lazy var inputTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter message..."
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        return textField
    }()
    
    func getRoomInfo(){
        let chatroomRef = FIRDatabase.database().reference().child("chatrooms").child(roomId!)
        
        chatroomRef.observe(.value, with: { (snapshot) in
            
            guard let dictionary = snapshot.value as? [String: AnyObject] else {
                return
            }
            
            if let uid = dictionary["posterId"] as? String {
                self.adminId = uid
                print(uid)
            }
            
            
            }, withCancel: nil)
    }
    
    var messages = [Message]()
    
    func scrollToLastMessage(){
        
        if messages.count > 0 {
            let indexPath = IndexPath(row: messages.count - 1, section: 0)
            collectionView?.scrollToItem(at: indexPath, at: .bottom, animated: true)
        }

    }
    
    
    func observeMessages() {
        
        //observe user-messages from cell's uid (aka help request poster)
        let userMessagesRef = FIRDatabase.database().reference().child("user-messages").child(roomId!)

        userMessagesRef.observe(.childAdded, with: { (snapshot) in
            
            let messageId = snapshot.key
            let messagesRef = FIRDatabase.database().reference().child("messages").child(messageId)
            messagesRef.observeSingleEvent(of: .value, with: { (snapshot) in
                
                guard let dictionary = snapshot.value as? [String: AnyObject] else {
                    return
                }
                
                let message = Message()
                
                if let text = dictionary["text"] as? String!{
                    message.text = text
                }
                
                if let fromId = dictionary["fromId"] as? String!{
                    message.fromId = fromId
                }
                
                //uid for chatroom
                if let toId = dictionary["toId"] as? String!{
                    message.toId = toId
                }
                if let timestamp = dictionary["timestamp"] as! NSNumber?{
                    message.timestamp = timestamp
                }
                
                self.messages.append(message)
                
                DispatchQueue.main.async {
                    self.collectionView?.reloadData()
                }
                
                }, withCancel
                : nil)
            
            }, withCancel: nil)
    }
    
    let cellId = "cellId"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        setupCollectionView()
        setupInputComponents()
        getRoomInfo()

    }
    
    func setupNavBar(){
        navigationItem.title = "Chat Room"
        navigationController?.navigationBar.tintColor = .white
        let moreButton = UIBarButtonItem(image: UIImage(named: "menu")?.withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(menuTap))
        moreButton.tintColor = .white
        
        navigationItem.rightBarButtonItems =  [moreButton]
    }
    
    func setupCollectionView(){
        collectionView?.backgroundColor = .white
        collectionView?.alwaysBounceVertical = true
        collectionView?.register(ChatMessageCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 58, right: 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        
    }
    
    func menuTap(){
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ChatMessageCell
        
        let message = messages[indexPath.item]
        cell.textView.text = message.text
        
        setupCell(cell: cell, message: message)

        cell.bubbleWidthAnchor?.constant = estimateFrameForText(message.text!).width + 32

        return cell
    }
    
    private func setupCell(cell: ChatMessageCell, message: Message) {
            if message.fromId == FIRAuth.auth()?.currentUser?.uid {
            //outgoing blue
            cell.bubbleView.backgroundColor = .systemColor("main")
            cell.textView.textColor = .white
            cell.profileImageView.isHidden = true

            cell.bubbleViewRightAnchor?.isActive = true
            cell.bubbleViewLeftAnchor?.isActive = false
            
        } else {
            //incoming gray
            cell.bubbleView.backgroundColor = UIColor.init(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1)
            cell.textView.textColor = .black
                
                if message.fromId == adminId {
                    cell.profileImageView.backgroundColor = .red
                }else{
                    cell.profileImageView.backgroundColor = .purple
                }
            
            cell.profileImageView.isHidden = false
                
           cell.bubbleViewLeftAnchor?.isActive = true
            cell.bubbleViewRightAnchor?.isActive = false
        }
        
    }
    
    
    // distinguish admin by getting the message.toId = roomId
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView?.collectionViewLayout.invalidateLayout()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {

        var height: CGFloat = 80
        
        //get estimated height somehow????
        if let text = messages[indexPath.item].text {
            height = estimateFrameForText(text).height + 20
        }
        
        return CGSize(width: view.frame.width, height: height)

    }
    
    private func estimateFrameForText(_ text: String) -> CGRect {
        let size = CGSize(width: 200, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: text).boundingRect(with: size, options: options, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16)], context: nil)
    }
    
    func setupInputComponents(){
        let containerView = UIView()
        containerView.backgroundColor = .white

        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(containerView)
        
        //ios9 constraint anchors
        //x,y,w,h
        containerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        containerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        let sendButton = UIButton(type: .system)
        sendButton.setTitle("Send", for: .normal)
        sendButton.setTitleColor(.systemColor("main"), for: .normal)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        sendButton.addTarget(self, action: #selector(handleSend), for: .touchUpInside)
        containerView.addSubview(sendButton)
        //x,y,w,h
        sendButton.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        sendButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        sendButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        sendButton.heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
        
        containerView.addSubview(inputTextField)
        //x,y,w,h
        inputTextField.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 8).isActive = true
        inputTextField.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        inputTextField.rightAnchor.constraint(equalTo: sendButton.leftAnchor).isActive = true
        inputTextField.heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
        
        let separatorLineView = UIView()
        separatorLineView.backgroundColor = .lightGray
        separatorLineView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(separatorLineView)
        //x,y,w,h
        separatorLineView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        separatorLineView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        separatorLineView.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        separatorLineView.heightAnchor.constraint(equalToConstant: 1).isActive = true

    }
    
    func handleSend() {


        
        
        // Make database reference for messages
        let ref = FIRDatabase.database().reference().child("messages")
        // Child node is autoid
        let childRef = ref.childByAutoId()

        // sender
        let fromId = FIRAuth.auth()!.currentUser!.uid
        let currentTime:Int = Int(NSDate().timeIntervalSince1970)
        
        let values = ["text": inputTextField.text!, "toId": roomId!, "fromId": fromId, "timestamp": currentTime] as [String : Any]
        
        childRef.updateChildValues(values) { (error, ref) in
   
            
            self.inputTextField.text = nil
            
            let userMessagesRef = FIRDatabase.database().reference().child("user-messages").child(self.roomId!)
            
            let messageId = childRef.key
            userMessagesRef.updateChildValues([messageId: 1])
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        handleSend()
        scrollToLastMessage()
        return true
    }
}
