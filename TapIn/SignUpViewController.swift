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

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var emailText: UITextField!
    
    @IBOutlet weak var passText: UITextField!
    
    //signup
    @IBAction func signUpDo(_ sender: Any) {
        
        if emailText.text == "" {
            let alertController = UIAlertController(title: "Error", message: "Please reenter your email and password", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
            
        } else {
            
            FIRAuth.auth()?.createUser(withEmail: emailText.text!, password: passText.text!) { user, error in
            
                if error == nil {
                    print("You're signed up! Success!")
                    
                    //carries user to home page storyboard if there is no error
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "Home")
                    self.present(vc!, animated: true, completion: nil)
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

