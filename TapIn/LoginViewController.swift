//
//  LoginViewController.swift
//  TapIn
//
//  Created by James Daubert on 7/17/17.
//  Copyright © 2017 James Daubert. All rights reserved.
//

import FirebaseAuth
import Firebase
import FacebookLogin
import FacebookCore
import FBSDKLoginKit



class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        checkIfUserIsLoggedIn()
        
        view.addSubview(tapInTitle)
        view.addSubview(emailText)
        view.addSubview(passText)
        view.addSubview(loginButton)
        view.addSubview(fbButton)
        view.addSubview(orText)
        view.addSubview(signUpText)
        view.addSubview(signUpButton)
        view.addSubview(resetText)
        view.addSubview(resetButton)
        view.addSubview(barText)
        view.addSubview(barButton)
        
        setUpFacebookButton()
        setUpEmailText()
        setUpPassText()
        setUpLoginButton()
        setupTapInTitle()
        setupOrText()
        setupSignUpText()
        setupSignUpButton()
        setupResetText()
        setupResetButton()
        setupBarText()
        setupBarButton()
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
    
    let orText: UILabel = {
        let t = UILabel()
        t.translatesAutoresizingMaskIntoConstraints = false
        t.text = "OR"
        t.textColor = .black
        return t
    }()
    
    func setupOrText() {
        orText.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        orText.topAnchor.constraint(equalTo: resetText.bottomAnchor, constant: 20).isActive = true
    }
    
    let signUpText: UILabel = {
        let t = UILabel()
        t.translatesAutoresizingMaskIntoConstraints = false
        t.text = "New to Tap In?"
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
        b.setTitle("Sign up with your email here.", for: .normal)
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
        let signUpVC = SignUpViewController()
        self.present(signUpVC, animated: true, completion: nil)
       
    }
    
    let resetText: UILabel = {
        let t = UILabel()
        t.translatesAutoresizingMaskIntoConstraints = false
        t.text = "Forgot your info?"
        t.font = UIFont.preferredFont(forTextStyle: .footnote)
        
        return t
    }()
    
    func setupResetText() {
        resetText.rightAnchor.constraint(equalTo: view.centerXAnchor, constant: 2.5).isActive = true
        resetText.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 10).isActive = true
    }
    
    let resetButton: UIButton = {
        let b = UIButton(type: .system)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.backgroundColor = .white
        b.setTitle("Reset your password here.", for: .normal)
        b.setTitleColor(.blue, for: .normal)
        b.titleLabel!.font = UIFont.preferredFont(forTextStyle: .footnote)
        return b
    }()
    
    func setupResetButton() {
        resetButton.leftAnchor.constraint(equalTo: view.centerXAnchor, constant: 2.5).isActive = true
        resetButton.topAnchor.constraint(equalTo: resetText.topAnchor).isActive = true
        resetButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        resetButton.widthAnchor.constraint(equalToConstant: 180).isActive = true
        resetButton.addTarget(self, action: #selector(toReset), for: .touchUpInside)
    }
    
    func toReset() {
        let resetVC = ResetPasswordViewController()
        self.present(resetVC, animated: true, completion: nil)
           }

    let barText: UILabel = {
        let t = UILabel()
        t.translatesAutoresizingMaskIntoConstraints = false
        t.text = "Looking for Bar Login?"
        t.font = UIFont.preferredFont(forTextStyle: .footnote)
        
        return t
    }()
    
    func setupBarText() {
        barText.rightAnchor.constraint(equalTo: view.centerXAnchor, constant: 2.5).isActive = true
        barText.topAnchor.constraint(equalTo: tapInTitle.bottomAnchor, constant: 20).isActive = true
    }
    
    let barButton: UIButton = {
        let b = UIButton(type: .system)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.backgroundColor = .white
        b.setTitle("It's over here.", for: .normal)
        b.setTitleColor(.blue, for: .normal)
        b.titleLabel!.font = UIFont.preferredFont(forTextStyle: .footnote)
        return b
    }()
    
    func setupBarButton() {
        barButton.leftAnchor.constraint(equalTo: view.centerXAnchor, constant: 2.5).isActive = true
        barButton.topAnchor.constraint(equalTo: barText.topAnchor).isActive = true
        barButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        barButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        barButton.addTarget(self, action: #selector(toBar), for: .touchUpInside)
    }
    
    func toBar() {
        let resetVC = BarLoginController()
        self.present(resetVC, animated: true, completion: nil)
    }

    

    let fbButton = FBSDKLoginButton()
    
    private func setUpFacebookButton() {
        fbButton.translatesAutoresizingMaskIntoConstraints = false
        fbButton.centerXAnchor.constraint(equalTo: emailText.centerXAnchor).isActive = true
        fbButton.topAnchor.constraint(equalTo: orText.bottomAnchor, constant: 10).isActive = true
        fbButton.frame = CGRect(x: 16, y: orText.frame.minY , width: view.frame.width, height: 50)
        fbButton.delegate = self
        
        
     }
    
    
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
            } else {
                print("FIRAUTH Success with fb token: ", user ?? "")
                self.presentHome()
            }
            
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
    
    func checkIfUserIsLoggedIn() {
        if FIRAuth.auth()?.currentUser != nil {
            self.presentHome()
        }
    }
    
    func presentHome() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeVC = storyboard.instantiateViewController(withIdentifier: "MainTab")
        present(homeVC, animated: true, completion: nil)
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
                        self.presentHome()
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

