

import Foundation
import UIKit

final class ReviewsModel {
    
    let sku: String
//    let image: UIImage
    let title: String
    var isLiked = false
    var isRevied = false
    
    init(reviews: Articles.ArticlesDetails) {
        sku = reviews.sku
        title = reviews.title
    }
}
