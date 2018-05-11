//
//  RegisterUserViewController.swift
//  Test2
//
//  Created by Ars on 09.05.2018.
//  Copyright © 2018 ArsenIT. All rights reserved.
//

import UIKit
import Alamofire

class RegisterUserViewController: UIViewController {
    
    @IBOutlet weak var nameUserTextField: UITextField!
    @IBOutlet weak var emailUserTextField: UITextField!
    @IBOutlet weak var passwordUserTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
    @IBOutlet weak var tokenTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signUpButtonPressed(_ sender: Any) {
        
        validateEmptyFields()
        validatePassword()
        signup()
        
        
        
        
    }
    
    //validate required fields are no empty
    func validateEmptyFields() {
        if (nameUserTextField.text?.isEmpty)! ||
            (emailUserTextField.text?.isEmpty)! ||
            (passwordUserTextField.text?.isEmpty)!
        {
            //Display alert message and return
            displayMessage(userMessage: "All Fields are quired to fill in")
            return
        }
    }
    
    //validate password
    func validatePassword() {
        if ((passwordUserTextField.text?.elementsEqual(repeatPasswordTextField.text!))! != true)
        {
            //Display alert message and return
            displayMessage(userMessage: "Please make sure that passwords match")
            return
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
    //Register new user
    func signup(){
        var token = String()
        var dic = NSDictionary()
        let parameters: [String: AnyObject] = [
            "name": nameUserTextField.text,
            "email": emailUserTextField.text,
            "password": passwordUserTextField.text
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
                        self.tokenTextField.text = token
                    }
                }
            }
        }
    }
    
    
}




