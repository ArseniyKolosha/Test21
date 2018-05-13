//
//  OccurenceCell.swift
//  Test2
//
//  Created by Ars on 13.05.2018.
//  Copyright © 2018 ArsenIT. All rights reserved.
//

import UIKit

class OccuranceCell: UITableViewCell {
    
    @IBOutlet weak private var characterLabel: UILabel?
    
    func configure(_ text:String) {
        self.characterLabel?.text = text
    }
}
