//
//  CurrentTabViewController.swift
//  TapIn
//
//  Created by James Daubert on 7/25/17.
//  Copyright © 2017 James Daubert. All rights reserved.
//

import Foundation
import UIKit
import Stripe
import Alamofire


class CurrentTabViewController: UITableViewController {
    
    let settingsVC = SettingsViewController()
    let purchaseAndPrice = [
    
        "Beer" : 200,
        "Vodka": 500,
        "Wine": 600
    
    ]
    let barName = ""
    let total: Double = 0.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Current Tab"
        self.navigationController?.isToolbarHidden = false
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Tap Out", style: .plain, target: self, action: #selector(tapOut))
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        let theme = settingsVC.settings.theme
        self.view.backgroundColor = theme.primaryBackgroundColor
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.purchaseAndPrice.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") ?? UITableViewCell(style: .value1, reuseIdentifier: "Cell")
        let product = Array(self.purchaseAndPrice.keys)[(indexPath as NSIndexPath).row]
        let price = self.purchaseAndPrice[product]!
        let theme = self.settingsVC.settings.theme
        cell.backgroundColor = theme.secondaryBackgroundColor
        cell.textLabel?.text = product
        cell.textLabel?.font = theme.font
        cell.textLabel?.textColor = theme.primaryForegroundColor
        cell.detailTextLabel?.text = "$\(price/100).00"
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tapOut() {
        let product =  "Drinks at \(barName)"
        let price = total
        let checkoutVC = CheckoutRowViewController(product: product, price: price, settings: self.settingsVC.settings)
        self.navigationController?.pushViewController(checkoutVC, animated: true)
    }
    
    
    
}
