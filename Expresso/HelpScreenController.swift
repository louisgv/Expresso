
//  HelpScreenController.swift
//  Expresso
//
//  Created by Viraj Shah on 10/21/16.
//  Copyright © 2016 Expresso. All rights reserved.
//
import UIKit
class HelpScreenController: UIViewController{
    
    
    var vc = ViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupNavBar()
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.8) {
            self.imageView.alpha = 1
        }
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
        button.backgroundColor = .systemColor("main")
        button.layer.cornerRadius = 25
        button.layer.borderColor = UIColor.blue.cgColor
        return button
    }()
    
    lazy var helpOthersButton: UIButton = {
        let button = UIButton()
        button.setTitle("Help Others", for: .normal)
        button.addTarget(self, action: #selector(handleHelpOthers), for: .touchUpInside)
        button.backgroundColor = .systemColor("main")
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
    
    let imageViewBackground: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemColor("main")
        return view
    }()
    
    let imageView: UIImageView = {
        let logoimg = UIImageView()
        logoimg.image = UIImage(named: "logo")?.withRenderingMode(.alwaysOriginal)
        logoimg.translatesAutoresizingMaskIntoConstraints = false
        logoimg.contentMode = .scaleAspectFill
        logoimg.alpha = 0
        logoimg.clipsToBounds = true
        return logoimg
    }()
    
    
    func handleHelpMe(){
        self.navigationController!.popViewController(animated: true)
        vc.createChatRoom()
    }
    
    func handleHelpOthers(){
        self.navigationController!.popViewController(animated: true)
    }
    
    
    func setupNavBar(){
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.title = "Expresso"
        navigationController!.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Helvetica", size: 18)!, NSForegroundColorAttributeName : UIColor.white]
        let backButton = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: navigationController, action: nil)
        navigationItem.leftBarButtonItem = backButton
    }
    
    func setupViews(){
        
        view.addSubview(imageViewBackground)
        imageViewBackground.addSubview(imageView)
        
        view.addSubview(buttonContainer)
        buttonContainer.addSubview(helpMeButton)
        buttonContainer.addSubview(helpOthersButton)
        
//        imageViewBackground.bottomAnchor.constraint(equalTo: helpMeButton.topAnchor, constant: -50).isActive = true
//        imageViewBackground.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        imageViewBackground.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
//        imageViewBackground.heightAnchor.constraint(equalTo: helpMeButton.heightAnchor).isActive = true
        
        imageViewBackground.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        imageViewBackground.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        imageViewBackground.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        imageViewBackground.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        imageView.centerXAnchor.constraint(equalTo: imageViewBackground.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: imageViewBackground.centerYAnchor).isActive = true
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
