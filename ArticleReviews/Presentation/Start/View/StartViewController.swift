

import UIKit

final class StartViewController: UIViewController {
    
    private let selectionViewModel: ArticlesViewModel
    
    init(selectionViewModel: ArticlesViewModel) {
        self.selectionViewModel = selectionViewModel
        super.init(nibName: StartViewController.identifier, bundle: Bundle.main)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func startButton(_ sender: Any) {
        let selectionViewController = SelectionViewController(viewModel: selectionViewModel)
        navigationController?.pushViewController(selectionViewController, animated: true)
    }
}
