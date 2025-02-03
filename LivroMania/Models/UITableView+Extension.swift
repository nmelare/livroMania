import UIKit

extension UITableView {
    func setEmptyView(title: String, message: String) {
        let emptyView = UIView(frame: CGRect(x: self.center.x,
                                             y: self.center.y,
                                             width: self.bounds.size.width,
                                             height: self.bounds.size.height))
        let titleLabel: UILabel = {
            let label = UILabel()
            label.numberOfLines = 0
            label.textAlignment = .center
            label.font = .systemFont(ofSize: 18, weight: .semibold)
            label.textColor = UIColor.black
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = title
            return label
        }()
        
        let messageLabel: UILabel = {
            let label = UILabel()
            label.numberOfLines = 0
            label.textAlignment = .center
            label.font = .systemFont(ofSize: 18, weight: .semibold)
            label.textColor = UIColor.lightGray
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = message
            return label
        }()

        emptyView.addSubview(titleLabel)
        emptyView.addSubview(messageLabel)

        titleLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        messageLabel.leftAnchor.constraint(equalTo: emptyView.leftAnchor, constant: 20).isActive = true
        messageLabel.rightAnchor.constraint(equalTo: emptyView.rightAnchor, constant: -20).isActive = true
       
        self.backgroundView = emptyView
        self.separatorStyle = .none
    }

    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
