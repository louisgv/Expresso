//
//  CreateChatRoomController.swift
//  Expresso
//
//  Created by Viraj Shah on 10/21/16.
//  Copyright © 2016 Expresso. All rights reserved.
//

import UIKit
import Firebase

class CreateChatRoomController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    let cellId = "cellId"
    let imageNames = ["sad", "crying", "mad"]
    var stressLevel:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavBar()
        setupViews()
        setupInputs()
        }
    
    func setupInputs(){
        hideKeyboardWhenTappedAround()
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        topicTextfield.inputView = menuPicker
        topicTextfield.inputAccessoryView = toolBar

    }
    
    let stressContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    let stressLabel: UILabel = {
        let label = UILabel()
        label.text = "How are you feeling?"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .lightGray
        label.textAlignment = .center
        return label
    }()
    
    let topicLabel: UILabel = {
        let label = UILabel()
        label.text = "What do you want to talk about?"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .lightGray
        label.textAlignment = .center
        return label
    }()
    
    let inputLabel: UILabel = {
        let label = UILabel()
        label.text = "What's on your mind?"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .lightGray
        label.textAlignment = .center
        return label
    }()

    let inputsContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    let topicTextfield: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.layer.borderWidth = 1
        tf.backgroundColor = .systemColor("main")
        tf.layer.borderColor = UIColor.white.cgColor
        tf.font = UIFont.systemFont(ofSize: 20)
        tf.textColor = .white
        tf.textAlignment = .center
        tf.layer.cornerRadius = 20
        return tf
    }()
    
    let inputTextView: UITextView = {
        let tv = UITextView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.layer.borderWidth = 0.5
        tv.layer.borderColor = UIColor.gray.cgColor
        tv.isEditable = true
        tv.font = UIFont.systemFont(ofSize: 18)
        return tv
    }()
    
    lazy var oneHelp: UIButton = {
        let button = UIButton()
        button.setTitle("1 On 1 Help", for: .normal)
        button.addTarget(self, action: #selector(handleButtonOne), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemColor("main")
        button.layer.cornerRadius = 25
        button.layer.borderColor = UIColor.blue.cgColor
        return button
    }()
    func handleButtonOne() {
    print(123)
    }
    
    
    lazy var submitButton: UIButton = {
        let button = UIButton()
        button.setTitle("Submit Request", for: .normal)
        button.addTarget(self, action: #selector(handleButtonTap), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemColor("main")
        button.layer.cornerRadius = 25
        button.setTitleColor(.blue, for: .normal)
        button.layer.borderColor = UIColor.blue.cgColor
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    
    func handleButtonTap() {
        
        if checkInputValues(){
            
            
            let uid = FIRAuth.auth()?.currentUser?.uid
            
            let ref = FIRDatabase.database().reference().child("help_requests")
            let childRef = ref.child(uid!)
            
            let currentTime:Int = Int(NSDate().timeIntervalSince1970)
            
            
            submitButton.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
            UIView.animate(withDuration: 2.0,
                           delay: 0,
                           usingSpringWithDamping: 0.9,
                           initialSpringVelocity: 0.5,
                           options: UIViewAnimationOptions.allowUserInteraction,
                           animations: {
                            self.submitButton.transform = CGAffineTransform.identity
                }, completion:  {
                    (value: Bool) in
                    
                    
                        let values = ["title": self.inputTextView.text, "stressLevel": self.stressLevel, "timestamp" : currentTime, "topic": self.topicTextfield.text!] as [String : Any]
                        
                        childRef.updateChildValues(values)
                    
            })
            
            
            self.navigationController!.popViewController(animated: true)

        }
        
        
    }
    
    
    func checkInputValues() -> Bool{
        if (topicTextfield.text?.isEmpty)! || (inputTextView.text?.isEmpty)! || (stressLevel.isEmpty) {
            return false
        }
        
        return true
    }
    
    let groupContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    lazy var menuPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.backgroundColor = UIColor.white
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.delegate = self
        picker.dataSource = self
        picker.showsSelectionIndicator = true
        return picker
    }()
    
    let topicPickerData = ["Need Motivation", "Relationships", "Life Sucks (FML)", "Feeling Depressed", "Embarrased", "Hurting", "Mourning a Loss", "No H8", "Cheated On", "Drunk Text Us Instead", "Atlanta Traffic", "Physically Abused", "Emotionally Abused", "Financial Problems", "Contemplating Suicide", "Other"]
    
    lazy var doneButton: UIBarButtonItem = {
        var btn = UIBarButtonItem()
        btn = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(donePicker))
        
        return btn
    }()
    
    let spaceButton: UIBarButtonItem = {
        var btn = UIBarButtonItem()
        btn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        
        return btn
    }()
    
    lazy var cancelButton: UIBarButtonItem = {
        var btn = UIBarButtonItem()
        btn = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(donePicker))
        return btn
    }()
    
    func donePicker(){
        topicTextfield.resignFirstResponder()
    }
    
    lazy var toolBar: UIToolbar = {
        let tb = UIToolbar()
        tb.barStyle = UIBarStyle.default
        tb.isTranslucent = true
        tb.tintColor = UIColor.gray
        tb.sizeToFit()
        tb.translatesAutoresizingMaskIntoConstraints = false
        
        return tb
    }()
    
    func numberOfComponents(in colorPicker: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return topicPickerData.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return topicPickerData[row]
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        topicTextfield.text = topicPickerData[row]
    }
    
    func setupNavBar(){
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.title = "Request help"
        navigationController!.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Avenir", size: 18)!, NSForegroundColorAttributeName : UIColor.white]
        navigationController?.navigationBar.tintColor = .white
    }
    
    let stressButtonContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    lazy var sadButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "sad")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .systemColor("purple")
        button.addTarget(self, action: #selector(handleSadButtonTap), for: .touchUpInside)
        return button
    }()
    
    func handleSadButtonTap(){
        
        stressLevel = "SAD"
        sadButton.tintColor = .systemColor("mild")
        cryingButton.tintColor = .lightGray
        upsetButton.tintColor = .lightGray
        changeColors("mild")
    }
    
    func handleCryingButtonTap(){
        
        stressLevel = "UPSET"
        sadButton.tintColor = .lightGray
        cryingButton.tintColor = .systemColor("sad")
        upsetButton.tintColor = .lightGray
        changeColors("sad")
        
    }
    
    func handleUpsetButtonTap(){
        stressLevel = "ENRAGED"
        sadButton.tintColor = .lightGray
        cryingButton.tintColor = .lightGray
        upsetButton.tintColor = .systemColor("angry")
        changeColors("angry")

    }

    lazy var cryingButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "crying")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .systemColor("purple")
        button.addTarget(self, action: #selector(handleCryingButtonTap), for: .touchUpInside)
        return button
    }()

    lazy var upsetButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "mad")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .systemColor("purple")
        button.addTarget(self, action: #selector(handleUpsetButtonTap), for: .touchUpInside)
        return button
    }()
    
    func changeColors(_ color: String){
        switch(color){
        case "sad":
            
            UIView.animate(withDuration: 0.3, animations: {
                self.navigationController?.navigationBar.barTintColor = .systemColor("sad")
                self.topicTextfield.backgroundColor = .systemColor("sad")
                self.submitButton.backgroundColor = .systemColor("sad")
            })
            
            
        case "mild":
            
            UIView.animate(withDuration: 0.3, animations: {
                self.navigationController?.navigationBar.barTintColor = .systemColor("mild")
                self.topicTextfield.backgroundColor = .systemColor("mild")
                self.submitButton.backgroundColor = .systemColor("mild")

            })
            
        case "angry":
            
            UIView.animate(withDuration: 0.3, animations: {
                self.navigationController?.navigationBar.barTintColor = .systemColor("angry")
                self.topicTextfield.backgroundColor = .systemColor("angry")
                self.submitButton.backgroundColor = .systemColor("angry")

            })
        default:
            return
        }
        
        
    }
    
//    let inputSeparator: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.backgroundColor = .lightGray
//        return view
//    }()

//    let textSeparator: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.backgroundColor = .lightGray
//        return view
//    }()
    
    let downIndicator: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "down")?.withRenderingMode(.alwaysTemplate)
        iv.tintColor = .white
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    func setupViews() {
        
        view.addSubview(stressLabel)
        view.addSubview(stressButtonContainer)
        
        stressButtonContainer.addSubview(sadButton)
        stressButtonContainer.addSubview(cryingButton)
        stressButtonContainer.addSubview(upsetButton)

        view.addSubview(topicLabel)
        view.addSubview(inputsContainer)
//        view.addSubview(inputSeparator)
        view.addSubview(inputLabel)
//        view.addSubview(textSeparator)
        view.addSubview(inputTextView)
        
        inputsContainer.addSubview(topicTextfield)
        topicTextfield.addSubview(downIndicator)
        
        view.addSubview(groupContainer)

        groupContainer.addSubview(submitButton)
        
        stressLabel.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        stressLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        stressLabel.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        stressLabel.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        stressButtonContainer.topAnchor.constraint(equalTo: stressLabel.bottomAnchor).isActive = true
        stressButtonContainer.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        stressButtonContainer.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        stressButtonContainer.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        sadButton.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        sadButton.centerYAnchor.constraint(equalTo: stressButtonContainer.centerYAnchor).isActive = true
        sadButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3).isActive = true
        sadButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
        
        cryingButton.leftAnchor.constraint(equalTo: sadButton.rightAnchor).isActive = true
        cryingButton.centerYAnchor.constraint(equalTo: sadButton.centerYAnchor).isActive = true
        cryingButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3).isActive = true
        cryingButton.heightAnchor.constraint(equalTo: sadButton.heightAnchor).isActive = true
        
        upsetButton.leftAnchor.constraint(equalTo: cryingButton.rightAnchor).isActive = true
        upsetButton.centerYAnchor.constraint(equalTo: stressButtonContainer.centerYAnchor).isActive = true
        upsetButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3).isActive = true
        upsetButton.heightAnchor.constraint(equalTo: sadButton.heightAnchor).isActive = true

        topicLabel.topAnchor.constraint(equalTo: stressButtonContainer.bottomAnchor).isActive = true
        topicLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        topicLabel.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        topicLabel.heightAnchor.constraint(equalToConstant: 44).isActive = true

        
//        inputSeparator.topAnchor.constraint(equalTo: topicLabel.bottomAnchor).isActive = true
//        inputSeparator.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
//        inputSeparator.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
//        inputSeparator.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
        
        inputsContainer.topAnchor.constraint(equalTo: topicLabel.bottomAnchor).isActive = true
        inputsContainer.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        inputsContainer.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        inputsContainer.heightAnchor.constraint(equalToConstant: 52).isActive = true

        topicTextfield.topAnchor.constraint(equalTo: inputsContainer.topAnchor, constant: 6).isActive = true
        topicTextfield.leftAnchor.constraint(equalTo: inputsContainer.leftAnchor, constant: 6).isActive = true
        topicTextfield.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -12).isActive = true
        topicTextfield.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        
        downIndicator.rightAnchor.constraint(equalTo: topicTextfield.rightAnchor, constant: -10).isActive = true
        downIndicator.centerYAnchor.constraint(equalTo: topicTextfield.centerYAnchor).isActive = true
        downIndicator.widthAnchor.constraint(equalToConstant: 28).isActive = true
        downIndicator.heightAnchor.constraint(equalToConstant: 28).isActive = true
        
        inputLabel.topAnchor.constraint(equalTo: inputsContainer.bottomAnchor).isActive = true
        inputLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        inputLabel.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        inputLabel.heightAnchor.constraint(equalToConstant: 44).isActive = true

//        textSeparator.topAnchor.constraint(equalTo: inputLabel.bottomAnchor).isActive = true
//        textSeparator.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
//        textSeparator.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
//        textSeparator.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
        
        inputTextView.topAnchor.constraint(equalTo: inputLabel.bottomAnchor, constant: 6).isActive = true
        inputTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 6).isActive = true
        inputTextView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -12).isActive = true
        inputTextView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        
        groupContainer.topAnchor.constraint(equalTo: inputTextView.bottomAnchor, constant:6).isActive = true
        groupContainer.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        groupContainer.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        groupContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        submitButton.topAnchor.constraint(equalTo: groupContainer.topAnchor).isActive = true
        submitButton.leftAnchor.constraint(equalTo: groupContainer.leftAnchor, constant: 6).isActive = true
        submitButton.widthAnchor.constraint(equalTo: groupContainer.widthAnchor, constant: -12).isActive = true
        submitButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
    }
}
