

import UIKit

final class ListView: UIView, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet private var listContentView: UIView!
    @IBOutlet weak private var tableView: UITableView!
    
    var articleEntities: [ArticleEntity]? {
        didSet {
            updateTableView()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        uiSetup()
    }

    private func uiSetup() {
        Bundle.main.loadNibNamed(ListView.identifier, owner: self, options: nil)
        addSubview(listContentView)
        listContentView.frame = self.bounds
    }
    
    private func updateTableView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(ListCell.nib, forCellReuseIdentifier: ListCell.identifier)
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let articleEntities = articleEntities else { return 0 }
        return articleEntities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let articleEntities = articleEntities else { return UITableViewCell() }
        let articleEntity = articleEntities[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListCell.identifier, for: indexPath) as? ListCell else { return UITableViewCell() }
        cell.articleEntity = articleEntity
        return cell
    }
}
