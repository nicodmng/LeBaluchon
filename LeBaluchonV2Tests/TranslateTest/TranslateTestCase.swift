//
//  TranslateTestCase.swift
//  LeBaluchonV2Tests
//
//  Created by Nicolas Demange on 12/12/2021.
//

import XCTest
@testable import LeBaluchonV2

class TranslateTestCase: XCTestCase {

    // MARK: - Let
    
    private let sessionConfiguration: URLSessionConfiguration = {
        let sessionConfiguration = URLSessionConfiguration.ephemeral
        sessionConfiguration.protocolClasses = [URLProtocolFake.self]
        return sessionConfiguration
    }()
    
    // MARK: - Tests
    func testsGetTranslate_WhenFakeSessionWithErrorIsPassed_ThenShouldReturnAnError() {
        URLProtocolFake.fakeURLs = [FakeResponseDataTranslate.url: (nil, nil, FakeResponseDataTranslate.error)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let sut: TranslateService = .init(session: fakeSession)
        
        let expectation = XCTestExpectation(description: "Waiting...")
        sut.getTranslate(text: "Bienvenue", languageCodeTarget: "EN") { result in
            guard case .failure(let error) = result else {
                XCTFail("Test failed: \(#function)")
                return
            }
            XCTAssertTrue(error == .noData)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testsGetTranslate_WhenFakeSessionWithCorrectDataAndInvalidResponseArePassed_ThenShouldReturnAnError() {
        URLProtocolFake.fakeURLs = [FakeResponseDataTranslate.url: (FakeResponseDataTranslate.translateCorrectData, FakeResponseDataTranslate.responseKO, nil)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let sut: TranslateService = .init(session: fakeSession)
        
        let expectation = XCTestExpectation(description: "Waiting...")
        sut.getTranslate(text:"Bienvenue", languageCodeTarget: "EN") { result in
            guard case .failure(let error) = result else {
                XCTFail("Test failed: \(#function)")
                return
            }
            XCTAssertTrue(error == .invalidResponse)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testsGetTranslate_WhenFakeSessionWithIncorrectDataAndValidResponseArePassed_ThenShouldReturnAnError() {
        URLProtocolFake.fakeURLs = [FakeResponseDataTranslate.url: (FakeResponseDataTranslate.translateIncorrectData, FakeResponseDataTranslate.responseOK, nil)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let sut: TranslateService = .init(session: fakeSession)
        
        let expectation = XCTestExpectation(description: "Waiting...")
        sut.getTranslate(text: "Bienvenue", languageCodeTarget: "EN") { result in
            guard case .failure(let error) = result else {
                XCTFail("Test failed: \(#function)")
                return
            }
            XCTAssertTrue(error == .undecodableData)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    
    func testsGetTranslate_WhenFakeSessionWithCorrectDataAndValidResponseArePassed_ThenShouldACorrectConvertion() {
        URLProtocolFake.fakeURLs = [FakeResponseDataTranslate.url: (FakeResponseDataTranslate.translateCorrectData, FakeResponseDataTranslate.responseOK, nil)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let sut: TranslateService = .init(session: fakeSession)
        
        let expectation = XCTestExpectation(description: "Waiting...")
        sut.getTranslate(text: "Bienvenue", languageCodeTarget: "EN") { result in
            guard case .success(let translate) = result else {
                XCTFail("Test failed: \(#function)")
                return
            }
            XCTAssertTrue(translate.translations[0].text == "Bienvenue")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
}
