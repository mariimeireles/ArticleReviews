

import Foundation
import CoreData


extension ArticleEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ArticleEntity> {
        return NSFetchRequest<ArticleEntity>(entityName: "ArticleEntity")
    }

    @NSManaged public var image: NSData?
    @NSManaged public var isLiked: Bool
    @NSManaged public var isReviewed: Bool
    @NSManaged public var sku: String?
    @NSManaged public var title: String?

}
