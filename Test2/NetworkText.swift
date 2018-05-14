//
//  NetworkText.swift
//  Test2
//
//  Created by Ars on 13.05.2018.
//  Copyright © 2018 ArsenIT. All rights reserved.
//

import UIKit
import Alamofire
import KeychainSwift

class NetworkText {
    static let sharedManager = NetworkText()
    private init() {}
    
    func getText(for locale:String, with completion:@escaping (Any?)->()) -> Void {
        let keychain = KeychainSwift()
        var accessToken: String? = keychain.get("access_token")
        let url = "https://apiecho.cf/api/get/text/"
        let headers = ["Authorization":"Bearer \(accessToken)"]
        //let parameters = ["Locale":locale]
        
        Alamofire.request(url,
                          method: .get,
                        /*  parameters: parameters,*/
                          encoding: JSONEncoding.default,
                          headers: headers)
            
            .responseJSON { response in
                switch (response.result) {
                case .success:
                    if let json = response.result.value as? NSDictionary {
                        completion(json)
                    }
                    
                case .failure(let error):
                    guard let statusCode = response.response?.statusCode else { return }
                    if statusCode == 422 {
                        HomePageViewController.homePage.signOut()
                       print("Error")
                    }
                    let message = error.localizedDescription + "\nStatus code:\(statusCode)"
                    print(message)
                }
        }
    }
}

