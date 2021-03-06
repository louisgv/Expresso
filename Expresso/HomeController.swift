//
//  ViewController.swift
//  Expresso
//
//  Created by Viraj Shah on 10/21/16.
//  Copyright © 2016 Expresso. All rights reserved.
//

import UIKit
import Firebase

class HomeController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    let cellId = "cellId"
    var requests = [helpRequest]()
    
    
    var ref: FIRDatabaseReference!
    var handle: UInt!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupNavBar()
        setupViews()
        setupCollectionViews()
        checkUser()
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barTintColor = .systemColor("main")
        refreshFeed()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        ref = FIRDatabase.database().reference().child("help_requests")
        ref.removeObserver(withHandle: handle)
    }
    
    
    func refreshFeed(){
        requests.removeAll()
        observeHelpRequests()
    }
    
    func observeHelpRequests(){
        let ref = FIRDatabase.database().reference().child("help_requests")
        handle = ref.observe(.childAdded, with: { (snapshot) in
            
            
            if let dictionary = snapshot.value as? [String: Any]{
                
                let request = helpRequest()
                
                if let title = dictionary["title"] as? String!{
                    request.title = title
                }

                if let timestamp = dictionary["timestamp"] as! NSNumber?{
                    request.timestamp = timestamp
                }
                if let topic = dictionary["topic"] as? String!{
                    request.topic = topic
                }
                if let stressLevel = dictionary["stressLevel"] as! String!{
                    request.stressLevel = stressLevel
                }
                if let roomId = dictionary["roomId"] as! String!{
                    request.roomId = roomId
                }
                request.uid = snapshot.key

                self.requests.append(request)
                
                self.requests.sort(by: { (message1, message2) -> Bool in
                    
                    return (message1.timestamp?.intValue)! > (message2.timestamp?.intValue)!
                })
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                
                
            }
            }, withCancel: nil)
    }
    
    
    let placeholderContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemColor("main")
        return view
    }()
    
    let filterLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "  Filter By: All"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        var cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! helpRequestCell
        
        cell.helpRequest = requests[indexPath.item]
        cell.backgroundColor = .white
        cell.homeController = self
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return requests.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    

    func setupCollectionViews(){
        collectionView.register(helpRequestCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.backgroundColor = UIColor(white: 0.9, alpha: 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let knownHeight: CGFloat = 35 + 40 + 38
        
        if let requestTitle = requests[indexPath.item].title {
            
            let rect = NSString(string: requestTitle).boundingRect(with: CGSize(width: view.frame.width, height: 1000), options: NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin), attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 16)], context: nil)
            
            
            return CGSize(width: view.frame.width, height: rect.height + knownHeight )
        }
        
        return CGSize(width: view.frame.width, height: 100)
    }

    lazy var helpScreen: HelpScreenController = {
        let controller = HelpScreenController()
        controller.homeController = self
        return controller
    }()
    
    func checkUser(){
        if FIRAuth.auth()?.currentUser?.uid == nil {
            FIRAuth.auth()?.signInAnonymously(){ (user, error) in
            }
        }
        navigationController?.pushViewController(helpScreen, animated: false)

    }
    
    lazy var createChatController: CreateChatRoomController = {
        let controller = CreateChatRoomController()
        
        controller.homeController = self
        return controller
    }()
        //= CreateChatRoomController()
    
    func createChatRoom(){
        navigationController?.pushViewController(createChatController, animated: true)
    }
    
    func setupNavBar(){
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = " Expresso"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
        
        titleLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(logout)))
        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        let plusButton = UIBarButtonItem(image: UIImage(named: "add"), style: .plain, target: self, action: #selector(createChatRoom))
        plusButton.tintColor = .white
        
        let moreButton = UIBarButtonItem(image: UIImage(named: "menu")?.withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(logout))
        moreButton.tintColor = .white

        
        navigationItem.rightBarButtonItems =  [moreButton, plusButton]
    }
    
    func logout(){
        navigationController?.pushViewController(helpScreen, animated: false)
    }
    
    
    func launchChatRoom(_ roomId: String){
        let chatController = ChatLogController(collectionViewLayout: UICollectionViewFlowLayout())
        chatController.roomId = roomId
        navigationController?.pushViewController(chatController, animated: true)
        
    }
    
    func setupViews(){
        view.addSubview(placeholderContainer)
        placeholderContainer.addSubview(filterLabel)
        view.addSubview(collectionView)
        
        placeholderContainer.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        placeholderContainer.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        placeholderContainer.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        placeholderContainer.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        filterLabel.leftAnchor.constraint(equalTo: placeholderContainer.leftAnchor, constant: 6).isActive = true
        filterLabel.centerYAnchor.constraint(equalTo: placeholderContainer.centerYAnchor).isActive = true
        filterLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
        filterLabel.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        
        
        collectionView.topAnchor.constraint(equalTo: placeholderContainer.bottomAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: view.frame.height - 105).isActive = true
        
    }
    
}

