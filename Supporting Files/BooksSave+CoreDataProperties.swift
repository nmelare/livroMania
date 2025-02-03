//
//  Books+CoreDataProperties.swift
//  LivroMania
//
//  Created by Nathalia Melare on 05/09/24.
//
//

import Foundation
import CoreData


extension BooksSave {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BooksSave> {
        return NSFetchRequest<BooksSave>(entityName: "BooksSave")
    }

    @NSManaged public var title: String?
    @NSManaged public var subtitle: String?
    @NSManaged public var author: String?
    @NSManaged public var publishedDate: String?
    @NSManaged public var image: String?
    @NSManaged public var pageCount: String?
    @NSManaged public var publisher: String?
    @NSManaged public var mainCategory: String?
    @NSManaged public var bookDescription: String?
    @NSManaged public var value: String?
    @NSManaged public var id: String?

}
