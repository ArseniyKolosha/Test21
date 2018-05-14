//
//  SignInViewController.swift
//  Test2
//
//  Created by Ars on 09.05.2018.
//  Copyright © 2018 ArsenIT. All rights reserved.
//

import UIKit
import Alamofire
import KeychainSwift

class SignInViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func signInButtonPressed(_ sender: Any) {
        login()
    }
    
    @IBAction func registerButtonPressed(_ sender: Any) {
        let registerViewController = self.storyboard?.instantiateViewController(withIdentifier: "RegisterUserViewController") as! RegisterUserViewController
        self.present(registerViewController, animated: true, completion: nil)
        
        
    }
    
    func login(){
        var token = String()
        var dic = NSDictionary()
        let parameters: [String: AnyObject] = [
            "email": emailTextField.text!,
            "password": passwordTextField.text!
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
                        let keychain = KeychainSwift()
                        keychain.set(token, forKey: "access_token")
                        DispatchQueue.main.async {
                            let homePage = self.storyboard?.instantiateViewController(withIdentifier: "LocalesViewController") as! LocalesViewController
                            let appDelegate = UIApplication.shared.delegate
                            appDelegate?.window??.rootViewController = homePage
                        }
                        
                        
                    }
                }
            }
        }
    }
    
    
    
    func displayMessage(userMessage: String) -> Void {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Alert", message: userMessage, preferredStyle: .alert)
            let OkAction = UIAlertAction(title: "Ok", style: .default) { (action: UIAlertAction) in
                //Code in this block will trigger when OK button tapped
                print("OK button tapped")
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                }
            }
            alertController.addAction(OkAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func validateEmptyFields(){
        let userEmail = emailTextField
        let userPassword = passwordTextField
        if (userEmail?.text?.isEmpty)! || (userPassword?.text?.isEmpty)! {
            displayMessage(userMessage: "One of the required fields is missing")
            
            return
        }
        
    }
    
    
}
