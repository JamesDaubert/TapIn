//
//  BarLoginController.swift
//  TapIn
//
//  Created by James Daubert on 8/1/17.
//  Copyright © 2017 James Daubert. All rights reserved.
//

import UIKit
import Firebase

class BarLoginController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(signUpText)
        view.addSubview(signUpButton)
        view.addSubview(tapInTitle)
        view.addSubview(emailText)
        view.addSubview(passText)
        view.addSubview(loginButton)
        view.addSubview(userText)
        view.addSubview(userButton)
        
        setupSignUpText()
        setupSignUpButton()
        setupTapInTitle()
        setUpEmailText()
        setUpPassText()
        setUpLoginButton()
        setupUserText()
        setupUserButton()
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
        emailText.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40).isActive = true
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
    
    let loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.darkGray
        button.setTitle("Login", for: .normal)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        return button
        
    }()
    
    func setUpLoginButton() {
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.topAnchor.constraint(equalTo: passText.bottomAnchor, constant: 20).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        loginButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -80).isActive = true
        loginButton.addTarget(self, action: #selector(loginDo), for: .touchUpInside)
        
    }

    
    let signUpText: UILabel = {
        let t = UILabel()
        t.translatesAutoresizingMaskIntoConstraints = false
        t.text = "Not registered yet?"
        t.font = UIFont.preferredFont(forTextStyle: .footnote)
        
        return t
    }()
    
    func setupSignUpText() {
        signUpText.rightAnchor.constraint(equalTo: view.centerXAnchor, constant: 2.5).isActive = true
        signUpText.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
    }
    
    let signUpButton: UIButton = {
        let b = UIButton(type: .system)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.backgroundColor = .white
        b.setTitle("Sign up your bar here.", for: .normal)
        b.setTitleColor(.blue, for: .normal)
        b.titleLabel?.font = UIFont.preferredFont(forTextStyle: .footnote)
        return b
    }()
    
    func setupSignUpButton() {
        signUpButton.leftAnchor.constraint(equalTo: view.centerXAnchor, constant: 2.5).isActive = true
        signUpButton.bottomAnchor.constraint(equalTo: signUpText.bottomAnchor).isActive = true
        signUpButton.heightAnchor.constraint(equalToConstant: 15).isActive = true
        signUpButton.widthAnchor.constraint(equalToConstant: 180).isActive = true
        signUpButton.addTarget(self, action: #selector(toSignUp), for: .touchUpInside)
    }
    
    func toSignUp() {
        let signUpVC = BarSignUpViewController()
        self.present(signUpVC, animated: true, completion: nil)
        
    }
    
    func loginDo() {
        
        if self.emailText.text == "" || self.passText.text == "" {
            let alertController = UIAlertController(title: "Error", message: "Please reenter your email and password", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        } else {
            
            FIRAuth.auth()?.signIn(withEmail: self.emailText.text!, password: self.passText.text!)
            { user, error in
                
                if error == nil {
                    print("You're logged in!")
                    
                    //carries user to home page storyboard if there is no error
                    let barHomeVC = BarHomeViewController()
                    self.present(barHomeVC, animated: true, completion: nil)
                    
                } else {
                    //if there is an error, alert user (someone already is using their email).
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                    
                }
            }
        }
    }

}
