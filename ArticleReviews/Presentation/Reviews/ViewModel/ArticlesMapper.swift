

import CoreData
import Foundation
import UIKit

final class ArticlesMapper {
    
    func mapArticlesRequestToSuccessState(_ article: Article) throws -> ArticlesScreenState {
        let articles = try article.embedded.articles.map {
            try ArticleModel(articles: $0)
        }
        for article in articles {
            try checkEntitiesInCoreData(article)
        }
        return retriveEntitiesFromCoreData()
    }
    
    private func checkEntitiesInCoreData(_ articleModel: ArticleModel) throws {
        let fetchRequest: NSFetchRequest<ArticleEntity> = ArticleEntity.fetchRequest()
        let sku = articleModel.sku
        fetchRequest.predicate = NSPredicate(format: "sku == %@", sku)
        fetchRequest.fetchLimit = 1
        do {
            let count = try PersistenceService.context.count(for: fetchRequest)
            if count == NSNotFound {
                throw ServiceError.internalServerError
            }
            if count == 0 {
                let articleEntity = ArticleEntity(context: PersistenceService.context)
                articleEntity.image = UIImagePNGRepresentation(articleModel.image) as NSData?
                articleEntity.isLiked = false
                articleEntity.isReviewed = false
                articleEntity.sku = articleModel.sku
                articleEntity.title = articleModel.title
                PersistenceService.saveContext()
            }
        } catch {
            throw ServiceError.internalServerError
        }
    }
    
    private func retriveEntitiesFromCoreData() -> ArticlesScreenState {
        let fetchRequest: NSFetchRequest<ArticleEntity> = ArticleEntity.fetchRequest()
        do {
            let articleEntity = try PersistenceService.context.fetch(fetchRequest)
            return ArticlesScreenState.success(articleEntity)
        } catch {
            return ArticlesScreenState.failure(.unknown)
        }
    }
    
    func mapErrorToScreenState(_ error: Error) -> ArticlesScreenState {
        guard let serviceError = error as? ServiceError else {
            return ArticlesScreenState.failure(.unknown)
        }
        switch serviceError {
        case let .rest(error):
            return ArticlesScreenState(restError: error)
        case let .connection(error):
            switch error {
            case .noConnection:
                return ArticlesScreenState.failure(.noConnection)
            case .timeOut:
                return ArticlesScreenState.failure(.timeOut)
            default:
                return ArticlesScreenState.failure(.unknown)
            }
        case .internalServerError:
            return ArticlesScreenState.failure(.serverError)
        default:
            return ArticlesScreenState.failure(.unknown)
        }
    }
}
