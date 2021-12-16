//
//  ExchangeTestCase.swift
//  LeBaluchonV2Tests
//
//  Created by Nicolas Demange on 09/12/2021.
//

import XCTest
@testable import LeBaluchonV2

class ExchangeTestCase: XCTestCase {
    
    // MARK: - Let
    
    private let sessionConfiguration: URLSessionConfiguration = {
        let sessionConfiguration = URLSessionConfiguration.ephemeral
        sessionConfiguration.protocolClasses = [URLProtocolFake.self]
        return sessionConfiguration
    }()
    
    // MARK: - Tests
    func testsGetExchange_WhenFakeSessionWithErrorIsPassed_ThenShouldReturnAnError() {
        URLProtocolFake.fakeURLs = [FakeResponseDataExchange.url: (nil, nil, FakeResponseDataExchange.error)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let sut: ExchangeService = .init(session: fakeSession)
        
        let expectation = XCTestExpectation(description: "Waiting...")
        sut.getExchange() { result in
            guard case .failure(let error) = result else {
                XCTFail("Test failed: \(#function)")
                return
            }
            XCTAssertTrue(error == .noData)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testsGetExchange_WhenFakeSessionWithCorrectDataAndInvalidResponseArePassed_ThenShouldReturnAnError() {
        URLProtocolFake.fakeURLs = [FakeResponseDataExchange.url: (FakeResponseDataExchange.exchangeCorrectData, FakeResponseDataExchange.responseKO, nil)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let sut: ExchangeService = .init(session: fakeSession)
        
        let expectation = XCTestExpectation(description: "Waiting...")
        sut.getExchange() { result in
            guard case .failure(let error) = result else {
                XCTFail("Test failed: \(#function)")
                return
            }
            XCTAssertTrue(error == .invalidResponse)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testsFetchBinaryConvertion_WhenFakeSessionWithIncorrectDataAndValidResponseArePassed_ThenShouldReturnAnError() {
        URLProtocolFake.fakeURLs = [FakeResponseDataExchange.url: (FakeResponseDataExchange.exchangeIncorrectData, FakeResponseDataExchange.responseOK, nil)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let sut: ExchangeService = .init(session: fakeSession)
        
        let expectation = XCTestExpectation(description: "Waiting...")
        sut.getExchange() { result in
            guard case .failure(let error) = result else {
                XCTFail("Test failed: \(#function)")
                return
            }
            XCTAssertTrue(error == .undecodableData)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    
    func testsGetExchange_WhenFakeSessionWithCorrectDataAndValidResponseArePassed_ThenShouldACorrectConvertion() {
        URLProtocolFake.fakeURLs = [FakeResponseDataExchange.url: (FakeResponseDataExchange.exchangeCorrectData, FakeResponseDataExchange.responseOK, nil)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let sut: ExchangeService = .init(session: fakeSession)
        
        let expectation = XCTestExpectation(description: "Waiting...")
        sut.getExchange() { result in
            guard case .success(let rates) = result else {
                XCTFail("Test failed: \(#function)")
                return
            }
            XCTAssertTrue(rates.rates == ["USD": 1.127879])
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
}
