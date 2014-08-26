//
//  saveData.swift
//  meinRabatt
//
//  Created by Oliver Rosner on 25.08.14.
//  Copyright (c) 2014 Schilum23. All rights reserved.
//

import UIKit
import CoreData

let link = "http://www.mein-rabatt.com/wsMeinRabatt_Qffbbyelitnjczyrxtvqkrpsihpyyfcrydmohul0.asmx/getShops"

class saveData: NSObject, XMLParserDelegate {
    
    let context = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
    let parser = XMLParser(url: NSURL(string: link))

    func saveInDataBase() {
        
        var fetchRequestMax = NSFetchRequest(entityName: "Updates")
        fetchRequestMax.fetchLimit = 1;
        fetchRequestMax.sortDescriptors = [NSSortDescriptor(key: "lastUpdate", ascending: false)]
        
        var lastUpdate: NSDate = NSDate()
        if context!.executeFetchRequest(fetchRequestMax, error: nil).count > 0 {
            lastUpdate = context!.executeFetchRequest(fetchRequestMax, error: nil).last as NSDate
        } else {
            lastUpdate = NSDate().dateByAddingTimeInterval(60*60*24*30)
        }
        
        let date:NSDate = NSDate()
        var diff = lastUpdate.timeIntervalSinceDate(NSDate())
        diff = diff / 60 / 60 / 24
        
        println("LastUpdate: \(lastUpdate) --> Jetzt: \(date) --> Diff: \(diff)")
        
        if diff > 4 {
        
        // XML Parsen
        parser.delegate = self
        parser.parse {}
            
            println("count: \(parser.objects.count)")
        
        // XML Daten durchgehen
        for obj in parser.objects {
            println("1")
            // Wenn Name und Bild vorhanden
            if obj["shopImageMediumMR"] != nil && obj["shopImageMediumMR"] != "" && (obj["shopName"] != "" || obj["shopKey"] != "") {
                
                var shopName: String{
                    if !(obj["shopName"]!.isEmpty) {
                        return obj["shopName"]!
                    } else {
                        return obj["shopKey"]!
                    }
                }
                
                // Prüfen ob Shop bereits eingetragen ist
                var existingShops = [Shops]()
                var fetchRequest = NSFetchRequest(entityName: "Shops")
                if context != nil {
                    
                    
                    fetchRequest.predicate = NSPredicate(format: "shopName = %@", shopName)
                    
                    existingShops = context!.executeFetchRequest(fetchRequest, error: nil) as [Shops]
                    
                }
                
                if existingShops.count == 0 {
                    var newShop = NSEntityDescription.insertNewObjectForEntityForName("Shops", inManagedObjectContext: self.context) as Shops
                    newShop.name = shopName
                    newShop.imageLink = getCleanImageURL(obj["shopImageMediumMR"]!)
                    newShop.image = NSData(contentsOfURL: NSURL(string: getCleanImageURL(obj["shopImageMediumMR"]!)))
                    self.context?.save(nil)
                }
                
            }
            
        }
        
        var newUpdate = NSEntityDescription.insertNewObjectForEntityForName("Updates", inManagedObjectContext: self.context) as Updates
        newUpdate.lastUpdate = NSDate()
        self.context?.save(nil)
        }
        
    }
    
    func XMLparserError(parser: XMLParser, error: String) {
        
        println(error)
        
    }
    
    func getCleanImageURL(imageURL: String) -> String {
        
        var imageURLClean:String = imageURL
        
        imageURLClean = imageURLClean.stringByReplacingOccurrencesOfString("\\", withString: "/", options: NSStringCompareOptions.LiteralSearch, range: nil)
        
        imageURLClean = imageURLClean.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        
        return imageURLClean
        
    }
   
}
