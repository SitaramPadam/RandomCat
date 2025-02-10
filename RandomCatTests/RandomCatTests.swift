//
//  RandomCatTests.swift
//  RandomCatTests
//
//  Created by sai sitaram on 10/02/25.
//

import XCTest
@testable import RandomCat

// MARK: - Mock Service Layer
class MockCatsInfoServiceLayer: CatsInfoServiceLayer {
    var mockData: CatModel?
    weak var mockDelegate: CatsInfoServiceLayerDelegate?
    
    override func getRandomCatFacts() {
        mockDelegate?.responseOfRandomCatFacts(data: mockData) // Simulating API response
    }
}

// MARK: - Mock Delegate
class MockCatInfoViewModelDelegate: CatInfoViewModelDelegate {
    
    var receivedCatModel: CatModel?
    var expectation: XCTestExpectation?
    
    func catDataDisplay(catInfoModel: CatModel?) {
        receivedCatModel = catInfoModel
        expectation?.fulfill() // Signal that async operation has completed
    }
}


final class RandomCatTests: XCTestCase {
    
    var viewModel: CatsInfoViewModel!
    var mockServiceLayer: MockCatsInfoServiceLayer!
    var mockDelegate: MockCatInfoViewModelDelegate!
    
    override func setUp() {
        super.setUp()
        mockServiceLayer = MockCatsInfoServiceLayer()
        viewModel = CatsInfoViewModel()
        viewModel.serviceLayer = mockServiceLayer
        mockServiceLayer.mockDelegate = viewModel
        
        mockDelegate = MockCatInfoViewModelDelegate()
        viewModel.delegate = mockDelegate
    }
    
    override func tearDown() {
        viewModel = nil
        mockServiceLayer = nil
        mockDelegate = nil
        super.tearDown()
    }
    
    func testGetCatFactsData_WhenCalled_ShouldTriggerDelegateWithData() {
        // Given
        let expectedFact = "Owning a cat can reduce the risk of stroke and heart attack by a third."
        let mockCatModel = CatModel(data: [expectedFact]) // Replace with actual model properties
        mockServiceLayer.mockData = mockCatModel
        
        let expectation = self.expectation(description: "Delegate should be called")
        mockDelegate.expectation = expectation
        
        // When
        viewModel.getCatFactsData()
        
        // Then
        waitForExpectations(timeout: 2.0) { _ in
            XCTAssertEqual(self.mockDelegate.receivedCatModel?.data[0], expectedFact, "Delegate did not receive expected cat fact")
        }
    }
    
}


