
//  HelpScreenController.swift
//  Expresso
//
//  Created by Viraj Shah on 10/21/16.
//  Copyright © 2016 Expresso. All rights reserved.
//
import UIKit
class HelpScreenController: UIViewController{
    
    
    var homeController = HomeController()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupNavBar()
        setupViews()
    }
    
    
    let buttonContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var helpMeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Help Me", for: .normal)
        button.titleLabel!.font =  UIFont(name: "STHeitiTC-Light", size: 20)
        button.addTarget(self, action: #selector(handleHelpMe), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .blue
        button.layer.cornerRadius = 25
        button.layer.borderColor = UIColor.blue.cgColor
        return button
    }()
    
    lazy var helpOthersButton: UIButton = {
        let button = UIButton()
        button.setTitle("Help Others", for: .normal)
        button.addTarget(self, action: #selector(handleHelpOthers), for: .touchUpInside)
        button.backgroundColor = .blue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 25
        button.layer.borderColor = UIColor.blue.cgColor
        
        return button
    }()
    
    let logoContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        return view
    }()
    
    let imageView: UIImageView = {
        let logoimg = UIImageView()
        logoimg.image = UIImage(named: "coffee")?.withRenderingMode(.alwaysTemplate)
        logoimg.translatesAutoresizingMaskIntoConstraints = false
        logoimg.contentMode = .scaleAspectFill
        logoimg.clipsToBounds = true
        return logoimg
    }()
    
    
    func handleHelpMe(){
        self.navigationController!.popViewController(animated: true)
        //vc.createChatRoom()
    }
    
    func handleHelpOthers(){
        self.navigationController!.popViewController(animated: true)
    }
    
    
    func setupNavBar(){
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.title = "How can we help?"
        navigationController!.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Helvetica", size: 18)!, NSForegroundColorAttributeName : UIColor.white]
        let backButton = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: navigationController, action: nil)
        navigationItem.leftBarButtonItem = backButton
    }
    
    func setupViews(){
        
        view.addSubview(imageView)
        view.addSubview(buttonContainer)
        buttonContainer.addSubview(helpMeButton)
        buttonContainer.addSubview(helpOthersButton)
        
        imageView.bottomAnchor.constraint(equalTo: helpMeButton.topAnchor, constant: -50).isActive = true
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 6).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        buttonContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        buttonContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        buttonContainer.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        buttonContainer.heightAnchor.constraint(equalToConstant: 196).isActive = true
        
        helpMeButton.topAnchor.constraint(equalTo: buttonContainer.topAnchor, constant: 12).isActive = true
        helpMeButton.leftAnchor.constraint(equalTo: buttonContainer.leftAnchor, constant: 6).isActive = true
        helpMeButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -12).isActive = true
        helpMeButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        //ios9 constraints, x,y,width, height
        
        helpOthersButton.topAnchor.constraint(equalTo: helpMeButton.bottomAnchor, constant: 12).isActive = true
        helpOthersButton.leftAnchor.constraint(equalTo: buttonContainer.leftAnchor, constant: 6).isActive = true
        helpOthersButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -12).isActive = true
        helpOthersButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        
    }
    
}
