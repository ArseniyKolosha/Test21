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
import KeychainSwift

class ViewController: UIViewController {

    @IBOutlet weak var textFromDataTextView: UITextView!
    
    //MARK: - Properties
    private var locale:String?
    var charactersDict = [Character:Int]()
    var characters = [Character]()
    
    @IBOutlet weak var tableView : UITableView!
    
    //MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 60
        tableView.tableFooterView = UIView()
    }
    
    
    
   
    @IBAction func countCharactersBtnPressed(_ sender: Any) {
        countCharacters()
    }
    
    func countCharacters () {
        
        let localStr = " ";
        let counter = textFromDataTextView.text.components(separatedBy: localStr);
        var counterMatch = 0
        counterMatch += (counter.count - 1);
        print("Space - \(counterMatch)")
    }
    
    
}

