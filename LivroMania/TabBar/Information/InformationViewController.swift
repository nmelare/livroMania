import Foundation
import UIKit

final class InformationViewController: UIViewController {
    private let coreDatahelper = CoreDataHelper()
    
    private let bookImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        return image
    }()
    
    private let bookName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.setContentHuggingPriority(.required, for: .vertical)
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    private let author: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.setContentHuggingPriority(.required, for: .vertical)
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.setContentHuggingPriority(.required, for: .vertical)
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    private let publisherLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.setContentHuggingPriority(.required, for: .vertical)
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    private let value: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .right
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.setContentHuggingPriority(.required, for: .vertical)
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    private let spacingView = UIView()
    
    private let haveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Já Tenho", for: .normal)
        button.backgroundColor = UIColor(cgColor: CGColor(red: 74/255,
                                                          green: 01/255,
                                                          blue: 78/255,
                                                          alpha: 1.0))
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        return button
    }()
    
    private let wantButton: UIButton = {
        let button = UIButton()
        button.setTitle("Quero ter", for: .normal)
        button.backgroundColor = UIColor(cgColor: CGColor(red: 74/255,
                                                          green: 01/255,
                                                          blue: 78/255,
                                                          alpha: 1.0))
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        return button
    }()
    
    private let stackViewAll: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let buttonStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fillEqually
        return stack
    }()
    
    private let stackViewVertical: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 4
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsHorizontalScrollIndicator = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
        
    private var bookModel: BookViewModel
    
    init(model: BookViewModel) {
        bookModel = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        show(model: bookModel)
    }
    
    private func show(model: BookViewModel) {
        bookName.text = model.volumeInfo.title
        
        author.text = model.volumeInfo.authors?.joined(separator: ", ")

        publisherLabel.text = model.volumeInfo.publisher
        descriptionLabel.text = model.volumeInfo.description
        value.text = model.value
        
        Task {
            guard let image = model.volumeInfo.imageLinks?.thumbnail else {return}
            do {
                try await bookImage.loadImageFromServer(urlString: image)
            } catch {
                throw CustomError.errorToLoadImage
            }
        }
    }
    
    private func setupUI() {
        setupSubviews()
        setupConstraints()
        setupActions()
        view.backgroundColor = .systemBackground
    }
    
    private func setupSubviews() {
        stackView.addArrangedSubview(bookImage)
        stackView.addArrangedSubview(stackViewVertical)
        stackViewVertical.addArrangedSubview(bookName)
        stackViewVertical.addArrangedSubview(spacingView)
        stackViewVertical.addArrangedSubview(author)
        stackViewVertical.addArrangedSubview(publisherLabel)
        stackViewVertical.addArrangedSubview(value)
        
        stackViewAll.addArrangedSubview(stackView)
        stackViewAll.addArrangedSubview(buttonStackView)
        stackViewAll.addArrangedSubview(descriptionLabel)
        
        buttonStackView.addArrangedSubview(wantButton)
        buttonStackView.addArrangedSubview(haveButton)

        view.addSubview(scrollView)
        scrollView.addSubview(stackViewAll)
    }
    
    private func setupConstraints() {
        bookImage.heightAnchor.constraint(equalToConstant: 200).isActive = true
        bookImage.widthAnchor.constraint(equalToConstant: 120).isActive = true

        haveButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        wantButton.heightAnchor.constraint(equalToConstant: 60).isActive = true

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo:
                                                self.view.layoutMarginsGuide.topAnchor, constant: 8),
            scrollView.trailingAnchor.constraint(equalTo:
                                                    self.view.trailingAnchor, constant: -8),
            scrollView.leadingAnchor.constraint(equalTo:
                                                    self.view.leadingAnchor, constant: 8),
            scrollView.bottomAnchor.constraint(equalTo:
                                                self.view.layoutMarginsGuide.bottomAnchor, constant: -8),

            stackViewAll.topAnchor.constraint(equalTo:
                                                scrollView.topAnchor),
            stackViewAll.trailingAnchor.constraint(equalTo:
                                                    scrollView.trailingAnchor),
            stackViewAll.leadingAnchor.constraint(equalTo:
                                                    scrollView.leadingAnchor),
            stackViewAll.bottomAnchor.constraint(equalTo:
                                                    scrollView.bottomAnchor),
            stackViewAll.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    private func setupActions() {
        haveButton.addTarget(self,
                             action: #selector(didTapHaveSaveInfo),
                             for: .touchUpInside)
        
        wantButton.addTarget(self,
                             action: #selector(didTapWantSaveInfo),
                             for: .touchUpInside)
    }
    
    private func createItem(id: BookCategorySaving) {
        coreDatahelper.saveBook(title: bookModel.volumeInfo.title ?? "",
                                image: bookModel.volumeInfo.imageLinks?.thumbnail,
                                subtitle: bookModel.volumeInfo.subtitle ?? "",
                                author: bookModel.volumeInfo.authors?.joined(separator: ", ") ?? "",
                                publishedDate: bookModel.volumeInfo.publishedDate ?? "",
                                bookDescription: bookModel.volumeInfo.description ?? "",
                                id: id.rawValue,
                                pageCount: String(bookModel.volumeInfo.pageCount ?? 0),
                                publisher: bookModel.volumeInfo.publisher ?? "",
                                mainCategory: bookModel.volumeInfo.mainCategory ?? "",
                                value: bookModel.value ?? "")
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "Livro salvo com sucesso!", message: "", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Entendi", style: .cancel, handler:{ (UIAlertAction)in
                alert.dismiss(animated: true)
            }))

            self.present(alert, animated: true)
    }
    
    @objc private func didTapWantSaveInfo() {
        createItem(id: .want)
        showAlert()
    }
    
    @objc private func didTapHaveSaveInfo() {
        createItem(id: .have)
        showAlert()
    }
}
