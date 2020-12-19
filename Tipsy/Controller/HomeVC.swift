//
//  HomeVC.swift
//  Tipsy
//
//  Created by David Im on 12/17/20.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var billAmountTextField: UITextField!
    @IBOutlet weak var calcButton: UIButton!
    @IBOutlet weak var numberOfPeopleLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var recentTableView: UITableView!
    @IBOutlet weak var tipCollectionView: UICollectionView!
    
    private var tipButtonTitle = [Tip(title: "0%", status: false),
                                  Tip(title: "5%", status: false),
                                  Tip(title: "10%", status: false),
                                  Tip(title: "15%", status: false),
                                  Tip(title: "20%", status: false),
                                  Tip(title: "25%", status: false),]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeViews()
        
    }
    
    deinit {
        print("HomeVC deinit")
    }

    private func customizeViews() {
        stepper.layer.cornerRadius = stepper.frame.height/7
        calcButton.layer.cornerRadius = calcButton.frame.height/7
        calcButton.backgroundColor = UIColor.universalGreen
        billAmountTextField.attributedPlaceholder = NSAttributedString(string: "e.g. 168.8", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        billAmountTextField.keyboardType = .decimalPad
        billAmountTextField.layer.borderWidth = 1.0
        billAmountTextField.layer.borderColor = UIColor.white.cgColor
        billAmountTextField.layer.cornerRadius = billAmountTextField.frame.height/10
    }
        
    @IBAction func stepperButtonTapped(_ sender: UIStepper) {
        numberOfPeopleLabel.text = String(format: "%.0f", sender.value)
    }
    
    @IBAction func calculateButton(_ sender: UIButton) {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        billAmountTextField.resignFirstResponder()
    }
    
}

//MARK: - Recent TableView
extension HomeVC:UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: C.recentsCell) as! RecentsTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

//MARK: - Tip CollectionView
extension HomeVC:UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, TipCollectionViewProtocol {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tipButtonTitle.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let tipCell = collectionView.dequeueReusableCell(withReuseIdentifier: C.tipCell, for: indexPath) as! TipCollectionViewCell
        tipCell.tipButton.setTitle(tipButtonTitle[indexPath.row].title, for: .normal)
        tipCell.tipButton.backgroundColor = tipButtonTitle[indexPath.row].status ? UIColor.universalGreen : UIColor.black
        
        tipCell.indexPath = [indexPath]
        tipCell.index = indexPath.row
        tipCell.tipCollectionViewDelegation = self
        
        return tipCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.view.bounds.size.width/3) 
        return CGSize(width: width, height: 60)
    }
    
    func tipButtonTap(indexPath: [IndexPath], index:Int) {
        if tipButtonTitle[index].status == false {
            tipButtonTitle[index].status = true
            tipCollectionView.reloadItems(at: indexPath)
        }else{
            tipButtonTitle[index].status = false
            tipCollectionView.reloadItems(at: indexPath)
        }
    }

}
