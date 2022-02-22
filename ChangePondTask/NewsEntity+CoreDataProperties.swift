//
//  NewsEntity+CoreDataProperties.swift
//  ChangePondTask
//
//  Created by Sasikumar Perumal on 21/02/22.
//
//

import Foundation
import CoreData


extension NewsEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NewsEntity> {
        return NSFetchRequest<NewsEntity>(entityName: "NewsEntity")
    }

    @NSManaged public var author: String?
    @NSManaged public var comment_text: String?
    @NSManaged public var created_at: String?
    @NSManaged public var points: Int16
    @NSManaged public var relevancy_score: Int16
    @NSManaged public var title: String?

}

extension NewsEntity : Identifiable {

}
