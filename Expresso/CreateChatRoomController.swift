//
//  CreateChatRoomController.swift
//  Expresso
//
//  Created by Viraj Shah on 10/21/16.
//  Copyright © 2016 Expresso. All rights reserved.
//

import UIKit

class CreateChatRoomController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavBar()
        setupViews()
        
        hideKeyboardWhenTappedAround()
        
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        topicTextfield.inputView = menuPicker
        topicTextfield.inputAccessoryView = toolBar
        
        inputTextfield.inputAccessoryView = toolBar

        
    }
    
    let stressContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .blue
        return view
    }()
   
    let inputsContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let inputTextfield: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor.lightGray.cgColor
        tf.placeholder = "What's on your mind?"
        tf.font = UIFont.systemFont(ofSize: 22)
        tf.backgroundColor = .white
        tf.textAlignment = .center
        return tf
    }()
    
    let topicLabel: UILabel = {
        let label = UILabel()
        label.text = "Topic:"
        label.font = UIFont.systemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        return label
    }()
    
    lazy var oneHelp: UIButton = {
        let button = UIButton()
        button.setTitle("1 On 1 Help", for: .normal)
        button.addTarget(self, action: #selector(handleButtonOne), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemColor("blue")
        button.layer.cornerRadius = 25
        button.layer.borderColor = UIColor.blue.cgColor
        return button
    }()
    func handleButtonOne() {
    print(123)
    }
    
    
    lazy var groupHelp: UIButton = {
        let button = UIButton()
        button.setTitle("Group Help", for: .normal)
        button.addTarget(self, action: #selector(handleButtonTwo), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemColor("blue")
        button.layer.cornerRadius = 25
        button.layer.borderColor = UIColor.blue.cgColor
        return button
    }()
    func handleButtonTwo() {
        print(1234)
        
    }
    
    lazy var topicTextfield: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor.lightGray.cgColor
        tf.font = UIFont.systemFont(ofSize: 22)
        tf.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTopic)))
        tf.backgroundColor = .white
        tf.textAlignment = .center
        return tf
    }()
    
    func handleTopic(){
        print(123)
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
    
    let topicPickerData = ["Suicidal", "High Stress", "Relationships"]
    
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
        inputTextfield.resignFirstResponder()
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
    
    func setupViews() {
        view.addSubview(stressContainer)
        view.addSubview(inputsContainer)
        view.addSubview(groupContainer)
        
        
        inputsContainer.addSubview(inputTextfield)
        inputsContainer.addSubview(topicLabel)
        inputsContainer.addSubview(topicTextfield)
        groupContainer.addSubview(oneHelp)
        groupContainer.addSubview(groupHelp)
        
        stressContainer.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        stressContainer.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        stressContainer.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        stressContainer.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/3).isActive = true
        
        inputsContainer.topAnchor.constraint(equalTo: stressContainer.bottomAnchor).isActive = true
        inputsContainer.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        inputsContainer.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        inputsContainer.heightAnchor.constraint(equalToConstant: 110).isActive = true
        
        groupContainer.topAnchor.constraint(equalTo: inputsContainer.bottomAnchor).isActive = true
        groupContainer.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        groupContainer.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        groupContainer.heightAnchor.constraint(equalToConstant: 130).isActive = true
        
        
        inputTextfield.topAnchor.constraint(equalTo: inputsContainer.topAnchor, constant: 12).isActive = true
        inputTextfield.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 6).isActive = true
        inputTextfield.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -12).isActive = true
        inputTextfield.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        topicLabel.topAnchor.constraint(equalTo: inputTextfield.bottomAnchor, constant: 6).isActive = true
        topicLabel.leftAnchor.constraint(equalTo: inputsContainer.leftAnchor, constant: 6).isActive = true
        topicLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/2, constant: -12).isActive = true
        topicLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        topicTextfield.topAnchor.constraint(equalTo: inputTextfield.bottomAnchor, constant: 6).isActive = true
        topicTextfield.leftAnchor.constraint(equalTo: topicLabel.rightAnchor, constant: 6).isActive = true
        topicTextfield.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/2, constant: -6).isActive = true
        topicTextfield.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        oneHelp.topAnchor.constraint(equalTo: groupContainer.topAnchor, constant: 12).isActive = true
        oneHelp.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 6).isActive = true
        oneHelp.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -12).isActive = true
        oneHelp.heightAnchor.constraint(equalToConstant: 60).isActive = true
    
        groupHelp.topAnchor.constraint(equalTo: oneHelp.bottomAnchor, constant: 6).isActive = true
        groupHelp.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 6).isActive = true
        groupHelp.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -12).isActive = true
        groupHelp.heightAnchor.constraint(equalToConstant: 60).isActive = true

    }
}
