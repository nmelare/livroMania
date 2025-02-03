import UIKit

class NavigationControllerMock: UINavigationController {
    var pushedViewController: UIViewController?
    var animatedPush: Bool = false
    private(set) var didSetNavigationBarHidden: Bool = false

    override func setNavigationBarHidden(_ hidden: Bool, animated: Bool) {
        didSetNavigationBarHidden = hidden
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushedViewController = viewController
        animatedPush = animated
    }
}

