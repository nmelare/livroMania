import XCTest
@testable import LivroMania

final class StartCoordinatorTests: XCTestCase {
    
    var navigationControllerMock: NavigationControllerMock!
    var sut: StartCoordinator!
    
    override func setUp() {
        super.setUp()
        navigationControllerMock = NavigationControllerMock()
        sut = StartCoordinator(navigationController: navigationControllerMock)
    }
    
    override func tearDown() {
        navigationControllerMock = nil
        sut = nil
        super.tearDown()
    }
    
    func testStartMethodPushesTabBarController() {
        // Call the `start(animated:)` method
        sut.start(animated: true)
        
        // Assert that a view controller was pushed
        XCTAssertTrue(navigationControllerMock.pushedViewController is TabController)
        XCTAssertTrue(navigationControllerMock.animatedPush)
    }
    
    func testPopViewControllerWithCustomAnimation() {
        // Call the `popViewController(animated:useCustomAnimation:transitionType:)` method
        sut.popViewController(animated: true, useCustomAnimation: true, transitionType: .fade)
    }
}

