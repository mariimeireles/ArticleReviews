

import Foundation
import UIKit
import CoreData

final class ReviewsMapper {
    
    private func checkEntitiesInCoreData(_ articleModel: ArticleModel) throws {
        let fetchRequest: NSFetchRequest<Article> = Article.fetchRequest()
        let sku = articleModel.sku
        fetchRequest.predicate = NSPredicate(format: "sku == %@", sku)
        fetchRequest.fetchLimit = 1
        do {
            let count = try PersistenceService.context.count(for: fetchRequest)
            if count == NSNotFound {
                throw ServiceError.internalServerError
            }
            if count == 0 {
                let articleEntity = Article(context: PersistenceService.context)
//                articleEntity.image =
                articleEntity.isLiked = false
                articleEntity.isRevied = false
                articleEntity.sku = articleModel.sku
                articleEntity.title = articleModel.title
                PersistenceService.saveContext()
            }
        } catch {
            throw ServiceError.internalServerError
        }
    }
}
