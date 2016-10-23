//
//  ViewController.swift
//  Expresso
//
//  Created by Viraj Shah on 10/21/16.
//  Copyright © 2016 Expresso. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        checkUser()
        view.backgroundColor = .white
    }
    
    
    lazy var helpScreen: HelpScreenController = {
        let controller = HelpScreenController()
        controller.vc = self
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
        navigationController?.navigationBar.barTintColor = .systemColor("main")
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        let plusButton = UIBarButtonItem(image: UIImage(named: "add"), style: .plain, target: self, action: #selector(createChatRoom))
        plusButton.tintColor = .white
        navigationItem.rightBarButtonItems = [plusButton]
    }
    
}

