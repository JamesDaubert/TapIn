//
//  EmailSignUpViewController.swift
//  TapIn
//
//  Created by James Daubert on 7/30/17.
//  Copyright © 2017 James Daubert. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase

class EmailSignUpViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        
        view.addSubview(tapInTitle)
        view.addSubview(emailText)
        view.addSubview(passText)
        view.addSubview(fullNameText)
        view.addSubview(loginText)
        view.addSubview(loginButton)
        view.addSubview(signUpButton)
        
        setUpPassText()
        setUpEmailText()
        setupTapInTitle()
        setUpFullNameText()
        setuploginButton()
        setupLoginText()
        setupSignUpButton()
        
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
    
    let fullNameText: UITextField = {
        let text = UITextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.backgroundColor = UIColor.lightGray
        text.textColor = UIColor.red
        text.placeholder = "Full name"
        text.layer.cornerRadius = 5
        text.layer.masksToBounds = true
        return text
        
    }()
    
    func setUpFullNameText() {
        fullNameText.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        fullNameText.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40).isActive = true
        fullNameText.heightAnchor.constraint(equalToConstant: 40).isActive = true
        fullNameText.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -80).isActive = true
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
        emailText.centerYAnchor.constraint(equalTo: fullNameText.bottomAnchor, constant: 10).isActive = true
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
        button.setTitle("Sign up!", for: .normal)
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
        guard let email = emailText.text, let password = passText.text, let name = fullNameText.text else {
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
            let usersReference = ref.child("users").child(uid)
            let values = ["name": name, "email": email]
            usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
                if err != nil {
                    print(err!)
                    return
                }
                print("Saved user successfully into Firebase DB")
            })
            let homeVC = HomeViewController()
            self.present(homeVC, animated: true, completion: nil)
            

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
        b.setTitle("Login with your email here.", for: .normal)
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
        let loginVC = LoginViewController()
        self.present(loginVC, animated: true, completion: nil)
        
    }


}
