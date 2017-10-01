//
//  AlertCell.swift
//  Relief-App
//
//  Created by Steven Hurtado on 9/30/17.
//  Copyright © 2017 Steven Hurtado. All rights reserved.
//

import UIKit

class AlertCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    @IBOutlet weak var contentCell: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentCell.layer.shadowColor = UIColor.black.cgColor
        self.contentCell.layer.shadowOffset = CGSize(width: 10, height: 10)
        self.contentCell.layer.shadowRadius = 10
        self.contentCell.layer.cornerRadius = 10
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
