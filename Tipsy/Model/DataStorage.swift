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
    
    func readData(getAll: Bool, allElementsCount: Int = 0) -> [History] {
        let callRequest: NSFetchRequest<History> = History.fetchRequest()
        var result = [History]()
        
        if getAll {
            do{
                result = try context.fetch(callRequest)
                
            }catch{
                print("Error fetching data from persistent container")
            }
        } else {
            do{
                callRequest.fetchLimit = 1
                callRequest.fetchOffset = allElementsCount - 1 // it means skip the amount of (allElementsCount - 1) count from top
                result = try context.fetch(callRequest)
                
            }catch{
                print("Error fetching data from persistent container")
            }
        }
        return result
    }
    
    func deleteData(dataToBeDeleted: History) {
        context.delete(dataToBeDeleted)
        saveData()
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
        formatter.dateFormat  = "h:mm:ss a"
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
