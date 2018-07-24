

import Foundation
import UIKit

final class ArticleModel {
    
    let sku: String
    let title: String
    var image: UIImage
//    var isLiked = false
//    var isRevied = false
    
    init(articles: Article.ArticlesDetails) throws {
        sku = articles.sku
        title = articles.title
        let firstImage = articles.media[0].uri
        guard let url = URL(string: firstImage) else { throw ServiceError.internalServerError }
        image = UIImage().load(url: url)
    }
}
