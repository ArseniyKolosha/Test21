//
//  SignInViewController.swift
//  Test2
//
//  Created by Ars on 09.05.2018.
//  Copyright © 2018 ArsenIT. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

   
    @IBAction func signInButtonPressed(_ sender: Any) {
    }
    
    @IBAction func registerButtonPressed(_ sender: Any) {
        let registerViewController = self.storyboard?.instantiateViewController(withIdentifier: "RegisterUserViewController") as! RegisterUserViewController
        self.present(registerViewController, animated: true, completion: nil)
    }
    
   

}
