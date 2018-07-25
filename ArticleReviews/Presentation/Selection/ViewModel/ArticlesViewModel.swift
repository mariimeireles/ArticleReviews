

import RxSwift

final class ArticlesViewModel {
    
    private let webService: ArticleWebServiceProtocol
    private let mapper: ArticlesMapper
    
    init(webService: ArticleWebServiceProtocol, mapper: ArticlesMapper) {
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

}
