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
    @IBOutlet weak var addButton: UIButton!
    
    var totalSplit:String?
    var splitInfo:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        customizeViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        totalPrice.text = totalSplit
        splitAndTip.text = splitInfo
    }

    @IBAction func recalculateBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addHistoryButton(_ sender: UIButton) {
    }
    
    private func customizeViews() {
        topView.backgroundColor = UIColor.universalGreen
        addButton.tintColor = UIColor.universalGreen
        addButton.layer.cornerRadius = addButton.frame.height/2
        recalculateButton.layer.cornerRadius = recalculateButton.frame.height/7
        recalculateButton.backgroundColor = UIColor.universalGreen
        recalculateButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    }
    
    

}

