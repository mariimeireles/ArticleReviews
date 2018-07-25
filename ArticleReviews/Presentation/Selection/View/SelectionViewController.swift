

import UIKit

final class SelectionViewController: UIViewController {
    
    private let viewModel: ArticlesViewModel
    @IBOutlet weak private var articleImage: UIImageView!
    @IBOutlet weak private var likeButton: UIButton!
    @IBOutlet weak private var dislikeButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak private var warningLabel: UILabel!
    @IBOutlet weak var selectionView: SelectionView!
    
    init(viewModel: ArticlesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: SelectionViewController.identifier, bundle: Bundle.main)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
