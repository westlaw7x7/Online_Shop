//
//  GetCatalogDataTest.swift
//  Online_ShopTests
//
//  Created by Alexander Grigoryev on 6/30/22.
//

import XCTest
@testable import Online_Shop

class GetCatalogDataTest: XCTestCase {
    
    let expectation = XCTestExpectation(description: "GetCatalogDataTesting...")
    var isGotCatalog: Bool!
    var getCatalog: GetCatalogDataFactory!
    
    
    override func setUpWithError() throws {
        let container = ContainerBuilder().makeContainer()
        let factory = RequestFactory(container: container)
        getCatalog = factory.makeCatalogDataRequestFactory()
        isGotCatalog = false
    }
    
    override func tearDownWithError() throws {
        isGotCatalog = nil
        getCatalog = nil
    }
    
    func testGetCatalogData() {
        getCatalog.getData(
                           categoryID: "") { [weak self] response in
            switch response.result {
            case .success(let data):
                self?.isGotCatalog = data.products.isEmpty ? false : true
                
            case .failure(let error):
                XCTFail()
                print(error)
            }
            self?.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
        XCTAssertTrue(isGotCatalog, "CatalogData hasn't been received")
    }
    
}
