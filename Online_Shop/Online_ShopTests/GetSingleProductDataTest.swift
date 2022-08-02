//
//  GetSingleProductDataTest.swift
//  Online_ShopTests
//
//  Created by Alexander Grigoryev on 6/30/22.
//

import XCTest
@testable import Online_Shop

class GetSingleProductDataTest: XCTestCase {
    
    let expectation = XCTestExpectation(description: "SingleProductDataFetchingTest...")
    var getSingleProduct: GetSingleProductDataFactory!
    var isDataReceived: Bool!
    
    override func setUpWithError() throws {
        let container = ContainerBuilder().makeContainer()
        let factory = RequestFactory(container: container)
        getSingleProduct = factory.makeSingleProductDataRequestFactory()
        isDataReceived = false
    }
    
    override func tearDownWithError() throws {
        getSingleProduct = nil
        isDataReceived = nil
    }
    
    func testGetSingleData() {
        getSingleProduct.getData(id: "m1") { [weak self] response in
            switch response.result {
            case .success(let data):
                self?.isDataReceived = data.result == 1 ? true : false
            case .failure(let error):
                XCTFail()
                print(error)
            }
            self?.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
}
