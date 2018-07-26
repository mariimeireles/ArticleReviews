

final class Injector {
    
    private let articlesMapper: ArticlesMapper
    
    init(articlesMapper: ArticlesMapper) {
        self.articlesMapper = articlesMapper
    }
    
    func articlesViewModel() -> ArticlesViewModel {
        return ArticlesViewModel(webService: articlesWebService(), mapper: self.articlesMapper)
    }
    
    func articlesWebService() -> ArticlesWebServiceProtocol {
        return ArticlesWebService()
    }
}
