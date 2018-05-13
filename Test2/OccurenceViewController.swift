//
//  OccurenceViewController.swift
//  Test2
//
//  Created by Ars on 13.05.2018.
//  Copyright © 2018 ArsenIT. All rights reserved.
//

import UIKit

class OccurenceViewController: UIViewController {

    
    //MARK: - Properties
    private var locale:String?
    var charactersDict = [Character:Int]()
    var characters = [Character]()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 60
        tableView.tableFooterView = UIView()
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
        self.loadText()
    }
    
    //MARK: - Networking
    func loadText() {
        guard let currentLocale = locale else { return }
        
        NetworkText.sharedManager.getText(for: currentLocale) { [weak self] (jsonResponse) in
            guard let strongSelf = self else { return }
            
            guard let response = jsonResponse as? NSDictionary, let str = response["data"] as? String else {
                guard let response = jsonResponse as? NSDictionary, let errors = response["errors"] as? [Any] else {
                    return
                }
                
               // let alert = AlertHandler.sharedManager.makeAlert(withErrors: errors)
                // strongSelf.present(alert, animated: true, completion: nil)
                return
            }
            print(str)
            strongSelf.charactersDict = strongSelf.stringToDict(str)
            strongSelf.characters = Array(strongSelf.charactersDict.keys).sorted()
            DispatchQueue.main.async {
                strongSelf.tableView.reloadData()
            }
        }
    }
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension OccurenceViewController: UITableViewDelegate, UITableViewDataSource {
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
        return cell
    }
    
    
}
