

import RxSwift

protocol ArticlesWebServiceProtocol: AnyObject {
    
    func getArticles() -> Observable<Article>
}
