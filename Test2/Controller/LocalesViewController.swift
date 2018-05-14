//
//  LocalesViewController.swift
//  Test2
//
//  Created by Ars on 13.05.2018.
//  Copyright © 2018 ArsenIT. All rights reserved.
//

import UIKit
import KeychainSwift

class LocalesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var locales = [String]()
    let identifire = "OccuranceCell"
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locales = LocaleBox().locales
        createTable()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 60
    }
    
    @IBAction func signOutButtonPressed(_ sender: Any) {
        signOut()
    }
    
    func createTable() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifire)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        view.addSubview(tableView)
        
    }
    
    func signOut() {
        let keychain = KeychainSwift()
        keychain.delete("access_token")
        let signInPage = self.storyboard?.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
        self.present(signInPage, animated: true, completion: nil)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.locales.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifire, for: indexPath)
        
        let locale = self.locales[indexPath.row]
        cell.textLabel?.text = "\(locale)"
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "OccurenceViewController") as? OccurenceViewController
        vc?.setLocale(locales[indexPath.row])
        self.present(vc!, animated: true)
        
    }
    
    
}





