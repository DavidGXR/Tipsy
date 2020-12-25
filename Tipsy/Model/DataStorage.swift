//
//  CoreData.swift
//  Tipsy
//
//  Created by David Im on 12/21/20.
//

import Foundation
import UIKit
import CoreData

struct DataStorage {
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func saveData() {
        do {
            try context.save()
        }catch {
            print("Error saving data into persistent container")
        }
    }
    
    func readData() -> [History] {
        let callRequest: NSFetchRequest<History> = History.fetchRequest()
        var result = [History]()
        do{
            result = try context.fetch(callRequest)
        }catch{
            print("Error fetching data from persistent container")
        }
        return result
    }
    
    func getCoreDataDBPath() {
            let path = FileManager
                .default
                .urls(for: .applicationSupportDirectory, in: .userDomainMask)
                .last?
                .absoluteString
                .replacingOccurrences(of: "file://", with: "")
                .removingPercentEncoding

            print("Core Data DB Path :: \(path ?? "Not found")")
    }
}

extension DataStorage {
    private func getDate() -> String {
        let date              = Date()
        let formatter         = DateFormatter()
        formatter.dateFormat  = "dd/MM/yyyy"
        let currentDate       = formatter.string(from: date)
        
        return currentDate
    }
    
    private func getTime() -> String {
        let time              = Date()
        let formatter         = DateFormatter()
        formatter.dateFormat  = "h:mm a"
        formatter.amSymbol    = "AM"
        formatter.pmSymbol    = "PM"
        let currentTime       = formatter.string(from: time)
        
        return currentTime
    }
    
    func addHistory(totalSplit: String, splitInfo: String, location: String){
        let history                 = History(context: self.context)
        history.date                = getDate()
        history.time                = getTime()
        history.split               = totalSplit
        history.splitInformation    = splitInfo
        history.location            = location
        
        saveData()
    }
}
