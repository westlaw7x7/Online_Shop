//
//  RegistrationTest.swift
//  Online_ShopTests
//
//  Created by Alexander Grigoryev on 6/29/22.
//

import XCTest
@testable import Online_Shop

let userDataStub = UserData(    id: 123,
                                username: "userTest",
                                password: "qwerty123",
                                email: "userTest@some.ru",
                                gender: .male,
                                creditCard: "12345678910",
                                bio: "Some test BIO")

class RegistrationTest: XCTestCase {
    let expectation = XCTestExpectation(description:"RegistrationTesting...")
    var registration: RegistrationRequestFactory!
    var isRegistered: Bool!
    
    override func setUpWithError() throws {
        let container = ContainerBuilder().makeContainer()
        let factory = RequestFactory(container: container)
        registration = factory.makeRegisterRequestFactory()
        isRegistered = false
    }
    
    override func tearDownWithError() throws {
        registration = nil
        isRegistered = nil
    }

    func testRegister() {
        
        
     registration.register(userData: userDataStub) { [weak self] response in
            switch response.result {
            case .success(let data):
                self?.isRegistered = data.result == 1 ? true : false
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            self?.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
        XCTAssertTrue(isRegistered, "Not registered")
    }
    
}
