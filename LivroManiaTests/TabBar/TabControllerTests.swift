import XCTest
@testable import LivroMania

final class TabControllerTests: XCTestCase {

    var sut: TabController!

    override func setUp() {
        super.setUp()
        sut = TabController()
        sut.loadViewIfNeeded()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testTabBarProperties() {
        // Verify the tab bar appearance properties
        XCTAssertEqual(sut.tabBar.tintColor, .magenta, "The tab bar tintColor should be magenta.")
        XCTAssertEqual(sut.tabBar.unselectedItemTintColor, .black, "The tab bar unselectedItemTintColor should be black.")
        XCTAssertEqual(sut.tabBar.backgroundColor, .white, "The tab bar backgroundColor should be white.")
        XCTAssertFalse(sut.tabBar.isTranslucent, "The tab bar should not be translucent.")
    }

    func testViewControllersSetup() {
        // Verify that the correct number of view controllers is set
        XCTAssertEqual(sut.viewControllers?.count, 3, "The TabController should have 3 view controllers.")

        // Verify the type of each view controller
        let searchNav = sut.viewControllers?[0] as? UINavigationController
        let wantNav = sut.viewControllers?[1] as? UINavigationController
        let haveNav = sut.viewControllers?[2] as? UINavigationController

        XCTAssertNotNil(searchNav, "The first tab should be a UINavigationController for the SearchViewController.")
        XCTAssertNotNil(wantNav, "The second tab should be a UINavigationController for the WantViewController.")
        XCTAssertNotNil(haveNav, "The third tab should be a UINavigationController for the HaveViewController.")
    }

    func testTabBarItemsSetup() {
        // Verify that tab bar items are configured correctly
        guard let items = sut.tabBar.items else {
            XCTFail("Tab bar items should not be nil.")
            return
        }

        XCTAssertEqual(items.count, 3, "The TabController should have 3 tab bar items.")

        XCTAssertEqual(items[0].title, TabBarType.search.title, "The first tab bar item should have the correct title.")
        XCTAssertEqual(items[0].image, TabBarType.search.image, "The first tab bar item should have the correct image.")

        XCTAssertEqual(items[1].title, TabBarType.want.title, "The second tab bar item should have the correct title.")
        XCTAssertEqual(items[1].image, TabBarType.want.image, "The second tab bar item should have the correct image.")

        XCTAssertEqual(items[2].title, TabBarType.have.title, "The third tab bar item should have the correct title.")
        XCTAssertEqual(items[2].image, TabBarType.have.image, "The third tab bar item should have the correct image.")
    }
}

