import Foundation
import UIKit

final class BookCell: UITableViewCell {
    static let identifier = "BookCell"
    
    private let bookImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        return image
    }()
    
    private let bookName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.setContentHuggingPriority(.required, for: .vertical)
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    private let author: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.setContentHuggingPriority(.required, for: .vertical)
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    private let view = UIView()
    
    private let publisher: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    private let value: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    private let stackViewText: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 4
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let stackViewAll: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        setupSubviews()
        setupConstraints()
        backgroundColor = .systemBackground
    }
    
    private func setupSubviews() {
        stackViewText.addArrangedSubview(bookName)
        stackViewText.addArrangedSubview(author)
        stackViewText.addArrangedSubview(view)
        stackViewText.addArrangedSubview(publisher)
        
        stackViewAll.addArrangedSubview(bookImage)
        stackViewAll.addArrangedSubview(stackViewText)
        stackViewAll.addArrangedSubview(value)
        addSubview(stackViewAll)
    }
    
    private func setupConstraints() {
        bookImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
        bookImage.widthAnchor.constraint(equalToConstant: 60).isActive = true

        NSLayoutConstraint.activate([
            stackViewAll.topAnchor.constraint(equalTo:             self.layoutMarginsGuide.topAnchor, constant: 8),
            stackViewAll.trailingAnchor.constraint(equalTo:             self.layoutMarginsGuide.trailingAnchor, constant: -8),
            stackViewAll.leadingAnchor.constraint(equalTo:             self.layoutMarginsGuide.leadingAnchor, constant: 8),
            stackViewAll.bottomAnchor.constraint(equalTo:             self.layoutMarginsGuide.bottomAnchor, constant: -8),
        ])
    }
    
    func show(model: BookViewModel) {
        if let title = model.volumeInfo.title {
            bookName.text = title
        }
        
        author.text = model.volumeInfo.authors?.joined(separator: ", ")
        
        if let publisherText = model.volumeInfo.publisher {
            publisher.text = publisherText
        }
        
        if let valueText = model.value {
            value.text = String(format: "R$ %.2f", valueText)
        }

        Task {
            guard let image = model.volumeInfo.imageLinks?.thumbnail else {return}
            do {
                try await bookImage.loadImageFromServer(urlString: image)
            } catch {
                throw CustomError.errorToLoadImage
            }
        }
    }
}
