//
//  ChatViewController.swift
//  Expresso
//
//  Created by Viraj Shah on 10/23/16.
//  Copyright © 2016 Expresso. All rights reserved.
//

import Firebase
import JSQMessagesViewController

class ChatViewController : JSQMessagesViewController{
    var messages = [JSQMessage]()
    var outgoingBubbleImageView: JSQMessagesBubbleImage!
    var incomingBubbleImageView: JSQMessagesBubbleImage!
    var uid: String?
    
    private func setupBubbles() {
        let factory = JSQMessagesBubbleImageFactory()
        outgoingBubbleImageView = factory?.outgoingMessagesBubbleImage(
            with: UIColor.jsq_messageBubbleBlue())
        incomingBubbleImageView = factory?.incomingMessagesBubbleImage(
            with: UIColor.jsq_messageBubbleLightGray())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupBubbles()
        
        collectionView!.collectionViewLayout.incomingAvatarViewSize = CGSize.zero
        collectionView!.collectionViewLayout.outgoingAvatarViewSize = CGSize.zero
        
        // messages sent from local sender
        // animates the receiving of a new message on the view
        finishReceivingMessage()

    }
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!,
                                     senderDisplayName: String!, date: Date!) {
        
        let ref = FIRDatabase.database().reference().child("messages")
        let childRef = ref.childByAutoId()
        
        let messageItem = [ // 2
            "text": text,
            "senderId": senderId
        ]
        childRef.setValue(messageItem) // 3
        
        // 4
        JSQSystemSoundPlayer.jsq_playMessageSentSound()
        
        // 5
        finishSendingMessage()
    }
    
    private func observeMessages() {
        // 1
        let messagesQuery = FIRDatabase.database().reference().child("messages").queryLimited(toLast: 25)
        
        messagesQuery.observe(.childAdded, with: { (snapshot) in
            
            
            if let dictionary = snapshot.value as? [String: Any]{
                
                var senderIds: String?
                var texts: String?
                
                if let sender = dictionary["senderId"] as? String!{
                    senderIds = sender
                }
                
                if let textmessage = dictionary["stressLevel"] as! String!{
                    texts = textmessage
                }
                
                self.addMessage(senderIds!, text: texts!)
                self.finishReceivingMessage()

                
            }
            }, withCancel: nil)

        }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        observeMessages()
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath) as! JSQMessagesCollectionViewCell
        
        let message = messages[indexPath.item]
        
        if message.senderId == senderId {
            cell.textView!.textColor = .white
        } else {
            cell.textView!.textColor = .black
        }
        
        return cell
    }
    
    func addMessage(_ id: String, text: String) {
        let message = JSQMessage(senderId: id, displayName: "", text: text)
        messages.append(message!)
    }

    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        let message = messages[indexPath.item]
        if message.senderId == senderId {
            return outgoingBubbleImageView
        }else{
            return incomingBubbleImageView
        }
        
    }
    
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        return nil
    }
    
    func setupNavBar(){
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.title = "Chat Room"
        navigationController!.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Avenir", size: 18)!, NSForegroundColorAttributeName : UIColor.white]
        navigationController?.navigationBar.tintColor = .white
    
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        return messages[indexPath.item]
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    
}
