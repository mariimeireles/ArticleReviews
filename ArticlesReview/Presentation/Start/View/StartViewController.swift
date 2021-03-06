

import UIKit

final class StartViewController: UIViewController {
    
    private let selectionViewModel: ArticlesViewModel
    private let reviewViewModel: ReviewViewModel
    
    init(selectionViewModel: ArticlesViewModel, reviewViewModel: ReviewViewModel) {
        self.selectionViewModel = selectionViewModel
        self.reviewViewModel = reviewViewModel
        super.init(nibName: StartViewController.identifier, bundle: Bundle.main)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction private func startButton(_ sender: Any) {
        let selectionViewController = SelectionViewController(viewModel: selectionViewModel, reviewViewModel: reviewViewModel)
        navigationController?.pushViewController(selectionViewController, animated: true)
    }
}
