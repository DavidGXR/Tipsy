//
//  TipCollectionViewCell.swift
//  Tipsy
//
//  Created by David Im on 12/15/20.
//

import UIKit

protocol TipCollectionViewProtocol: class {
    func tipButtonTap(indexPath: [IndexPath], index:Int, tipButton:UIButton, sender:UIButton)
}

class TipCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var tipButton: UIButton!
    
    var indexPath:[IndexPath]?
    var index:Int?
    weak var tipCollectionViewDelegation:TipCollectionViewProtocol?
    
    override func awakeFromNib() {
    }
    
    @IBAction func tipButtonTap(_ sender: UIButton) {
        tipCollectionViewDelegation?.tipButtonTap(indexPath: indexPath!, index: index ?? 0, tipButton: tipButton, sender: sender)
    }
}
