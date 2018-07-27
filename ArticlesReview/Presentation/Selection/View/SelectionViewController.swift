

import RxSwift
import UIKit

final class SelectionViewController: UIViewController, SelectionViewDelegate {
    
    private let viewModel: ArticlesViewModel
    private let reviewViewModel: ReviewViewModel
    private let disposeBag = DisposeBag()
    private var numberOfEntities = 0
    private var likedEntities = 0
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private var warningLabel: UILabel!
    @IBOutlet private var likedArticlesCounter: UILabel!
    @IBOutlet private var selectionView: SelectionView!
    @IBOutlet private var reviewButton: UIButton!
    
    init(viewModel: ArticlesViewModel, reviewViewModel: ReviewViewModel) {
        self.viewModel = viewModel
        self.reviewViewModel = reviewViewModel
        super.init(nibName: SelectionViewController.identifier, bundle: Bundle.main)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setScreenState()
    }
    
    private func setScreenState() {
        viewModel.requestArticles()
            .subscribe(onNext: { [unowned self] state in self.render(state) })
            .disposed(by: disposeBag)
    }
    
    private func render(_ state: ArticlesScreenState) {
        switch state {
        case .loading:
            supportingElements(showActivityIndicator: true, reviewButtonState: .invisible, showCounter: false)
        case let .success(entities, numberOfEntities, likedEntities):
            self.numberOfEntities = numberOfEntities
            self.likedEntities = likedEntities
            likedArticlesCounter.text = "\(self.likedEntities)/\(self.numberOfEntities)"
            supportingElements(showActivityIndicator: false, reviewButtonState: .disabled, showCounter: true)
            selectionView.articleEntities = entities
            selectionView.viewModel = viewModel
            selectionView.delegate = self
            selectionView.alpha = 1
        case let .successWithNoNewArticles(numberOfEntities, likedEntities):
            self.numberOfEntities = numberOfEntities
            self.likedEntities = likedEntities
            likedArticlesCounter.text = "\(self.likedEntities)/\(self.numberOfEntities)"
            supportingElements(showActivityIndicator: false, reviewButtonState: .enabled, showCounter: true)
            warningLabel.alpha = 1
        case let .failure(error):
            supportingElements(showActivityIndicator: false, reviewButtonState: .invisible, showCounter: false)
            showFailure(for: error)
        }
    }
    
    private func supportingElements(showActivityIndicator: Bool, reviewButtonState: ReviewButtonState, showCounter: Bool) {
        activityIndicator.alpha = showActivityIndicator ? 1 : 0
        likedArticlesCounter.alpha = showCounter ? 1 : 0
        switch reviewButtonState {
        case .enabled:
            reviewButton(isEnabled: true)
        case .disabled:
            reviewButton(isEnabled: false)
        case .invisible:
            reviewButton.alpha = 0
        }
    }
    
    private func reviewButton(isEnabled: Bool) {
        reviewButton.isEnabled = isEnabled
        reviewButton.alpha = isEnabled ? 1 : 0.5
    }
    
    private func showFailure(for error: ArticlesScreenErrorType) {
        switch error {
        case .noConnection:
            presentNoConnectionError()
        case .timeOut:
            presentTimeOutError()
        default:
            presentGenericError()
        }
    }
    
    func endOfIndex() {
        self.reviewButton(isEnabled: true)
        self.selectionView.alpha = 0
        self.warningLabel.alpha = 1
    }
    
    func articleLiked() {
        likedEntities += 1
        likedArticlesCounter.text = "\(likedEntities)/\(numberOfEntities)"
    }
    
    @IBAction func reviewButton(_ sender: Any) {
        let reviewViewController = ReviewViewController(viewModel: reviewViewModel)
        navigationController?.pushViewController(reviewViewController, animated: true)
    }
    
    private func presentNoConnectionError() {
        let alert = UIAlertController(title: "Oh no!", message: "Could not find a network connection. Connect to the internet to try again.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Try again", style: .default, handler: { [unowned self] (_) -> Void in
            self.setScreenState()
        }))
        alert.addAction(UIAlertAction(title: "Check connection", style: .default, handler: { (_) -> Void in
            guard let settingsUrl = URL(string: UIApplicationOpenSettingsURLString), UIApplication.shared.canOpenURL(settingsUrl) else { return }
            UIApplication.shared.open(settingsUrl)
        }))
        present(alert, animated: true, completion: nil)
    }
    
    private func presentTimeOutError() {
        let alert = UIAlertController(title: "Oh no!", message: "This is taking a little longer than usual.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Try again", style: .default, handler: { [unowned self] (_) -> Void in
            self.setScreenState()
        }))
        present(alert, animated: true, completion: nil)
    }
    
    private func presentGenericError() {
        let alert = UIAlertController(title: "Something went wrong.", message: "Sorry, it's not you, it's us! Please try again later.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Try again", style: .default, handler: { [unowned self] (_) -> Void in
            self.setScreenState()
        }))
        present(alert, animated: true, completion: nil)
    }
}
