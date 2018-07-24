

import RxSwift

protocol ArticleWebServiceProtocol: AnyObject {
    
    func getArticles() -> Observable<Article>
}
