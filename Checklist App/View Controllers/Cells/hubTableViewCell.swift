//
//  hubTableViewCell.swift
//  LNC Ministry App
//
//  Created by John Slomka on 2019-05-04.
//  Copyright © 2019 John Slomka. All rights reserved.
//

import UIKit

class hubTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
      //  self.isSelected = false
        // Configure the view for the selected state
    }

}
