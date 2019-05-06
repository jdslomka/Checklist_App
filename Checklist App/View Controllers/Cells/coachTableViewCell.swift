//
//  storyCellTableViewCell.swift
//  LNC Ministry App
//
//  Created by John Slomka on 2019-05-01.
//  Copyright © 2019 John Slomka. All rights reserved.
//

import UIKit

class coachTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var volunteerView: UITextView!
    @IBOutlet weak var questionsView: UITextView!
   
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
