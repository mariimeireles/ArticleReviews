

import UIKit

final class GridCell: UICollectionViewCell {

    @IBOutlet private var articleImage: UIImageView!
    @IBOutlet private var likedMark: UIImageView!

    var articleEntity: ArticleEntity? {
        didSet {
            fillOutlets()
        }
    }

    static var nib: UINib {
        return UINib(nibName: GridCell.identifier, bundle: Bundle.main)
    }

    private func fillOutlets() {
        guard let articleEntity = articleEntity else { return }
        DispatchQueue.main.async {
            self.layer.borderWidth = 1
            self.layer.borderColor = UIColor.lightGray.cgColor
            self.articleImage.image = UIImage().load(data: articleEntity.image! as Data)
            if articleEntity.isLiked == true {
                self.likedMark.alpha = 1
            }
            else {
                self.likedMark.alpha = 0
            }
        }
    }
}
