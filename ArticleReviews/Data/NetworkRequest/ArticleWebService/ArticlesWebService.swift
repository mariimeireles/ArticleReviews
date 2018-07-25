

import Alamofire
import Foundation
import RxAlamofire
import RxSwift

final class ArticleWebService: ArticlesWebServiceProtocol {
    
    private let getUrl = "https://api-mobile.home24.com/api/v2.0/categories/100/articles?appDomain=1&locale=de_DE&limit=10%E2%80%9D"
    
    func getArticles() -> Observable<Article> {
        let decoder = JSONDecoder()
        let infraHandler = InfrastructureHandler()
        let internetHandler = InternetConnectionHandler()
        
        return RxAlamofire.requestJSON(.get, getUrl)
            .do(onNext: { response, _ in
                try infraHandler.verifyStatusCode(response)
            })
            .do(onError: { error in
                try internetHandler.verifyConnection(error)
            })
            .map({ (_, result) -> Article in
                guard let data = try? JSONSerialization.data(withJSONObject: result, options: []) else { throw ServiceError.jsonParse }
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                return try decoder.decode(Article.self, from: data)
            })
    }
}
