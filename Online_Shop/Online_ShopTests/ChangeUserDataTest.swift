//
//  ChangeUserDataTest.swift
//  Online_ShopTests
//
//  Created by Alexander Grigoryev on 6/30/22.
//

import XCTest
@testable import Online_Shop

class ChangeUserDataTest: XCTestCase {
    var expectation = XCTestExpectation(description: "ChangingUserDataTest...")
    var changeData: ChangeUserDataFactory!
    var isDataChanged: Bool!
    
    override func setUpWithError() throws {
        let container = ContainerBuilder().makeContainer()
        let factory = RequestFactory(container: container)
        changeData = factory.makeChangeDataRequestFactory()
        isDataChanged = false
    }
    
    override func tearDownWithError() throws {
        changeData = nil
        isDataChanged = nil
    }
    
    func testChangeDataFunctional() {
        changeData.change(userData: userDataStub) { [weak self] response in
            switch response.result {
            case .success(let data):
                self?.isDataChanged = data.result == 1 ? true : false
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            self?.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
        XCTAssertTrue(isDataChanged, "Data does not changed")
    }
}
