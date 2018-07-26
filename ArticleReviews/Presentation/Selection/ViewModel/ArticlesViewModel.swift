

import CoreData
import RxSwift

final class ArticlesViewModel {
    
    private let webService: ArticlesWebServiceProtocol
    private let mapper: ArticlesMapper
    
    init(webService: ArticlesWebServiceProtocol, mapper: ArticlesMapper) {
        self.webService = webService
        self.mapper = mapper
    }
    
    func requestArticles() -> Observable<ArticlesScreenState> {
        return getScreenStateWith()
            .startWith(.loading)
    }
    
    private func getScreenStateWith() -> Observable<ArticlesScreenState> {
        return self.webService.getArticles()
            .map { [unowned self] articles in
                try self.mapper.mapArticlesRequestToSuccessState(articles)
            }
            .catchError { [unowned self] (error) -> Observable<ArticlesScreenState> in
                let state = self.mapper.mapErrorToScreenState(error)
                return Observable.just(state)
            }
    }
    
    func updateCoreData(sku: String, isLiked: Bool) {
        let fetchRequest = mapper.fetchRequestWith(sku: sku)
        do {
            let articleEntities = try PersistenceService.context.fetch(fetchRequest)
            for entity in articleEntities {
                entity.isLiked = isLiked
                entity.isReviewed = true
                PersistenceService.saveContext()
            }
        } catch {
            fatalError()
        }
    }
}
