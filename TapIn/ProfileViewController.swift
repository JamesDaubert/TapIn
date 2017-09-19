//
//  ProfileViewController.swift
//  TapIn
//
//  Created by James Daubert on 8/1/17.
//  Copyright © 2017 James Daubert. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase
import FacebookCore
import FBSDKCoreKit

class ProfileViewController: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "Profile"
        
       
        view.addSubview(profPic)
        view.addSubview(userName)
        view.addSubview(paymentInfoButton)
        
        setupProfilePicture()
        setupUserName()
        setupPaymentInfoButton()
        
        getFacebookUserInfo()
        
    }
    
    let profPic: UIImageView  = {
        let pic = UIImageView()
        pic.translatesAutoresizingMaskIntoConstraints = false
        
        return pic
    }()
    
    func setupProfilePicture() {
        profPic.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profPic.centerYAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor, constant: 80).isActive = true
        
    }
    
    let userName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    func setupUserName()  {
        userName.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        userName.topAnchor.constraint(equalTo: profPic.bottomAnchor, constant: 40).isActive = true
    }
    
    let paymentInfoButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .gray
        button.setTitle("Manage Payment Info", for: .normal)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        return button
    }()
    
    func setupPaymentInfoButton() {
        paymentInfoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        paymentInfoButton.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 40).isActive = true
        paymentInfoButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75).isActive = true
        paymentInfoButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        paymentInfoButton.addTarget(self, action: #selector(goToPaymentInfo), for: .touchUpInside)
    }
    
    func goToPaymentInfo() {
        self.present(PaymentInfoViewController(), animated: true, completion: nil)
    }

    
    func getFacebookUserInfo() {
        if(FBSDKAccessToken.current() != nil)
        {
            //print permissions, such as public_profile
            print(FBSDKAccessToken.current().permissions)
            let graphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields" : "id, name, email"])
            let connection = FBSDKGraphRequestConnection()
            
            connection.add(graphRequest, completionHandler: { (connection, result, error) -> Void in
                
                let data = result as! [String : AnyObject]
                
                self.userName.text = data["name"] as? String
                
                let FBid = data["id"] as? String
                
                let url = NSURL(string: "https://graph.facebook.com/\(FBid!)/picture?type=normal&return_ssl_resources=1")
                self.profPic.image = UIImage(data: NSData(contentsOf: url! as URL)! as Data)
                self.profPic.layer.masksToBounds = false
                self.profPic.layer.cornerRadius = self.profPic.frame.size.width / 2
                self.profPic.clipsToBounds = true
            })
            connection.start()
        }
    }
    
//    let profPicture: UIImage = {
//        var pic = UIImage()
//        guard let pictureRequest = FBSDKGraphRequest(graphPath: "me/picture?type=large&redirect=false", parameters: nil) else { return pic}
//        pictureRequest.start(completionHandler: {
//            (connection, result, error) -> Void in
//            if error == nil {
//                pic = result as! UIImage
//            } else {
//                print("Error: ", error!)
//            }
//        })
//        return pic
//    }()
}
