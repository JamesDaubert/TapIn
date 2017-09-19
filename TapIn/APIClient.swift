//
//  APIClient.swift
//  TapIn
//
//  Created by James Daubert on 8/3/17.
//  Copyright © 2017 James Daubert. All rights reserved.
//

import Stripe
import Alamofire

class APIClient: NSObject, STPEphemeralKeyProvider {
    static let sharedClient = APIClient()
    var baseURLString: String? = nil
    var baseURL: URL {
        if let urlstring = self.baseURLString, let url = URL(string: urlstring) {
            return url
        } else {
            fatalError()
        }
    }
    
    func completeCharge(_ result: STPPaymentResult,
                        amount: Int,
                        completion: @escaping STPErrorBlock) {
        let url = self.baseURL.appendingPathComponent("charge")
        let params: [String: Any] = [
            "source": result.source.stripeID,
            "amount": amount
        ]
        Alamofire.request(url, method: .post, parameters: params)
            .validate(statusCode: 200..<300)
            .responseString { response in
                switch response.result {
                case .success:
                    completion(nil)
                case .failure(let error):
                    completion(error)
                }
        }
    }
    
    func createCustomerKey(withAPIVersion apiVersion: String, completion: @escaping STPJSONResponseCompletionBlock) {
        let url = self.baseURL.appendingPathComponent("ephemeral_keys")
        Alamofire.request(url, method: .post, parameters: [
            "api_version": apiVersion
            ])
            .validate(statusCode: 200..<300)
            .responseJSON { responseJSON in
                switch responseJSON.result {
                case .success(let json):
                    completion(json as? [String: AnyObject], nil)
                case .failure(let error):
                    completion(nil, error)
                }
        }
    }
    
}
