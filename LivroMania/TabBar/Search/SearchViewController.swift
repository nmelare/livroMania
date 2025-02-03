import UIKit

class SearchViewController: UIViewController {
    private let tableView: UITableView = {
       let tableView = UITableView()
        tableView.register(BookCell.self,
                           forCellReuseIdentifier: BookCell.identifier)
        return tableView
    }()
    
    private let searchController = UISearchController(searchResultsController: nil)
     
    private var filteredBooks: [MyGoogleBooks.Item] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupSearchBar()
    }
    
    private func setupSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Procurar Livros"

        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func setupUI() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemBackground
        tableView.delegate = self
        tableView.dataSource = self
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
    
    private func reloadTableView() {
        DispatchQueue.main.async { [self] in
            self.tableView.reloadData()
        }
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredBooks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BookCell.identifier,
                                                       for: indexPath) as? BookCell else { fatalError("Problem loading cell") }
        let volumeInfo = filteredBooks[indexPath.row].volumeInfo
        let model = BookViewModel(volumeInfo: volumeInfo)

        cell.show(model: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let volumeInfo = filteredBooks[indexPath.row].volumeInfo
        let model = BookViewModel(volumeInfo: volumeInfo)
        let informationController = InformationViewController(model: model)
        
        navigationController?.pushViewController(informationController, animated: true)
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text, !text.isEmpty else {
            filteredBooks = []
            reloadTableView()
            return
        }
        
        Task {
            do {
                let response = try await MyGoogleBooks.search(for: text)
                filteredBooks = response.items
            } catch {
                print("Error fetching books: \(error.localizedDescription)")
                filteredBooks = []
            }
            reloadTableView()
        }
    }
}
