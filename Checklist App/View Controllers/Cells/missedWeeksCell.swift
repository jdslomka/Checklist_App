//
//  missedWeeksCell.swift
//  LNC Ministry App
//
//  Created by John Slomka on 2019-05-04.
//  Copyright © 2019 John Slomka. All rights reserved.
//

import UIKit

class missedWeeksCell: UITableViewCell {

    @IBOutlet weak var weekLabel: UILabel!
    @IBOutlet weak var reasonLabel: UITextView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
