import UIKit
import XCTest

@testable import LivroMania

class SearchViewControllerTests: XCTestCase {
    
    var sut: SearchViewController!
    
    override func setUp() {
        super.setUp()
        sut = SearchViewController()
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_viewDidLoad_setsUpTableView() {
        // Asserting delegate and dataSource through casting to protocol type and not directly from the property
        XCTAssertTrue(sut.view.subviews.contains { $0 is UITableView }, "Table view is not a subview of the main view")
        
        if let tableView = sut.view.subviews.first(where: { $0 is UITableView }) as? UITableView {
            XCTAssertNotNil(tableView.delegate, "Table view delegate not set")
            XCTAssertNotNil(tableView.dataSource, "Table view data source not set")
            XCTAssertEqual(tableView.backgroundColor, .systemBackground, "Table view background color not set correctly")
            XCTAssertFalse(tableView.translatesAutoresizingMaskIntoConstraints, "Table view doesn't use constraints")
            
            
            let constraints = sut.view.constraints.filter { constraint in
                return (constraint.firstItem === tableView && constraint.secondItem === sut.view) ||
                (constraint.secondItem === tableView && constraint.firstItem === sut.view)
            }
            
            XCTAssertEqual(constraints.count, 4, "Table view is not constrained correctly")
        } else {
            XCTFail("Could not find table view in subviews")
        }
    }
    
    func test_viewDidLoad_setsUpSearchBar() {
        // Asserting search controller is setup through the navigation item
        XCTAssertNotNil(sut.navigationItem.searchController, "Search controller is not set")
        XCTAssertTrue(sut.definesPresentationContext, "Presentation context is not defined")
        XCTAssertEqual(sut.navigationItem.searchController?.searchBar.placeholder, "Procurar Livros", "Search bar placeholder is not set")
        
        XCTAssertFalse(sut.navigationItem.searchController?.obscuresBackgroundDuringPresentation ?? true , "Obscures background property should be false")
        XCTAssertFalse(sut.navigationItem.searchController?.hidesNavigationBarDuringPresentation ?? true, "Hides navigation bar property should be false")
        
        // Verify the search result updater
        if let searchResultsUpdater = sut.navigationItem.searchController?.searchResultsUpdater as? SearchViewController {
            XCTAssertTrue(searchResultsUpdater === sut, "Search result updated is not set")
        } else {
            XCTFail("Search Result Updater not set")
        }
    }
    
    func test_numberOfRowsInSection_withEmptyFilteredBooks() {
        // Getting the tableView using the view's subviews
        guard let tableView = sut.view.subviews.first(where: { $0 is UITableView }) as? UITableView else {
            XCTFail("Could not find table view in subviews")
            return
        }
        
        // When
        let count = sut.tableView(tableView, numberOfRowsInSection: 0)
        
        // Then
        XCTAssertEqual(count, 0, "Number of rows should be 0 with an empty list")
    }
}
