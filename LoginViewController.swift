//
//  LoginViewController.swift
//  TapIn
//
//  Created by James Daubert on 7/17/17.
//  Copyright © 2017 James Daubert. All rights reserved.
//

import FirebaseAuth
import Firebase


class LoginViewController: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    
    @IBOutlet weak var passText: UITextField!
    
    //login
    @IBAction func loginDo(_ sender: Any) {
        
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
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeNC")
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

