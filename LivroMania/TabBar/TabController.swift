import UIKit

final class TabController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.tintColor = .magenta
        self.tabBar.unselectedItemTintColor = .black
        self.tabBar.backgroundColor = .white
        self.tabBar.isTranslucent = false
        setup()
    }
    
    private func setup() {
        let search = UINavigationController(rootViewController: SearchViewController())
        let want = UINavigationController(rootViewController: WantViewController())
        let have = UINavigationController(rootViewController: HaveViewController())
        
        self.setViewControllers([search, want, have], animated: true)

        guard let itens = tabBar.items else { return }
        itens[0].title = TabBarType.search.title
        itens[0].image = TabBarType.search.image

        itens[1].title = TabBarType.want.title
        itens[1].image = TabBarType.want.image

        itens[2].title = TabBarType.have.title
        itens[2].image = TabBarType.have.image
    }
}
