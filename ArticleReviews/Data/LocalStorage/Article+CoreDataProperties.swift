

import Foundation
import CoreData


extension Article {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Article> {
        return NSFetchRequest<Article>(entityName: "Article")
    }

    @NSManaged public var sku: String?
    @NSManaged public var image: NSData?
    @NSManaged public var title: String?
    @NSManaged public var isLiked: Bool
    @NSManaged public var isRevied: Bool

}
