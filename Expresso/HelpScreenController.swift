
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
        navigationController?.navigationBar.barTintColor = .systemColor("main")
        setupNavBar()
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 1.6) {
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
        button.titleLabel!.font =  UIFont(name: "Futura", size: 24)
        button.addTarget(self, action: #selector(handleHelpMe), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemColor("main")
        button.layer.cornerRadius = 25
        return button
    }()
    
    lazy var helpOthersButton: UIButton = {
        let button = UIButton()
        button.setTitle("Help Others", for: .normal)
        button.titleLabel!.font =  UIFont(name: "Futura", size: 24)
        button.addTarget(self, action: #selector(handleHelpOthers), for: .touchUpInside)
        button.backgroundColor = .systemColor("main")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 25
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
        logoimg.contentMode = .scaleAspectFit
        logoimg.alpha = 0
        logoimg.clipsToBounds = true
        return logoimg
    }()
    
    let emergencyLabel: UILabel = {
        let label = UILabel()
        label.text = "Call Suicide Hotline"
        label.font =  UIFont(name: "Futura", size: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 22)
        return label
    }()
    
    lazy var emergencyContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemColor("purple")
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleCall)))
        return view
    }()
    
    let busPhone:Double = 4049884543
    
    func handleCall(){
        if let url = NSURL(string: "tel://\(busPhone)") {
            //UIApplication.shared.openURL(url as URL)
            UIApplication.shared.canOpenURL(url as URL)
        }
    }
    
    let callHelpLabel: UILabel = {
        let label = UILabel()
        label.text = "Express yourself"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.textAlignment = .center
        label.font = UIFont.init(name: "Futura-Medium", size: 24)
        return label
    }()
    
    
    func handleHelpMe(){
        
        
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: { 
            
            
            
            }) { (Bool) in
    
                self.navigationController!.popViewController(animated: false)
                self.homeController.createChatRoom()
       
        }
    }
    
    func handleHelpOthers(){
        self.navigationController!.popViewController(animated: true)
    }
    
    
    func setupNavBar(){
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.title = "Expresso"
        navigationController!.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Futura", size: 20)!, NSForegroundColorAttributeName : UIColor.white]
        let backButton = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: navigationController, action: nil)
        navigationItem.leftBarButtonItem = backButton
    }
    
    func setupViews(){
        
        view.addSubview(imageViewBackground)
        imageViewBackground.addSubview(imageView)
        
        view.addSubview(buttonContainer)
        view.addSubview(helpOthersButton)
        view.addSubview(helpMeButton)
        view.addSubview(callHelpLabel)
        
        
        view.addSubview(emergencyContainer)
        emergencyContainer.addSubview(emergencyLabel)
        
        
        imageViewBackground.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        imageViewBackground.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        imageViewBackground.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        imageViewBackground.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        imageView.centerXAnchor.constraint(equalTo: imageViewBackground.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: imageViewBackground.centerYAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        

        
        helpOthersButton.bottomAnchor.constraint(equalTo: emergencyContainer.topAnchor, constant: -24).isActive = true
        helpOthersButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 6).isActive = true
        helpOthersButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -12).isActive = true
        helpOthersButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        helpMeButton.bottomAnchor.constraint(equalTo: helpOthersButton.topAnchor, constant: -6).isActive = true
        helpMeButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 6).isActive = true
        helpMeButton.widthAnchor.constraint(equalTo: helpOthersButton.widthAnchor).isActive = true
        helpMeButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        emergencyContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        emergencyContainer.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        emergencyContainer.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        emergencyContainer.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        
        callHelpLabel.topAnchor.constraint(equalTo: imageViewBackground.bottomAnchor, constant: 18).isActive = true
        callHelpLabel.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor).isActive = true
        callHelpLabel.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor).isActive = true
        callHelpLabel.bottomAnchor.constraint(equalTo: helpMeButton.topAnchor).isActive = true
        
        emergencyLabel.centerXAnchor.constraint(equalTo: emergencyContainer.centerXAnchor).isActive = true
        emergencyLabel.centerYAnchor.constraint(equalTo: emergencyContainer.centerYAnchor).isActive = true
        emergencyContainer.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        emergencyContainer.heightAnchor.constraint(equalTo: emergencyContainer.heightAnchor).isActive = true
        
        //ios9 constraints, x,y,width, height
        
        helpOthersButton.topAnchor.constraint(equalTo: helpMeButton.bottomAnchor, constant: 12).isActive = true
        helpOthersButton.leftAnchor.constraint(equalTo: buttonContainer.leftAnchor, constant: 6).isActive = true
        helpOthersButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -12).isActive = true
        helpOthersButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        
    }
    
}
