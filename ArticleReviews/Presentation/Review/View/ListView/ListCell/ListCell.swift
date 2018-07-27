

import UIKit

final class ListCell: UITableViewCell {
    
    @IBOutlet private var articleImage: UIImageView!
    @IBOutlet private var articleTitle: UILabel!
    @IBOutlet private var likedMark: UIImageView!
    
    var articleEntity: ArticleEntity? {
        didSet {
            fillOutlets()
        }
    }
    
    static var nib: UINib {
        return UINib(nibName: ListCell.identifier, bundle: Bundle.main)
    }
    
    private func fillOutlets() {
        guard let articleEntity = articleEntity else { return }
        DispatchQueue.main.async {
            self.articleImage.image = UIImage().load(data: articleEntity.image! as Data)
            self.articleTitle.text = articleEntity.title
            if articleEntity.isLiked == true {
                self.likedMark.alpha = 1
            }
            else {
                self.likedMark.alpha = 0
            }
        }
    }
}
