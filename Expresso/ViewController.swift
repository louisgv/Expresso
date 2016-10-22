//
//  ViewController.swift
//  Expresso
//
//  Created by Viraj Shah on 10/21/16.
//  Copyright © 2016 Expresso. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupViews()
        checkUser()
        view.backgroundColor = .white
    }
    
    lazy var menuBar: MenuBar = {
    let mb = MenuBar()
    mb.translatesAutoresizingMaskIntoConstraints = false
    return mb
    }()
    
    
    lazy var helpScreen: HelpScreenController = {
        let controller = HelpScreenController()
        controller.vc = self
        return controller
    }()
    
    func checkUser(){
        
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
        navigationController?.navigationBar.barTintColor = UIColor(red:0.14, green:0.32, blue:0.95, alpha:1.00)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        let plusButton = UIBarButtonItem(image: UIImage(named: "add"), style: .plain, target: self, action: #selector(createChatRoom))
        plusButton.tintColor = .white
        navigationItem.rightBarButtonItems = [plusButton]
    }
    
    func setupViews(){
        view.addSubview(menuBar)
        
        menuBar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        menuBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        menuBar.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        menuBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

}

