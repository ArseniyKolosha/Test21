//
//  OccurenceViewController.swift
//  Test2
//
//  Created by Ars on 13.05.2018.
//  Copyright © 2018 ArsenIT. All rights reserved.
//

import UIKit
import  KeychainSwift
import Alamofire

class OccurenceViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    //MARK: - Properties
    private var locale:String?
    var charactersDict = [Character:Int]()
    var characters = [Character]()
    let identifire = "OccuranceCell"
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 60
        createTable()
    }
    
    func createTable() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifire)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        view.addSubview(tableView)
    }
    
    //MARK: - Helpers methods
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
    
    func setLocale(_ locale:String) {
        self.locale = locale
        self.getText()
    }
    
    
    //MARK: - Getting text from network
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
                    
                    strongSelf.charactersDict = strongSelf.stringToDict(data)
                    strongSelf.characters = Array(strongSelf.charactersDict.keys).sorted()
                    DispatchQueue.main.async {
                        strongSelf.tableView.reloadData()
                    }
                }
                
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OccuranceCell", for: indexPath)
        
        let char = characters[indexPath.row]
        let number : Int = charactersDict[char] ?? 0
        cell.textLabel?.text = "\"\(char)\" - \(number) times"
        return cell
    }
    
}


