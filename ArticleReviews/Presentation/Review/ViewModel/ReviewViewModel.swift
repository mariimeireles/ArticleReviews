

import CoreData
import Foundation

final class ReviewViewModel {

    func retriveReviewedArticlesFromCoreData() -> ReviewScreenState {
        let fetchRequest: NSFetchRequest<ArticleEntity> = ArticleEntity.fetchRequest()
        do {
            let articleEntities = try PersistenceService.context.fetch(fetchRequest)
            return ReviewScreenState.success(articleEntities)
        } catch {
            return ReviewScreenState.failure
        }
    }
}
