//
//  File.swift
//  
//
//  Created by Samson Lopez on 09/05/2023.
//

import Foundation

import XCTest
import Combine
@testable import Home

final class HomeViewModelTests: XCTestCase {
    
    private var mockPlayStoreRepository: MockPlayStoreRepository!
    private var sut: HomeViewModel!
    
    override func setUpWithError() throws {
        mockPlayStoreRepository = MockPlayStoreRepository()
        sut = HomeViewModel(repository: mockPlayStoreRepository)
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_fetchAlbums_onSuccess() throws {
        sut.fetchAlbums()
        mockPlayStoreRepository.simulateRequestSuccess()
        let albums = try XCTUnwrap(sut.albums)
        XCTAssertTrue(albums.count == 2)
        XCTAssertEqual(albums[0].id, "1")
        XCTAssertEqual(albums[1].id, "2")
    }

    func test_fetchAlbums_onFailure() throws {
        sut.fetchAlbums()
        mockPlayStoreRepository.simulateRequestFailure(.unknownError)
        let albums = try XCTUnwrap(sut.albums)
        XCTAssertTrue(albums.count == 0)
    }
    
    func test_fetchAlbums_showNetworkError_onFailure() throws {
        sut.fetchAlbums()
        mockPlayStoreRepository.simulateRequestFailure(.networkError)
        XCTAssertEqual(sut.errorMessage, PlayStoreError.networkError.errorMessage)
        XCTAssertTrue(sut.showAlert)
    }

}

private class MockPlayStoreRepository: PlayStoreRepository {
    let subject = PassthroughSubject<[Home.Album], Home.PlayStoreError>()

    func simulateRequestSuccess() {
        subject.send(Home.Album.mockAlbums)
    }

    func simulateRequestFailure(_ playStoreError: PlayStoreError) {
        subject.send(completion: .failure(playStoreError))
    }

    func getAlbums(after: String?, limit: Int) -> AnyPublisher<[Home.Album], Home.PlayStoreError> {
        return subject.eraseToAnyPublisher()
    }
}
    
extension Home.Album {
    static let mockAlbums = [
        Home.Album(id: "1", title: "First album", artistId: "First Artist"),
        Home.Album(id: "2", title: "Second album", artistId: "Second Artist")
    ]
}
