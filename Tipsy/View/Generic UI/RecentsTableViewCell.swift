//
//  RecentsTableViewCell.swift
//  Tipsy
//
//  Created by David Im on 12/14/20.
//

import UIKit
import SwipeCellKit

class RecentsTableViewCell: SwipeTableViewCell {

    @IBOutlet weak var recentView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var locationImageView: UIImageView!
    @IBOutlet weak var locationName: UILabel!
    @IBOutlet weak var billAmountLabel: UILabel!
    @IBOutlet weak var numberOfPeopleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        recentView.backgroundColor = UIColor.recentsTableViewBackground
        recentView.layer.cornerRadius = recentView.frame.height / 8
        dateLabel.textColor = UIColor.universalYellow
        timeLabel.textColor = UIColor.universalYellow
        billAmountLabel.adjustsFontSizeToFitWidth = true
    }
}
