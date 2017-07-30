//
//  ResetPasswordViewController.swift
//  TapIn
//
//  Created by James Daubert on 7/17/17.
//  Copyright © 2017 James Daubert. All rights reserved.
//

import Firebase
import FirebaseAuth

class ResetPasswordViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(emailText)
        view.addSubview(resetButton)
        view.addSubview(loginText)
        view.addSubview(loginButton)
        
        setUpEmailText()
        setUpResetButton()
        setupLoginText()
        setUpLoginButton()
        
        
        
    }
    
    let emailText: UITextField = {
        let text = UITextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.backgroundColor = UIColor.lightGray
        text.textColor = UIColor.red
        text.placeholder = "Enter your email here"
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
    
    let resetButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.darkGray
        button.setTitle("Reset password", for: .normal)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        return button
        
    }()
    
    func setUpResetButton() {
        resetButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        resetButton.topAnchor.constraint(equalTo: emailText.bottomAnchor, constant: 20).isActive = true
        resetButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        resetButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -80).isActive = true
        resetButton.addTarget(self, action: #selector(resetPassDo), for: .touchUpInside)
        
    }
    
    let loginText: UILabel = {
        let t = UILabel()
        t.translatesAutoresizingMaskIntoConstraints = false
        t.text = "Remember your info?"
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
        b.setTitle("Login here", for: .normal)
        b.setTitleColor(.blue, for: .normal)
        b.titleLabel!.font = UIFont.preferredFont(forTextStyle: .footnote)
        return b
    }()
    
    func setUpLoginButton() {
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
    
    func resetPassDo() {
        
        if self.emailText.text == "" {
            let alertController = UIAlertController(title: "Oops!", message: "Please enter an email.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
            
        } else {
            FIRAuth.auth()?.sendPasswordReset(withEmail: self.emailText.text!, completion: { (error) in
                
                var title = ""
                var message = ""
                
                if error != nil {
                    title = "Error!"
                    message = (error?.localizedDescription)!
                } else {
                    title = "Success!"
                    message = "Password reset email sent."
                    self.emailText.text = ""
                }
                
                let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                
                self.present(alertController, animated: true, completion: nil)
                self.present(LoginViewController(), animated: true, completion: nil)
                
            })
        }
        
    }
    
    
}

