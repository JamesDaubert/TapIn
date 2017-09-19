//
//  PaymentInfoViewController.swift
//  TapIn
//
//  Created by James Daubert on 8/3/17.
//  Copyright © 2017 James Daubert. All rights reserved.
//

import UIKit

class PaymentInfoViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(returnButton)
        setupReturnButton()
        
        
    }
    
    let returnButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Back to Profile", for: .normal)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        return button
    }()
    
    func setupReturnButton() {
        returnButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        returnButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        returnButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.2).isActive = true
        returnButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        returnButton.addTarget(self, action: #selector(goToProfile), for: .touchUpInside)
    }
    
    func goToProfile() {
        self.dismiss(animated: true, completion: nil)
    }
    
}
