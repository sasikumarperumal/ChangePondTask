//
//  CoreDataManagement.swift
//  ChangePondTask
//
//  Created by Sasikumar Perumal on 21/02/22.
//

import Foundation
import CoreData
import UIKit

class CoreDataManagement: NSObject {
    
    static let shared: CoreDataManagement = CoreDataManagement()
    
    //Reference to Managed object context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var hitsData: [NewsEntity]?
    
    var newsFeeds = [Hits]()
    func fetchDeviceData() {
        do {
            self.hitsData = try context.fetch(NewsEntity.fetchRequest())
            print("~~~LocalData Fetched deviceDatas: \(self.formDeviceDataUpdateRequest(data: self.hitsData ?? []))")
            
            newsFeeds = self.formDeviceDataUpdateRequest(data: self.hitsData ?? [])
            
            //            if self.hitsData?.count ?? 0 > 0 {
            //                if let firstData = deviceDatas?.last {
            //                    print("~~~LocalData updating data: \(firstData)")
            //                    self.updateDeviceDataToServer(request: self.formDeviceDataUpdateRequest(data: firstData), deviceData: firstData)
            //                }
            //            } else {
            //                print("~~~LocalData No data Avaialbe to update")
            //            }
        } catch {
            print("~~~LocalData Error in Fetch: \(error)")
        }
    }
    
    func formDeviceDataUpdateRequest(data: [NewsEntity]) -> [Hits] {
        
        var arrayOfHits = [Hits]()
        for hit in data {
            let request = Hits(created_at: hit.created_at, title: hit.title, author: hit.author, points: hit.points, comment_text: hit.comment_text)
            arrayOfHits.append(request)
        }
        print("~~~LocalData Formed request: \(arrayOfHits)")

        return arrayOfHits
        
        
       
    }
    
    func saveContext() {
        print("~~~LocalData Save Context")
        if self.context.hasChanges {
            do {
                try self.context.save()
                print("~~~LocalData Save Context has changes")
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("~~~LocalData Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func saveDeviceData(data: [Hits]) {
        
        
        for hits in data {
            
            let histData = NewsEntity(context: self.context)
            
            histData.created_at = hits.created_at
            histData.title = hits.title
            histData.author = hits.author
            histData.points = hits.points ?? 0
            histData.comment_text = hits.comment_text
            
            self.saveContext()
            
        }
        
        fetchDeviceData()
        
    }
    
}
