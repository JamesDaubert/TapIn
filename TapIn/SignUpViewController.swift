//
//  SignUpViewController.swift
//  TapIn
//
//  Created by James Daubert on 7/17/17.
//  Copyright © 2017 James Daubert. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FacebookLogin
import FBSDKLoginKit
import FirebaseDatabase

class SignUpViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(tapInTitle)
        view.addSubview(fbButton)
        view.addSubview(orText)
        view.addSubview(loginText)
        view.addSubview(loginButton)
        view.addSubview(nextButton)
        
        setUpFacebookButton()
        setupTapInTitle()
        setupOrText()
        setupLoginText()
        setuploginButton()
        setupNextButton()

    }
    
    @IBOutlet weak var passText: UITextField!
    
    //signup
    
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
    
    let nextButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.darkGray
        button.setTitle("Sign up with your email", for: .normal)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        return button
        
    }()
    
    func setupNextButton() {
        nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nextButton.topAnchor.constraint(equalTo: orText.bottomAnchor, constant: 20).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        nextButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -80).isActive = true
        nextButton.addTarget(self, action: #selector(emailSignUp), for: .touchUpInside)
        
    }
    
    func emailSignUp() {
        let emailSignUpVC = EmailSignUpViewController()
        self.present(emailSignUpVC, animated: true, completion: nil)
       
    }
    
    let orText: UILabel = {
        let t = UILabel()
        t.translatesAutoresizingMaskIntoConstraints = false
        t.text = "OR"
        t.textColor = .black
        return t
    }()
    
    func setupOrText() {
        orText.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        orText.topAnchor.constraint(equalTo: fbButton.bottomAnchor, constant: 20).isActive = true
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
    
    
    
    let fbButton = FBSDKLoginButton()
    
    private func setUpFacebookButton() {
        fbButton.delegate = self
        fbButton.translatesAutoresizingMaskIntoConstraints = false
        fbButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        fbButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 10).isActive = true
        fbButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -80).isActive = true
        fbButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
    }
    
//    static var fbName: String  {
//        let name: String = "Login with Facebook"
//        guard let fbDisplayName = FIRAuth.auth()?.currentUser?.displayName else { return name }
//        return fbDisplayName
//    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Did logout")
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print(error)
            return
        } else {
            showEmail()
        }
    }
    func showEmail() {
        let accessToken = FBSDKAccessToken.current()
        guard let accessTokenString = accessToken?.tokenString else { return }
        print("ACCESS TOKEN STRING: ", accessTokenString)
        let credential = FIRFacebookAuthProvider.credential(withAccessToken: accessTokenString)
        //signs in user
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if error != nil {
                print("oops: ", error!)
            }
            print("FIRAUTH Success with fb token: ", user ?? "")
            guard
                let email = FIRAuth.auth()?.currentUser?.email,
                let name = FIRAuth.auth()?.currentUser?.displayName else { return }
                let ref = FIRDatabase.database().reference(fromURL: "https://tapin-a514d.firebaseio.com/")
                let usersReference = ref.child("users")
                let values = ["name": name, "email": email]
                usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
                    if err != nil {
                        print(err!)
                        return
                    }
                    print("Saved user successfully into Firebase DB")
            })
            let homeVC = self.storyboard!.instantiateViewController(withIdentifier: "Tab")
            self.present(homeVC, animated: true, completion: nil)
           
        })
        
        //gets users email, id, name
        FBSDKGraphRequest(graphPath: "/me", parameters: ["fields": "id, name, email"]).start { (connection, result, err) in
            if err != nil {
                print("failed to graph request: ", err!)
            } else {
                print(result ?? "")
                
            }
        }
        
        
    }
    
}

