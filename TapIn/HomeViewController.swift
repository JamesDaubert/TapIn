//
//  HomeViewController.swift
//  TapIn
//
//  Created by James Daubert on 7/17/17.
//  Copyright © 2017 James Daubert. All rights reserved.
//

import Firebase
import FirebaseAuth

class HomeViewController: UIViewController {
    
    //Menu variables
    @IBOutlet weak var menuView: UIView! //slidebar outlet
    var menuShowing = false
    @IBOutlet weak var leadConstraint: NSLayoutConstraint! //controls leadConstraint for slidebar 
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        menuView.layer.shadowOpacity = 1 //gives shadow for slide menu
        menuView.layer.shadowRadius = 0 //makes shadow larger (default is 3)
        
        
    }
    
    @IBAction func openMenu(_ sender: Any) {
        
        if(menuShowing) {
            leadConstraint.constant = -140
            menuView.layer.shadowRadius = 0
            UIView.animate(withDuration: 0.3, animations: { self.view.layoutIfNeeded()})
        } else {
            leadConstraint.constant = 0
            menuView.layer.shadowRadius = 5
            UIView.animate(withDuration: 0.3, animations: { self.view.layoutIfNeeded()})
        }
        menuShowing = !menuShowing
    }
    @IBAction func closeMenu(_ sender: Any) {
        
        if(menuShowing) {
            leadConstraint.constant = -140
            menuView.layer.shadowRadius = 0
            UIView.animate(withDuration: 0.3, animations: { self.view.layoutIfNeeded()})
        }
        menuShowing = !menuShowing
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func logoutDo(_ sender: Any) {
        
        if FIRAuth.auth()?.currentUser != nil {
            do{
                try FIRAuth.auth()?.signOut()
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Login")
                
                present(vc, animated: true, completion: nil)
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        
    }
    
}

