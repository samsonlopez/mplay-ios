//
//  HomeViewModel.swift
//  MPlay
//
//  Created by Samson Lopez on 22/02/2023.
//

import Foundation
import Combine

public class HomeViewModel: ObservableObject {
    
    let playStoreRepository: PlayStoreRepository

    public init(repository: PlayStoreRepository) {
        self.playStoreRepository = repository
    }
    
    var playstoreAlbumsCancellable = Set<AnyCancellable>()
    @Published var albums: [Album]? = [Album]()
    @Published var isLoading = false
    @Published var showAlert = false
    @Published var errorMessage = ""

    // Pagination
    var lastAlbumId: String? // Cursor value
    let limit = 25 // Page limit
    var hasMoreAlbums: Bool = true
    
    func fetchAlbums() {
        playStoreRepository.getAlbums(after: lastAlbumId, limit: limit)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    // Show error message if server response fails
                    self.errorMessage = error.errorMessage
                    self.showAlert = true
                    self.isLoading = false
                    break
                }
            }, receiveValue: { [self] albums in
                if albums.count == 0 {
                    self.hasMoreAlbums = false
                }
                
                if lastAlbumId != nil {
                    Thread.sleep(forTimeInterval: 0.5) // Test code, create an artifical delay to see loading indicator
                }

                self.albums?.append(contentsOf: albums) // Publish the loaded albums
                self.lastAlbumId = self.albums?.last?.id // Set the cursor for pagination
                self.isLoading = false
            })
            .store(in: &playstoreAlbumsCancellable)
    }
}
