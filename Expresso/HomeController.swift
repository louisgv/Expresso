//
//  HomeController.swift
//  Expresso
//
//  Created by Viraj Shah on 10/22/16.
//  Copyright © 2016 Expresso. All rights reserved.
//

//
//  AnnouncementController.swift
//  hackGSU
//
//  Created by Viraj Shah on 9/24/16.
//  Copyright © 2016 Panther Hackers. All rights reserved.
//

import UIKit
import FirebaseAuth

class HomeFeedController: UICollectionViewController, UICollectionViewDelegateFlowLayout{
    
    let cellId = "cellId"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        checkUser()
        view.backgroundColor = .white
    }
    override func viewDidAppear(_ animated: Bool) {
        //collectionView?.reloadData()
    }
    
    lazy var helpScreen: HelpScreenController = {
        let controller = HelpScreenController()
        return controller
    }()
    
    func checkUser(){
        if FIRAuth.auth()?.currentUser?.uid == nil {
            FIRAuth.auth()?.signInAnonymously(){ (user, error) in
            }
        }
        navigationController?.pushViewController(helpScreen, animated: true)
        
    }
    func setupNavBar(){
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = " Help Out"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor(red:0.14, green:0.32, blue:0.95, alpha:1.00)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        let plusButton = UIBarButtonItem(image: UIImage(named: "add"), style: .plain, target: self, action: #selector(createChatRoom))
        plusButton.tintColor = .white
        navigationItem.rightBarButtonItems = [plusButton]
        
    }
    
    
    let createChatController = CreateChatRoomController()
    
    func createChatRoom(){
        navigationController?.pushViewController(createChatController, animated: true)
    }
    
    func setupCollectionView(){
        
        if let flowlayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowlayout.scrollDirection = .horizontal
            flowlayout.minimumLineSpacing = 0
        }
        
        collectionView?.backgroundColor = UIColor(red:0.90, green:0.89, blue:0.90, alpha:1.00)
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        
        collectionView?.indicatorStyle = .black
        collectionView?.isPagingEnabled = true
        collectionView?.contentInset = UIEdgeInsetsMake(20, 0, 0, 0)
        collectionView?.scrollIndicatorInsets  = UIEdgeInsetsMake(20, 0, 0, 0)
        collectionView?.showsHorizontalScrollIndicator = false
        
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        
            cell.backgroundColor = .red
            return cell
    }
}
