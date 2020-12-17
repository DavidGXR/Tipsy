//
//  ResultVC.swift
//  Tipsy
//
//  Created by David Im on 12/17/20.
//

import UIKit

class ResultVC: UIViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var splitAndTip: UILabel!
    @IBOutlet weak var recalculateButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        customizeViews()
    }
    
    @IBAction func recalculateBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    private func customizeViews() {
        topView.backgroundColor = UIColor.universalGreen
        recalculateButton.layer.cornerRadius = recalculateButton.frame.height/7
        recalculateButton.backgroundColor = UIColor.universalGreen
        recalculateButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    }
    
}
