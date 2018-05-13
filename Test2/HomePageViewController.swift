//
//  HomePageViewController.swift
//  Test2
//
//  Created by Ars on 09.05.2018.
//  Copyright © 2018 ArsenIT. All rights reserved.
//

import UIKit
import Alamofire
import KeychainSwift

class HomePageViewController: UIViewController {

    var charactersDict = [Character:Int]()
    var characters = [Character]()
    @IBOutlet weak var textFromInternetTextView: UITextView!
    @IBOutlet weak var tableView: UITableView!
    static let homePage = HomePageViewController()
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 60
       // tableView.tableFooterView = UIView()
        
    }

    
    @IBAction func signOutButtonPressed(_ sender: Any) {
        
        signOut()
        
    }
    
    func signOut() {
        let keychain = KeychainSwift()
        keychain.delete("access_token")
        let signInPage = self.storyboard?.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
        self.present(signInPage, animated: true, completion: nil)
        
    }
    
    @IBAction func getTextButtonPressed(_ sender: Any) {
        getText()
    }
    
    func getText(){
        let keychain = KeychainSwift()
        var accessToken: String? = keychain.get("access_token")
        
        var token = String()
        var dic = NSDictionary()
        let header = ["content-type": "application/x-www-form-urlencoded",
                      "Authorization" : "Bearer \(accessToken!)"]
        Alamofire.request("https://apiecho.cf/api/get/text/", method: .get, parameters: nil, encoding: URLEncoding.httpBody, headers: header).responseJSON { [weak self] (response) in
            guard let strongSelf = self else { return }
 
            if response.result.isSuccess{
                print(response)
                dic = (response.result.value as? NSDictionary)!
                if let data = dic["data"]as? String{
                    print(data)
                    self?.textFromInternetTextView.text = data
                    
                    strongSelf.charactersDict = strongSelf.stringToDict(data)
                    strongSelf.characters = Array(strongSelf.charactersDict.keys).sorted()
                    DispatchQueue.main.async {
                          strongSelf.tableView.reloadData()
                    }
                    }
                
                }
            }
        }
    func stringToDict(_ str:String) -> [Character:Int] {
        let letters = Array(str.uppercased())
        var dict = [Character:Int]()
        letters.forEach({ (letter) in
            if let numberOfChars = dict[letter]  {
                dict[letter] = numberOfChars + 1
            } else {
                dict[letter] = 1
            }
        })
        return dict
    }
    
    
    }

extension HomePageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "OccuranceCell", for: indexPath) as? OccuranceCell else {
            return UITableViewCell()
        }
        
        let char = characters[indexPath.row]
        let number : Int = charactersDict[char] ?? 0
        cell.configure("\"\(char)\" - \(number) times")
        print(cell.configure("\"\(char)\" - \(number) times"))
        return cell
    }
    
    
}


        
    


