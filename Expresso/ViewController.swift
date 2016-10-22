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
        checkUser()
        view.backgroundColor = .white
    }
    
    
    let helpScreen = HelpScreenController()
    
    func checkUser(){
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
        
        let plusButton = UIBarButtonItem(image: UIImage(named: "add"), style: .plain, target: self, action: #selector(addAnnouncement))
        plusButton.tintColor = .white
        navigationItem.rightBarButtonItems = [plusButton]
    }
    func addAnnouncement(){
        print(123)
    }

}

