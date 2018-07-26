

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
        let sku = articleModel.sku
        let fetchRequest = fetchRequestWith(sku: sku)
        do {
            let count = try PersistenceService.context.count(for: fetchRequest)
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
    
    func fetchRequestWith(sku: String) -> NSFetchRequest<ArticleEntity> {
        let fetchRequest: NSFetchRequest<ArticleEntity> = ArticleEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "sku == %@", sku)
        fetchRequest.fetchLimit = 1
        return fetchRequest
    }
    
    private func retriveEntitiesFromCoreData() -> ArticlesScreenState {
        let fetchRequest: NSFetchRequest<ArticleEntity> = ArticleEntity.fetchRequest()
        do {
            let articleEntities = try PersistenceService.context.fetch(fetchRequest)
            return checkForReviewedArticles(articleEntities)
        } catch {
            return ArticlesScreenState.failure(.unknown)
        }
    }
    
    func checkForReviewedArticles(_ articleEntities: [ArticleEntity]) -> ArticlesScreenState {
        let articles = articleEntities.filter { $0.isReviewed == false }
        let likedArticles = articleEntities.filter { $0.isLiked == true }
        if articles.isEmpty {
            return ArticlesScreenState.successWithNoNewArticles(articleEntities.count, likedArticles.count)
        } else {
            return ArticlesScreenState.success(articles, articleEntities.count, likedArticles.count)
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
