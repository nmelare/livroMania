import UIKit

enum TabBarType {
    case search
    case want
    case have
    
    var title: String {
        switch self {
        case .search:
            return "Pesquisa"
        case .want:
            return "Comprar"
        case .have:
            return "Biblioteca"
        }
    }
    
    var image: UIImage? {
        switch self {
        case .search:
            return UIImage(systemName: "magnifyingglass")
        case .want:
            return UIImage(systemName: "heart")
        case .have:
            return UIImage(systemName: "book")
        }
    }
}


