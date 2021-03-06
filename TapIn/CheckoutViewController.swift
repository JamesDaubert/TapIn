//
//  CheckoutViewController.swift
//  TapIn
//
//  Created by James Daubert on 8/5/17.
//  Copyright © 2017 James Daubert. All rights reserved.
//

import Foundation
import Stripe
import Alamofire

class CheckoutRowViewController: UIViewController, STPPaymentContextDelegate {
    //MARK: Payment Initializers
    
    
    let theme: STPTheme
    let pubKey = "pk_test_vOLquHuIJPHp0G71yoxi4LUG"
    let backendBaseURL: String? = "https://tapinapp.herokuapp.com"
    let companyName = "BAR NAME"
    let paymentCurrency = "usd"
    
    let paymentContext: STPPaymentContext
    
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    let paymentRow: CheckoutRowView
    let totalRow: CheckoutRowView
    let buyButton: BuyButton
    let rowHeight: CGFloat = 44
    let numberFormatter: NumberFormatter
    let productImage = UILabel()
    var product = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = self.theme.primaryBackgroundColor
        self.title = "Tap Out of \(self.companyName)"
        
        self.productImage.font = UIFont.systemFont(ofSize: 70)
        self.view.addSubview(self.totalRow)
        self.view.addSubview(self.paymentRow)
        self.view.addSubview(productImage)
        self.view.addSubview(self.buyButton)
        self.view.addSubview(self.activityIndicator)
        
        self.activityIndicator.alpha = 0
        self.buyButton.addTarget(self, action: #selector(payButtonTapped), for: .touchUpInside)
        self.totalRow.detail = self.numberFormatter.string(from: NSNumber(value: Float(self.paymentContext.paymentAmount)/100))!
        self.paymentRow.onTap = { [weak self] _ in
            self?.paymentContext.pushPaymentMethodsViewController()
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let width = view.bounds.width
        
        self.productImage.sizeToFit()
        self.productImage.center = CGPoint(x: width/2.0,
                                           y: self.productImage.bounds.height/2.0 + rowHeight)
        
        self.paymentRow.frame = CGRect(x: 0, y: self.productImage.frame.maxY + rowHeight,
                                       width: width, height: rowHeight)
        self.totalRow.frame = CGRect(x: 0, y: self.paymentRow.frame.maxY,
                                     width: width, height: rowHeight)
        self.buyButton.frame = CGRect(x: 0, y: 0, width: 88, height: 44)
        self.buyButton.center = CGPoint(x: width/2.0, y: self.totalRow.frame.maxY + rowHeight*1.5)
        self.activityIndicator.center = self.buyButton.center
    }
    
    var paymentInProgress: Bool = false {
        didSet {
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
                if self.paymentInProgress {
                    self.activityIndicator.startAnimating()
                    self.activityIndicator.alpha = 1
                    self.buyButton.alpha = 0
                }
                else {
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.alpha = 0
                    self.buyButton.alpha = 1
                }
            }, completion: nil)
        }
    }
    
    init(product: String, price: Double, settings: Settings) {
        
        let stripePublishableKey = self.pubKey
        let backendBaseURL = self.backendBaseURL
        
        
        self.product = product
        self.productImage.text = product
        self.theme = settings.theme
        APIClient.sharedClient.baseURLString = backendBaseURL
        
        let config = STPPaymentConfiguration.shared()
        config.publishableKey = stripePublishableKey
        config.companyName = self.companyName
        config.requiredBillingAddressFields = settings.requiredBillingAddressFields
        config.additionalPaymentMethods = settings.additionalPaymentMethods
        
        let customerContext = STPCustomerContext(keyProvider: APIClient.sharedClient)
        let paymentContext = STPPaymentContext(customerContext: customerContext,
                                               configuration: config,
                                               theme: settings.theme)
        let userInformation = STPUserInformation()
        paymentContext.prefilledInformation = userInformation
        paymentContext.paymentAmount = Int(price * 100.0)
        paymentContext.paymentCurrency = self.paymentCurrency
        self.paymentContext = paymentContext
        
        self.paymentRow = CheckoutRowView(title: "Payment", detail: "Select Payment",
                                          theme: settings.theme)
        
        self.totalRow = CheckoutRowView(title: "Total", detail: "", tappable: false,
                                        theme: settings.theme)
        self.buyButton = BuyButton(enabled: true, theme: settings.theme)
        var localeComponents: [String: String] = [
            NSLocale.Key.currencyCode.rawValue: self.paymentCurrency,
            ]
        localeComponents[NSLocale.Key.languageCode.rawValue] = NSLocale.preferredLanguages.first
        let localeID = NSLocale.localeIdentifier(fromComponents: localeComponents)
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale(identifier: localeID)
        numberFormatter.numberStyle = .currency
        numberFormatter.usesGroupingSeparator = true
        self.numberFormatter = numberFormatter
        super.init(nibName: nil, bundle: nil)
        self.paymentContext.delegate = self
        paymentContext.hostViewController = self
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init: coder not initialized fuck u")
        
    }
    
    
    func choosePaymentButtonTapped() {
        self.paymentContext.presentPaymentMethodsViewController()
    }
    
    func payButtonTapped() {
        self.paymentInProgress = true
        self.paymentContext.requestPayment()
    }
    
    //STTPPaymentContextDelegate Conforming:
    
    func paymentContextDidChange(_ paymentContext: STPPaymentContext) {
        self.paymentRow.loading = paymentContext.loading
        if let paymentMethod = paymentContext.selectedPaymentMethod {
            self.paymentRow.detail = paymentMethod.label
        } else {
            self.paymentRow.detail = "Select Payment"
        }
        self.totalRow.detail = self.numberFormatter.string(from: NSNumber(value: Float(self.paymentContext.paymentAmount)/100))!
    }
    
    func paymentContext(_ paymentContext: STPPaymentContext, didCreatePaymentResult paymentResult: STPPaymentResult, completion: @escaping STPErrorBlock) {
        APIClient.sharedClient.completeCharge(paymentResult,
                                              amount: self.paymentContext.paymentAmount,
                                              completion: completion)
    }
    
    func paymentContext(_ paymentContext: STPPaymentContext, didFinishWith status: STPPaymentStatus, error: Error?) {
        self.paymentInProgress = false
        let title: String
        let message: String
        switch status {
        case .error:
            title = "Error"
            message = error?.localizedDescription ?? ""
        case .success:
            title = "Success"
            message = "You bought a \(self.product)!"
        case .userCancellation:
            return
        }
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func paymentContext(_ paymentContext: STPPaymentContext, didFailToLoadWithError error: Error) {
        let alertController = UIAlertController(
            title: "Error",
            message: error.localizedDescription,
            preferredStyle: .alert
        )
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
            // Need to assign to _ because optional binding loses @discardableResult value
            // https://bugs.swift.org/browse/SR-1681
            self.dismiss(animated: true, completion: nil)
        })
        let retry = UIAlertAction(title: "Retry", style: .default, handler: { action in
            self.paymentContext.retryLoading()
        })
        alertController.addAction(cancel)
        alertController.addAction(retry)
        self.present(alertController, animated: true, completion: nil)
    }
    
}
