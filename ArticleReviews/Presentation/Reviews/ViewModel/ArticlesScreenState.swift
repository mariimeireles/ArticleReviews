

enum ArticlesScreenState {
    case loading
    case success([ArticleEntity])
    case failure(ArticlesScreenErrorType)

    init(restError: RESTError) {
        switch restError {
        case .serverError:
            self = .failure(.serverError)
        default:
            self = .failure(.unknown)
        }
    }
}
