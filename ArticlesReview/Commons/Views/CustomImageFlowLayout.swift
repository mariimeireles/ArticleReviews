

import UIKit

final class CustomImageFlowLayout: UICollectionViewFlowLayout {
    
    override init() {
        super.init()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }
    
    override var itemSize: CGSize {
        set {}
        
        get {
            let numberOfColumns: CGFloat = 2
            let imageWidth = (self.collectionView!.frame.width - (numberOfColumns - minimumInteritemSpacing)) / numberOfColumns
            return CGSize(width: imageWidth, height: imageWidth)
        }
    }
    
    func setupLayout() {
        minimumInteritemSpacing = 1
        minimumLineSpacing = 1
    }
}
