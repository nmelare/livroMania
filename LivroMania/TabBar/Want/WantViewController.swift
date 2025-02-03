import UIKit

class WantViewController: UIViewController {
    private let helper = CoreDataHelper()

    private let tableView: UITableView = {
       let tableView = UITableView()
        tableView.register(BookCell.self,
                           forCellReuseIdentifier: BookCell.identifier)
        return tableView
    }()
        
    private var filteredBooks: [BooksSave] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        helper.getAllBooks(for: BookCategorySaving.want.rawValue)
        filteredBooks = helper.models
        tableView.reloadData()
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
}

extension WantViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if helper.models.count == 0 {
            tableView.setEmptyView(title: "Nada por aqui",
                                   message: "Vá em Pesquisa para salvar livros na sua lista de compras.")
        } else {
            tableView.restore()
        }
        return helper.models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BookCell.identifier, for: indexPath) as? BookCell else { fatalError("Problem loading cell") }
        let volume = MyGoogleBooks.VolumeInfo(title: filteredBooks[indexPath.row].title,
                                              subtitle: filteredBooks[indexPath.row].subtitle,
                                              publishedDate: filteredBooks[indexPath.row].author,
                                              imageLinks: MyGoogleBooks.ImageLink(thumbnail: filteredBooks[indexPath.row].image),
                                              publisher: filteredBooks[indexPath.row].author,
                                              mainCategory: filteredBooks[indexPath.row].mainCategory,
                                              description: filteredBooks[indexPath.row].description)
        let id = filteredBooks[indexPath.row].id ?? ""
        let model = BookViewModel(volumeInfo: volume, id: BookCategorySaving(rawValue: id))

        cell.show(model: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let volume = MyGoogleBooks.VolumeInfo(title: filteredBooks[indexPath.row].title,
                                              subtitle: filteredBooks[indexPath.row].subtitle,
                                              publishedDate: filteredBooks[indexPath.row].author,
                                              imageLinks: MyGoogleBooks.ImageLink(thumbnail: filteredBooks[indexPath.row].image),
                                              publisher: filteredBooks[indexPath.row].author,
                                              mainCategory: filteredBooks[indexPath.row].mainCategory,
                                              description: filteredBooks[indexPath.row].description)
        let model = BookViewModel(volumeInfo: volume)
        let informationController = InformationViewController(model: model)
        
        navigationController?.pushViewController(informationController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {
            (action, sourceView, completionHandler) in
            
            let book = self.helper.models[indexPath.row] as BooksSave

            self.helper.cancelItem(item: book)
            self.helper.getAllBooks(for: BookCategorySaving.want.rawValue)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            completionHandler(true)
        }
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction])
        return swipeConfiguration
    }
}
