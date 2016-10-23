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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupViews()
        setupCollectionViews()
        checkUser()
        observeHelpRequests()
        view.backgroundColor = .white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.barTintColor = .systemColor("main")
        refreshFeed()
    }
    
    func refreshFeed(){
        requests.removeAll()
        observeHelpRequests()
    }
    
    func observeHelpRequests(){
        let ref = FIRDatabase.database().reference().child("help_requests")
        ref.observe(.childAdded, with: { (snapshot) in
            
            
            if let dictionary = snapshot.value as? [String: Any]{
                
                
                print(snapshot)
                
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
        
        let knownHeight: CGFloat = 35 + 40 + 28
        
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
        navigationController?.pushViewController(helpScreen, animated: true)

    }
    
    let createChatController = CreateChatRoomController()
    
    func createChatRoom(){
        navigationController?.pushViewController(createChatController, animated: true)
    }
    
    func setupNavBar(){
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = " Help Out"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        let plusButton = UIBarButtonItem(image: UIImage(named: "add"), style: .plain, target: self, action: #selector(createChatRoom))
        plusButton.tintColor = .white
        navigationItem.rightBarButtonItems = [plusButton]
    }
    
    func setupViews(){
        view.addSubview(placeholderContainer)
        view.addSubview(collectionView)
        
        placeholderContainer.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        placeholderContainer.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        placeholderContainer.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        placeholderContainer.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        collectionView.topAnchor.constraint(equalTo: placeholderContainer.bottomAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: view.frame.height - 40).isActive = true
        
    }
    
}

