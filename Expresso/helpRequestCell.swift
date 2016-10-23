//
//  helpRequestCell.swift
//  Expresso
//
//  Created by Viraj Shah on 10/22/16.
//  Copyright © 2016 Expresso. All rights reserved.
//

//
//  AnnouncementCell.swift
//  hackGSU
//
//  Created by Viraj Shah on 9/27/16.
//  Copyright © 2016 Panther Hackers. All rights reserved.
//

import UIKit
import Firebase

class helpRequestCell: BaseCell {
    
    var uid: String?
    
    var helpRequest: helpRequest?{
        didSet{
            announcementTitle.text = helpRequest?.title
            topicLabel.text = helpRequest?.topic
            timestamp.text =  setupTime((helpRequest?.timestamp?.intValue)!)
            uid = helpRequest?.uid
        }
    }
    
    func setupTime(_ time: Int)->String {
        var currentTime = Int(NSDate().timeIntervalSince1970)
        
        let jodaConvert = time
        
        currentTime = (currentTime - jodaConvert )/60
        
        if (currentTime == 1){
            return (currentTime.description + " minute ago • ")
        }
        if (currentTime >= 60){
            currentTime = currentTime/60
            if (currentTime == 1){
                return (currentTime.description + " hour ago • ")
            }else{
                return (currentTime.description + " hours ago • ")
            }
        }
        return (currentTime.description + " minutes ago • ")
    }
    
    let announcementInfoContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let timestamp: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "14 minutes ago • "
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
        return label
    }()
    
    let announcementPoster: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "@admin "
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
        return label
    }()
    
    let announcementTitle: UITextView = {
        let tv = UITextView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = .white
        tv.textColor = .black
        tv.backgroundColor = .white
        tv.font = UIFont.boldSystemFont(ofSize: 16)
        tv.isEditable = false
        tv.isSelectable = false
        tv.isScrollEnabled = false
        return tv
    }()
    
    lazy var bottomButtonContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var commentButtonContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleButton)))
        return view
    }()
    let commentIcon: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "comment")
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Like", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.addTarget(self, action: #selector(handleButton), for: .touchUpInside)
        return button
    }()
    
    
    func handleButton(){
        
    }
    

    let buttonBottomSeparatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red:0.90, green:0.89, blue:0.90, alpha:1.00)
        return view
    }()
    
    let bottomSeparatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.lightGray
        return view
    }()
    
    let topicLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor(white: 0.8, alpha:1)
        label.text = "GENERAL"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 9)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        return label
    }()
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: self.frame.width, height: UIViewNoIntrinsicMetric)
    }
    
    override func setupViews(){
        addSubview(announcementInfoContainer)
        addSubview(announcementTitle)
        addSubview(buttonBottomSeparatorView)
        addSubview(bottomSeparatorView)
        addSubview(topicLabel)
        
        announcementInfoContainer.addSubview(timestamp)
        announcementInfoContainer.addSubview(announcementPoster)
        
        announcementInfoContainer.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        announcementInfoContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        announcementInfoContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        announcementInfoContainer.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        timestamp.leftAnchor.constraint(equalTo: announcementInfoContainer.leftAnchor, constant: 12).isActive = true
        timestamp.topAnchor.constraint(equalTo: announcementInfoContainer.topAnchor, constant:6).isActive = true
        timestamp.widthAnchor.constraint(equalToConstant: 100)
        timestamp.heightAnchor.constraint(equalToConstant: 30)
        
        announcementPoster.leftAnchor.constraint(equalTo: timestamp.rightAnchor).isActive = true
        announcementPoster.centerYAnchor.constraint(equalTo: timestamp.centerYAnchor).isActive = true
        announcementPoster.widthAnchor.constraint(equalToConstant: 150)
        announcementPoster.heightAnchor.constraint(equalToConstant: 30)
        
        announcementTitle.topAnchor.constraint(equalTo: announcementInfoContainer.bottomAnchor, constant: -12).isActive = true
        announcementTitle.leadingAnchor.constraint(equalTo: self.readableContentGuide.leadingAnchor).isActive = true
        announcementTitle.trailingAnchor.constraint(equalTo: self.readableContentGuide.trailingAnchor).isActive = true
        
        
        topicLabel.topAnchor.constraint(equalTo: announcementTitle.bottomAnchor, constant: -2).isActive = true
        topicLabel.leftAnchor.constraint(equalTo: announcementTitle.leftAnchor, constant: 6).isActive = true
        topicLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        topicLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        //Announcement Body Text Constraints
        
        bottomSeparatorView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        bottomSeparatorView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        bottomSeparatorView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        bottomSeparatorView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
    }
    
    
}
class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

