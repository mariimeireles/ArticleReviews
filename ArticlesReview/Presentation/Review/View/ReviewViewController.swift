

import UIKit

final class ReviewViewController: UIViewController {
    
    @IBOutlet private var listView: ListView!
    @IBOutlet private var gridView: GridView!
    @IBOutlet private var listButton: UIButton!
    @IBOutlet private var gridButton: UIButton!
    private let viewModel: ReviewViewModel
    
    init(viewModel: ReviewViewModel) {
        self.viewModel = viewModel
        super.init(nibName: ReviewViewController.identifier, bundle: Bundle.main)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setScreenState()
    }
    
    private func setScreenState() {
        let screenState = viewModel.retriveReviewedArticlesFromCoreData()
        render(screenState)
    }
    
    private func render(_ state: ReviewScreenState) {
        switch state {
        case let .success(articleEntities):
            listView.articleEntities = articleEntities
            gridView.articleEntities = articleEntities
        case .failure:
            let alert = UIAlertController(title: "Something went wrong.", message: "Sorry, it's not you, it's us! Please try again later.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func listButton(_ sender: Any) {
        showGridView(false)
    }
    
    @IBAction func gridButton(_ sender: Any) {
        showGridView(true)
    }
    
    private func showGridView(_ bool: Bool) {
        listView.alpha = bool ? 0 : 1
        listButton.alpha = bool ? 0.5 : 1
        gridView.alpha = bool ? 1 : 0
        gridButton.alpha = bool ? 1 : 0.5
    }
}
