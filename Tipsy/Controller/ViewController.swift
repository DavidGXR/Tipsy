//
//  ViewController.swift
//  Tipsy
//
//  Created by David Im on 12/12/20.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var billAmountTextField: UITextField!
    @IBOutlet weak var calcButton: UIButton!
    @IBOutlet weak var numberOfPeople: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var recentsTableView: UITableView!
    @IBOutlet weak var tipCollectionView: UICollectionView!
    
    private let tipButtonTitle = ["0%", "5%", "10%", "15%", "20%", "25%"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeViews()
        
    }

    private func customizeViews() {
        stepper.layer.cornerRadius = stepper.frame.height/7
        calcButton.layer.cornerRadius = calcButton.frame.height/7
        
        billAmountTextField.attributedPlaceholder = NSAttributedString(string: "e.g. 168.8", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        billAmountTextField.keyboardType = .decimalPad
        billAmountTextField.layer.borderWidth = 1.0
        billAmountTextField.layer.borderColor = UIColor.white.cgColor
        billAmountTextField.layer.cornerRadius = billAmountTextField.frame.height/10
    }
        
    @IBAction func stepper(_ sender: UIStepper) {
        numberOfPeople.text = String(format: "%.0f", sender.value)
    }
    
    @IBAction func calculateButton(_ sender: UIButton) {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        billAmountTextField.resignFirstResponder()
    }
    
}

//MARK: - Recent TableView
extension ViewController:UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recentCell") as! RecentsTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

//MARK: - Tip CollectionView
extension ViewController:UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tipButtonTitle.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let tipCell = collectionView.dequeueReusableCell(withReuseIdentifier: "tipCell", for: indexPath) as! TipCollectionViewCell
        tipCell.tipButton.setTitle(tipButtonTitle[indexPath.row], for: .normal)
        
        return tipCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.view.bounds.size.width/3
        return CGSize(width: width, height: 60)
    }
}

