//
//  HomeVC.swift
//  Tipsy
//
//  Created by David Im on 12/17/20.
//

import UIKit
import CoreData

class HomeVC: UIViewController {

    @IBOutlet weak var billAmountTextField: UITextField!
    @IBOutlet weak var calcButton: UIButton!
    @IBOutlet weak var numberOfPeopleLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var recentTableView: UITableView!
    @IBOutlet weak var tipCollectionView: UICollectionView!
    
    private var calculator  = Calculator()
    private var dataStorage = DataStorage()
    private var tipButtonTitle = [Tip(title: "0%", status: false),
                                  Tip(title: "5%", status: false),
                                  Tip(title: "10%", status: false),
                                  Tip(title: "15%", status: false),
                                  Tip(title: "20%", status: false),
                                  Tip(title: "25%", status: false),]
    private var recents = [History]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customizeViews()
        validateTextField()
        getDataFromStorage()
    }
    
    private func customizeViews() {
        stepper.layer.cornerRadius                  = stepper.frame.height/7
        customizeCalculateButton(status: false)
        calcButton.layer.cornerRadius               = calcButton.frame.height/7
        calcButton.backgroundColor                  = UIColor.universalGreen
        billAmountTextField.attributedPlaceholder   = NSAttributedString(string: "e.g. 168.8", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        billAmountTextField.keyboardType            = .decimalPad
        billAmountTextField.layer.borderWidth       = 1.0
        billAmountTextField.layer.borderColor       = UIColor.white.cgColor
        billAmountTextField.layer.cornerRadius      = billAmountTextField.frame.height/10
    }
        
    @IBAction func stepperButtonTapped(_ sender: UIStepper) {
        numberOfPeopleLabel.text = String(format: "%.0f", sender.value)
        billAmountTextField.resignFirstResponder()
    }
    
    @IBAction func calculateButton(_ sender: UIButton) {
        if let bill = billAmountTextField.text, let numberOfPeople = numberOfPeopleLabel.text {
            calculator.calculateTip(billInput: bill, people: numberOfPeople)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == C.segueToResultVC {
            let resultVC        = segue.destination as! ResultVC
            resultVC.totalSplit = calculator.getSplit()
            resultVC.splitInfo  = calculator.splitInformation()
            resultVC.resultVCDelegate = self
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        billAmountTextField.resignFirstResponder()
    }
    
    //MARK: - Read Data from CoreData
    private func getDataFromStorage() {
        var revRecents = [History]()
        dataStorage.getCoreDataDBPath()
        revRecents.append(contentsOf: dataStorage.readData())
        recents = revRecents.reversed()
    }
}

//MARK: - Recent TableView
extension HomeVC:UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let recentCell = tableView.dequeueReusableCell(withIdentifier: C.recentsCell) as! RecentsTableViewCell
        recentCell.dateLabel.text           = recents[indexPath.row].date
        recentCell.timeLabel.text           = recents[indexPath.row].time
        recentCell.locationName.text        = recents[indexPath.row].location
        recentCell.billAmountLabel.text     = recents[indexPath.row].split
        recentCell.numberOfPeopleLabel.text = recents[indexPath.row].splitInformation
        
        return recentCell
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
        let width = (self.view.bounds.size.width/3)-10
        return CGSize(width: width, height: 60)
    }
    
    func tipButtonTap(indexPath: [IndexPath], index:Int, tipButton: UIButton, sender:UIButton) {
        tipButtonTitle[index].status = true
        calculator.getTip(inputTip: tipButton.currentTitle ?? "0%")
        for element in 0...(tipButtonTitle.count-1) {
            if (element != index){
                tipButtonTitle[element].status = false
            }
        }
        tipCollectionView.reloadSections(IndexSet(integer: 0))
    }
}

//MARK: - TextField Validation
extension HomeVC {
    private func validateTextField() {
        billAmountTextField.addTarget(self, action: #selector(emptyTextFieldCheck), for: .editingChanged)
    }
    
    @objc private func emptyTextFieldCheck() {
        if let bill = billAmountTextField.text, !bill.isEmpty {
            customizeCalculateButton(status: true)
        }else{
            customizeCalculateButton(status: false)
        }
    }
    
    private func customizeCalculateButton(status: Bool) {
        if status == true {
            calcButton.isUserInteractionEnabled = true
            calcButton.alpha = 1
        }else{
            calcButton.isUserInteractionEnabled = false
            calcButton.alpha = 0.5
        }
    }
}

//MARK: - ResultVCProtocol
extension HomeVC:ResultVCProtocol {
    func addHistoryButtonTapped() {
        getDataFromStorage()
        recentTableView.reloadData()
    }
}
