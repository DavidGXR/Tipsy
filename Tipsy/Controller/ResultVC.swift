//
//  ResultVC.swift
//  Tipsy
//
//  Created by David Im on 12/17/20.
//

import UIKit
import CoreData
import CoreLocation

protocol ResultVCProtocol: class {
    func addHistoryButtonTapped()
}

class ResultVC: UIViewController {
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var splitAndTip: UILabel!
    @IBOutlet weak var recalculateButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    
    var totalSplit:String?
    var splitInfo:String?
    weak var resultVCDelegate:ResultVCProtocol?
    
    private let dataStorage = DataStorage()
    private let locationManager = CLLocationManager()
    private var currentLocation:String?
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        customizeViews()
        checkLocationService()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        totalPrice.text = totalSplit
        splitAndTip.text = splitInfo
    }

    @IBAction func recalculateBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addHistoryButton(_ sender: UIButton) {
        saveDataAndDismiss()
    }
    
    private func customizeViews() {
        topView.backgroundColor                 = UIColor.universalGreen
        addButton.tintColor                     = UIColor.universalGreen
        addButton.layer.cornerRadius            = addButton.frame.height/2
        recalculateButton.layer.cornerRadius    = recalculateButton.frame.height/7
        recalculateButton.backgroundColor       = UIColor.universalGreen
        recalculateButton.contentEdgeInsets     = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    }
}

//MARK: - CoreData
extension ResultVC {
    private func saveDataAndDismiss() {
        dataStorage.addHistory(totalSplit: totalSplit ?? "0.00", splitInfo: splitInfo ?? "(NO INFO)", location: currentLocation ?? "UNKNOWN LOCATION")
        resultVCDelegate?.addHistoryButtonTapped()
        self.dismiss(animated: true, completion: nil)
    }
}

//MARK: - Location Delegate Methods
extension ResultVC: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            getLocationName(lati: location.coordinate.latitude, longti: location.coordinate.longitude)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        errorBox(title: "Location is Disabled", message: error.localizedDescription)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse: locationManager.requestLocation()
        case .denied: currentLocation = "UNKNOWN (LOCATION DENIED BY USER)"
        case .notDetermined: locationManager.requestWhenInUseAuthorization()
        case .restricted: currentLocation = "UNKNOWN (LOCATION IS RESTRICTED)"
        case .authorizedAlways: locationManager.requestLocation()
        default: locationManager.requestWhenInUseAuthorization()
        }
    }
}

//MARK: - Location Setup
extension ResultVC {
    
    private func checkLocationService() {
        if CLLocationManager.locationServicesEnabled() == true {
            setupLocationManager()
            checkLocationAuthorization()
        }else{
            currentLocation = "UNKNOWN LOCATION (LOCATION IS DISABLED)"
            saveDataAndDismiss()
        }
    }

    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
    }

    private func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse: locationManager.requestLocation()
        case .denied: currentLocation = "UNKNOWN (LOCATION DENIED BY USER)"
        case .notDetermined: locationManager.requestWhenInUseAuthorization()
        case .restricted: currentLocation = "UNKNOWN (LOCATION IS RESTRICTED)"
        case .authorizedAlways: locationManager.requestLocation()
        default: locationManager.requestWhenInUseAuthorization()
        }
    }
    
    private func getLocationName(lati: CLLocationDegrees, longti: CLLocationDegrees) {
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: lati, longitude: longti)
        geoCoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if let error = error {
                self.errorBox(title: "Oops", message: error.localizedDescription)
            }
            
            guard let placemark = placemarks?.first else { return }
            self.currentLocation = "\(placemark.name ?? "Unknown Street"), \(placemark.locality ?? "Unknown City"), \(placemark.country ?? "Unknown Country")"
        }
    }
    
    private func errorBox(title:String, message: String) {
        let alertBox = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertBox.addAction(okButton)
        present(alertBox, animated: true, completion: nil)
    }
}


