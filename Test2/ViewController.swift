//
//  ViewController.swift
//  Test2
//
//  Created by Ars on 09.05.2018.
//  Copyright © 2018 ArsenIT. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBAction func registerButtonPressed(_ sender: Any) {
        signup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        
       
     
        
    }
    func signup2() {
        
        let myUrl = URL(string: "https://apiecho.cf/api/signup/")
        
    }
    
    func signup(){

        
        var token = String()
        var dic = NSDictionary()
        let parameters: [String: AnyObject] = [
            "name": nameTextField.text!,
            "email": emailTextField.text!,
            "password": passwordTextField.text!
            ]as[String: AnyObject]
        let header = ["content-type": "application/x-www-form-urlencoded"]
        Alamofire.request("https://apiecho.cf/api/signup/", method: .post, parameters: parameters, encoding: URLEncoding.httpBody, headers: header).responseJSON { (response) in
            
            
            if response.result.isSuccess{
                print(response)
                dic = (response.result.value as? NSDictionary)!
                if let data = dic["data"]as? NSDictionary{
                    if let value = data["access_token"]as? String{
                        token =  value
                        print(token)
                    }
                }
            }
        }
    }
   
    
    func login()
    {
        var token = String()
        var dic = NSDictionary()
        let parameters: [String: AnyObject] = [
            
            "email": "daqhjhefjadss@gamil.com" ,
            "password": "string"
            ]as[String: AnyObject]
        let header = ["content-type": "application/x-www-form-urlencoded"]
        Alamofire.request("https://apiecho.cf/api/login/", method: .post, parameters: parameters, encoding: URLEncoding.httpBody, headers: header).responseJSON { (response) in
            
            
            if response.result.isSuccess{
                print(response)
                dic = (response.result.value as? NSDictionary)!
                
                if let data = dic["data"]as? NSDictionary{
                    if let value = data["access_token"]as? String{
                        token =  value
                        print(token)
                    }
                }
                
            }
            
            
        }
    }


   
    
    


}

