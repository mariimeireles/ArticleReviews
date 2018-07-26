

import UIKit

protocol SelectionViewDelegate: class {
    func endOfIndex()
    func articleLiked()
}

final class SelectionView: UIView {

    @IBOutlet private var selectionContentView: UIView!
    @IBOutlet private var articleImage: UIImageView!
    @IBOutlet private var likeButton: UIButton!
    @IBOutlet private var dislikeButton: UIButton!
    weak var delegate: SelectionViewDelegate?
    private var index = 0
    var viewModel: ArticlesViewModel?
    var articleEntities: [ArticleEntity]? {
        didSet {
            fillOutlets()
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        uiSetup()
    }

    private func uiSetup() {
        Bundle.main.loadNibNamed(SelectionView.identifier, owner: self, options: nil)
        addSubview(selectionContentView)
        selectionContentView.frame = self.bounds
    }
    
    private func fillOutlets() {
        guard let articleEntities = articleEntities else { return }
        DispatchQueue.main.async {
            self.articleImage.image = UIImage().load(data: articleEntities[self.index].image! as Data)
        }
    }
    
    @IBAction private func likeButton(_ sender: Any) {
        delegate?.articleLiked()
        updateCoreData(isLiked: true)
        changeIndex()
    }
    
    @IBAction private func dislikeButton(_ sender: Any) {
        updateCoreData(isLiked: false)
        changeIndex()
    }
    
    private func changeIndex() {
        guard let articleEntities = articleEntities else { return }
        let arraySize = articleEntities.count
        if index < arraySize - 1 {
            index += 1
            fillOutlets()
        } else {
            delegate?.endOfIndex()
        }
    }
    
    private func updateCoreData(isLiked: Bool) {
        guard let articleEntities = articleEntities else { return }
        guard let viewModel = viewModel else { return }
        guard let sku = articleEntities[index].sku else { return }
        viewModel.updateCoreData(sku: sku, isLiked: isLiked)
    }
}
