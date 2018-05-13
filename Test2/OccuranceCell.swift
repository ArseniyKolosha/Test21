//
//  OccuranceCell.swift
//  
//
//  Created by Ars on 13.05.2018.
//

import UIKit

class OccuranceCell: UITableViewCell {

    @IBOutlet weak private var characterLabel: UILabel!
    
   
    
    func configure(_ text:String) {
        self.characterLabel?.text = text
    }

}
