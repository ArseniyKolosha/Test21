//
//  RegisterUserViewController.swift
//  Test2
//
//  Created by Ars on 09.05.2018.
//  Copyright © 2018 ArsenIT. All rights reserved.
//

import UIKit

class RegisterUserViewController: UIViewController {
    
    @IBOutlet weak var nameUserTextField: UITextField!
    @IBOutlet weak var emailUserTextField: UITextField!
    @IBOutlet weak var passwordUserTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
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
        //validate required fields are no empty
        if (nameUserTextField.text?.isEmpty)! ||
            (emailUserTextField.text?.isEmpty)! ||
            (passwordUserTextField.text?.isEmpty)!
        {
            //Display alert message and return
            displayMessage(userMessage: "All Fields are quired to fill in")
            return
        }
        //validate password
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
    
    
}




