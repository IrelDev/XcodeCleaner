//
//  CoreDataManager.swift
//  XcodeCleaner
//
//  Created by Kirill Pustovalov on 08.07.2020.
//  Copyright © 2020 Kirill Pustovalov. All rights reserved.
//

import AppKit
import CoreData

struct CoreDataManager {
    static let shared = CoreDataManager()
    
    func getStatistic() -> StatisticModel {
        var statisticModel = StatisticModel()
        fetchStatisticIn(statisticModel: &statisticModel)
        
        return statisticModel
    }
    func saveStatistic(statistic: StatisticModel) {
        let newTotalCleanedValue = statistic.totalCleaned
        let newDate = statistic.lastTimeCleaned
        
        saveStatistic(newValue: newTotalCleanedValue, newDate: newDate)
    }
    private func fetchStatisticIn(statisticModel: inout StatisticModel) {
        guard let appDelegate = NSApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "StatisticEntity")
        
        do {
            let fetchRequestResults = try managedContext.fetch(fetchRequest)
            
            let totalCleaned = fetchRequestResults.first?.value(forKey: "totalSize") as? Int64
            let date = fetchRequestResults.first?.value(forKey: "date") as? Date
            
            let modelFromFetchRequest = StatisticModel(totalCleaned: totalCleaned, lastTimeCleaned: date)
            statisticModel = modelFromFetchRequest
            
        } catch {
            print("could not fetch statistic \(error.localizedDescription)")
        }
    }
    private func saveStatistic(newValue: Int64?, newDate: Date?) {
        guard let appDelegate = NSApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "StatisticEntity", in: managedContext)!
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "StatisticEntity")
        
        do {
            let fetchRequestResults = try managedContext.fetch(fetchRequest)
            if fetchRequestResults.count == 0 {
                let statistic = NSManagedObject(entity: entity, insertInto: managedContext)
                
                statistic.setValue(newValue, forKeyPath: "totalSize")
                statistic.setValue(newDate, forKeyPath: "date")
            } else {
                let previousStatistic = fetchRequestResults.first!
                
                let previousTotalSizeValue = previousStatistic.value(forKey: "totalSize") as! Int64
                let value = (newValue ?? 0) + previousTotalSizeValue
                
                previousStatistic.setValue(newDate, forKey: "date")
                previousStatistic.setValue(value, forKey: "totalSize")
            }
            
            try managedContext.save()
        } catch {
            print("Error, could not save statistic \(error.localizedDescription)")
        }
    }
}

