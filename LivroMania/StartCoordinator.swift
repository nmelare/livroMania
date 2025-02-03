import UIKit
import Foundation

final class StartCoordinator: Coordinator {
    var navigationController: UINavigationController
            
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.setNavigationBarHidden(true, animated: true)
    }
    
    func start(animated: Bool) {
        navigationController.pushViewController(buildTabBarViewController(),
                                                animated: animated)
    }
    
    func popViewController(animated: Bool, useCustomAnimation: Bool, transitionType: CATransitionType) {
        
    }
    
    private func buildTabBarViewController() -> UIViewController {
        let controller = TabController()
        return controller
    }
    
    private func buildSearchViewController() -> UIViewController {
        let controller = SearchViewController()
        return controller
    }

    private func buildWantViewController() -> UIViewController {
        let controller = WantViewController()
        return controller
    }

    private func buildHaveViewController() -> UIViewController {
        let controller = HaveViewController()
        return controller
    }
}

