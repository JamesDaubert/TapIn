//
//  BarSignUpViewController.swift
//  TapIn
//
//  Created by James Daubert on 8/1/17.
//  Copyright © 2017 James Daubert. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class BarSignUpViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(tapInTitle)
        view.addSubview(userText)
        view.addSubview(userButton)
        view.addSubview(barNameText)
        view.addSubview(barAddressText)
        view.addSubview(barCityText)
        view.addSubview(barZipText)
        view.addSubview(barStateText)
        view.addSubview(emailText)
        view.addSubview(passText)
        view.addSubview(signUpButton)
        view.addSubview(loginText)
        view.addSubview(loginButton)
        
        
        
        setupTapInTitle()
        setupUserText()
        setupUserButton()
        setUpBarText()
        setUpBarAddressText()
        setUpBarCityText()
        setUpBarZipText()
        setUpBarStateText()
        setUpEmailText()
        setUpPassText()
        setupSignUpButton()
        setupLoginText()
        setuploginButton()

        
    }
    
    let tapInTitle: UILabel = {
        let t = UILabel()
        t.translatesAutoresizingMaskIntoConstraints = false
        
        t.font = UIFont.boldSystemFont(ofSize: 48)
        t.text = "Tap In"
        t.textColor = UIColor.cyan
        return t
    }()
    
    func setupTapInTitle() {
        tapInTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tapInTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        
    }
    
    let userText: UILabel = {
        let t = UILabel()
        t.translatesAutoresizingMaskIntoConstraints = false
        t.text = "Looking for Customer Login?"
        t.font = UIFont.preferredFont(forTextStyle: .footnote)
        
        return t
    }()
    
    func setupUserText() {
        userText.rightAnchor.constraint(equalTo: view.centerXAnchor, constant: 2.5).isActive = true
        userText.topAnchor.constraint(equalTo: tapInTitle.bottomAnchor, constant: 20).isActive = true
    }
    
    let userButton: UIButton = {
        let b = UIButton(type: .system)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.backgroundColor = .white
        b.setTitle("It's over here.", for: .normal)
        b.setTitleColor(.blue, for: .normal)
        b.titleLabel!.font = UIFont.preferredFont(forTextStyle: .footnote)
        return b
    }()
    
    func setupUserButton() {
        userButton.leftAnchor.constraint(equalTo: view.centerXAnchor, constant: 2.5).isActive = true
        userButton.topAnchor.constraint(equalTo: userText.topAnchor).isActive = true
        userButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        userButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        userButton.addTarget(self, action: #selector(toUser), for: .touchUpInside)
    }
    
    func toUser() {
        let resetVC = LoginViewController()
        self.present(resetVC, animated: true, completion: nil)
    }
    
    let barNameText: UITextField = {
        let text = UITextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.backgroundColor = UIColor.lightGray
        text.textColor = UIColor.red
        text.placeholder = "Bar Name"
        text.layer.cornerRadius = 5
        text.layer.masksToBounds = true
        return text
        
    }()
    
    func setUpBarText() {
        barNameText.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        barNameText.topAnchor.constraint(equalTo: userText.bottomAnchor, constant: 20).isActive = true
        barNameText.heightAnchor.constraint(equalToConstant: 40).isActive = true
        barNameText.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -80).isActive = true
    }
    
    let barAddressText: UITextField = {
        let text = UITextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.backgroundColor = UIColor.lightGray
        text.textColor = UIColor.red
        text.placeholder = "Bar Address"
        text.layer.cornerRadius = 5
        text.layer.masksToBounds = true
        return text
        
    }()
    
    func setUpBarAddressText() {
        barAddressText.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        barAddressText.topAnchor.constraint(equalTo: barNameText.bottomAnchor, constant: 10).isActive = true
        barAddressText.heightAnchor.constraint(equalToConstant: 40).isActive = true
        barAddressText.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -80).isActive = true
    }
    
    let barCityText: UITextField = {
        let text = UITextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.backgroundColor = UIColor.lightGray
        text.textColor = UIColor.red
        text.placeholder = "City"
        text.layer.cornerRadius = 5
        text.layer.masksToBounds = true
        return text
        
    }()
    
    func setUpBarCityText() {
        barCityText.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        barCityText.topAnchor.constraint(equalTo: barAddressText.bottomAnchor, constant: 10).isActive = true
        barCityText.heightAnchor.constraint(equalToConstant: 40).isActive = true
        barCityText.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -80).isActive = true
    }
    
    let barZipText: UITextField = {
        let text = UITextField()
        text.keyboardType = .numberPad
        text.translatesAutoresizingMaskIntoConstraints = false
        text.backgroundColor = UIColor.lightGray
        text.textColor = UIColor.red
        text.placeholder = "Zip Code"
        text.layer.cornerRadius = 5
        text.layer.masksToBounds = true
        return text
        
    }()
    
    func setUpBarZipText() {
        barZipText.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        barZipText.topAnchor.constraint(equalTo: barCityText.bottomAnchor, constant: 10).isActive = true
        barZipText.heightAnchor.constraint(equalToConstant: 40).isActive = true
        barZipText.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -80).isActive = true
    }
    
    
    let barStateText: UITextField = {
        let text = UITextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.backgroundColor = UIColor.lightGray
        text.textColor = UIColor.red
        text.placeholder = "State"
        text.layer.cornerRadius = 5
        text.layer.masksToBounds = true
        return text
        
    }()
    
    func setUpBarStateText() {
        barStateText.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        barStateText.topAnchor.constraint(equalTo: barZipText.bottomAnchor, constant: 10).isActive = true
        barStateText.heightAnchor.constraint(equalToConstant: 40).isActive = true
        barStateText.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -80).isActive = true
    }



    
    let emailText: UITextField = {
        let text = UITextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.keyboardType = .emailAddress
        text.backgroundColor = UIColor.lightGray
        text.textColor = UIColor.red
        text.placeholder = "Email"
        text.layer.cornerRadius = 5
        text.layer.masksToBounds = true
        return text
        
    }()
    
    func setUpEmailText() {
        emailText.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emailText.topAnchor.constraint(equalTo: barStateText.bottomAnchor, constant: 10).isActive = true
        emailText.heightAnchor.constraint(equalToConstant: 40).isActive = true
        emailText.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -80).isActive = true
    }
    
    let passText: UITextField = {
        let text = UITextField()
        text.isSecureTextEntry = true
        text.translatesAutoresizingMaskIntoConstraints = false
        text.backgroundColor = UIColor.lightGray
        text.textColor = UIColor.red
        text.placeholder = "Password"
        text.layer.cornerRadius = 5
        text.layer.masksToBounds = true
        return text
    }()
    
    func setUpPassText() {
        passText.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        passText.topAnchor.constraint(equalTo: emailText.bottomAnchor, constant: 10).isActive = true
        passText.heightAnchor.constraint(equalToConstant: 40).isActive = true
        passText.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -80).isActive = true
    }
    
    
    let signUpButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.darkGray
        button.setTitle("Register your bar!", for: .normal)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        return button
        
    }()
    
    func setupSignUpButton() {
        signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        signUpButton.topAnchor.constraint(equalTo: passText.bottomAnchor, constant: 20).isActive = true
        signUpButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        signUpButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -80).isActive = true
        signUpButton.addTarget(self, action: #selector(signUp), for: .touchUpInside)
        
    }
    
    func signUp() {
        guard let email = emailText.text, let password = passText.text, let name = barNameText.text, let address = barAddressText.text, let city = barCityText.text, let zip = barZipText.text, let state = barStateText.text else {
            print("Form not valid")
            return
        }
        //success
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
            if error != nil {
                print(error!)
                return
            }
            guard let uid = user?.uid else {
                return
            }
            let ref = FIRDatabase.database().reference(fromURL: "https://tapin-a514d.firebaseio.com/")
            let usersReference = ref.child("bars").child(uid)
            let values = ["Bar Name": name, "email": email, "Address": address, "City": city, "Zip Code": zip,
                          "State": state]
            usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
                if err != nil {
                    print(err!)
                    return
                }
                print("Saved user successfully into Firebase DB")
            })
            let barHomeVC = BarHomeViewController()
            self.present(barHomeVC, animated: true, completion: nil)
            
            
        })
    }
    let loginText: UILabel = {
        let t = UILabel()
        t.translatesAutoresizingMaskIntoConstraints = false
        t.text = "Already have an account?"
        t.font = UIFont.preferredFont(forTextStyle: .footnote)
        
        return t
    }()
    
    func setupLoginText() {
        loginText.rightAnchor.constraint(equalTo: view.centerXAnchor, constant: 2.5).isActive = true
        loginText.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
    }
    
    let loginButton: UIButton = {
        let b = UIButton(type: .system)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.backgroundColor = .white
        b.setTitle("Login with your bar's email here.", for: .normal)
        b.setTitleColor(.blue, for: .normal)
        b.titleLabel!.font = UIFont.preferredFont(forTextStyle: .footnote)
        return b
    }()
    
    func setuploginButton() {
        loginButton.leftAnchor.constraint(equalTo: view.centerXAnchor, constant: 2.5).isActive = true
        loginButton.bottomAnchor.constraint(equalTo: loginText.bottomAnchor).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        loginButton.widthAnchor.constraint(equalToConstant: 140).isActive = true
        loginButton.addTarget(self, action: #selector(toLogin), for: .touchUpInside)
    }
    
    func toLogin() {
        let loginVC = BarLoginController()
        self.present(loginVC, animated: true, completion: nil)
        
    }



}
