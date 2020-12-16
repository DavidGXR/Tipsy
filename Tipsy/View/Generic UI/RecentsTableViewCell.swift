//
//  RecentsTableViewCell.swift
//  Tipsy
//
//  Created by David Im on 12/14/20.
//

import UIKit

class RecentsTableViewCell: UITableViewCell {

    @IBOutlet weak var recentView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var locationImageView: UIImageView!
    @IBOutlet weak var locationName: UILabel!
    @IBOutlet weak var billAmountLabel: UILabel!
    @IBOutlet weak var numberOfPeopleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        recentView.layer.cornerRadius = recentView.frame.height / 8
        //billAmountLabel.font = UIFont(name: "Montserrat-Bold", size: 10)
    }
}
