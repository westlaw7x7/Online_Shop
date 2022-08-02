//
//  AuthTest.swift
//  Online_ShopTests
//
//  Created by Alexander Grigoryev on 6/28/22.
//

import XCTest
import Alamofire

@testable import Online_Shop

class AuthTest: XCTestCase {
    var expectation = XCTestExpectation(description: "TestingAuth...")
    var expectationOfLogout = XCTestExpectation(description: "TestingLogout...")
    var auth: AuthRequestFactory!
    var isAuthSuccesfull: Bool!
    var isLogout: Bool!
    
    override func setUpWithError() throws {
        let container = ContainerBuilder().makeContainer()
        let factory = RequestFactory(container: container)
        auth = factory.makeAuthRequestFactory()
        isAuthSuccesfull = false
        isLogout = false
    }
    
    override func tearDownWithError() throws {
        auth = nil
        isAuthSuccesfull = nil
        isLogout = nil
    }
    
    func testLogin() {
        auth.login(userName: userDataStub.username,
                   password: userDataStub.password) { [weak self] response in
            switch response.result {
            case .success(let data):
                self?.isAuthSuccesfull = data.result == 1 ? true : false
            case .failure(let error):
                XCTFail(error.localizedDescription)
                print(error)
            }
            self?.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
        XCTAssertTrue(isAuthSuccesfull, "Auth is unsuccessful")
    }
    
    func testLogout() {
        auth.logout(id: userDataStub.id) { [weak self] response in
            switch response.result {
            case .success(let data):
                self?.isLogout = data.result == 1 ? true : false
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            self?.expectationOfLogout.fulfill()
        }
        wait(for: [expectationOfLogout], timeout: 10.0)
        XCTAssertTrue(isLogout, "Logout is unsuccessful")
    }
}
