

import UIKit

final class GridView: UIView, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet private var gridContentView: UIView!
    @IBOutlet private var collectionView: UICollectionView!
    private var customImageFlowLayout: CustomImageFlowLayout!
    
    var articleEntities: [ArticleEntity]? {
        didSet {
            updateCollectionView()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        uiSetup()
    }
    
    private func uiSetup() {
        Bundle.main.loadNibNamed(GridView.identifier, owner: self, options: nil)
        addSubview(gridContentView)
        gridContentView.frame = self.bounds
    }
    
    private func updateCollectionView() {
        customImageFlowLayout = CustomImageFlowLayout()
        collectionView.collectionViewLayout = customImageFlowLayout
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(GridCell.nib, forCellWithReuseIdentifier: GridCell.identifier)
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let articleEntities = articleEntities else { return 0 }
        return articleEntities.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let articleEntities = articleEntities else { return UICollectionViewCell() }
        let articleEntity = articleEntities[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GridCell.identifier, for: indexPath) as? GridCell else { return UICollectionViewCell() }
        cell.articleEntity = articleEntity
        return cell
    }
}
