//
//  HomeViewController.swift
//  TapIn
//
//  Created by James Daubert on 7/17/17.
//  Copyright © 2017 James Daubert. All rights reserved.
//

import Firebase
import FirebaseAuth
import UIKit
import FacebookLogin
import FBSDKLoginKit

class HomeViewController: UIViewController {
    
    //Menu variables
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = .white
        checkIfUserIsLoggedIn()
        
       
        
        }
    
    
    func checkIfUserIsLoggedIn() {
        if FIRAuth.auth()?.currentUser == nil && FBSDKAccessToken.current() == nil  {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        } 
            
    }
    
    func handleLogout() {
        
        do {
            print("User logged out: ", FIRAuth.auth()?.currentUser ?? "user logged out")
            try FIRAuth.auth()?.signOut()
            
        } catch let logoutError {
            print(logoutError)
        }
        let loginController = LoginViewController()
        present(loginController, animated: false, completion: nil)
    }
    
    @IBAction func logoutDo(_ sender: Any) {
       handleLogout()
    }
    
}

