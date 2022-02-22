//
//  CoreDataManagement.swift
//  ChangePondTask
//
//  Created by Sasikumar Perumal on 20/02/22.
//

import Foundation
import CoreData
import UIKit

// MARK:- API Class
class CoreDataManagement: NSObject {
    
    static let shared: CoreDataManagement = CoreDataManagement()
    
    //Reference to Managed object context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var hitsData: [NewsEntity]?
    
    var newsData = [Hits]()
     
    // MARK:- fetchDataDetails
    
    func fetchDataDetails() -> [Hits]? {
        do {
            self.hitsData = try context.fetch(NewsEntity.fetchRequest())
            newsData = self.formCoreDataDetails(data: self.hitsData ?? [])
            return newsData

        } catch {
            print("~~~LocalData Error in Fetch: \(error)")
        }
        
        return [Hits]()
    }
    
    // MARK:- Delete Data Details
    func delete() {
        if let result = try? context.fetch(NewsEntity.fetchRequest()) {
            for object in result {
                context.delete(object)
            }
        }
        do {
            try context.save()
        } catch {
            //Handle error
        }
    }
    
    // MARK:- form CoreData Details
    
    func formCoreDataDetails(data: [NewsEntity]) -> [Hits] {
        
        var arrayOfHits = [Hits]()
        for hit in data {
            let request = Hits(created_at: hit.created_at, title: hit.title, author: hit.author, points: hit.points, comment_text: hit.comment_text, url: hit.url, relevancy_score: hit.relevancy_score)
            arrayOfHits.append(request)
        }
        return arrayOfHits
        
        
       
    }
    
    // MARK:- Save Context Func
    
    func saveContext() {
        if self.context.hasChanges {
            do {
                try self.context.save()
            } catch {
                let nserror = error as NSError
            }
        }
    }
    
    // MARK:- Save Details From CoreData
    
    func saveResponseToCoreData(data: [Hits]) {
        
        
        for hits in data {
            
            let histData = NewsEntity(context: self.context)
            
            histData.created_at = hits.created_at
            histData.title = hits.title
            histData.author = hits.author
            histData.points = hits.points ?? 0
            histData.comment_text = hits.comment_text
            histData.url = hits.url
            histData.relevancy_score = hits.relevancy_score ?? 0
            
            self.saveContext()
            
        }
    }
    
}
