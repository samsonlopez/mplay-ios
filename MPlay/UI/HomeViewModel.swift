//
//  HomeViewModel.swift
//  MPlay
//
//  Created by Samson Lopez on 22/02/2023.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    var playstoreAlbumsCancellable = Set<AnyCancellable>()
    let playStoreRepository = MPlayStoreRepository()
    @Published var albums: [Album]? = [Album]()
    @Published var isLoading = false

    // Pagination
    var lastAlbumId: String? // Cursor value
    let limit = 25 // Page limit
    var hasMoreAlbums: Bool = true
    
    func fetchData() {
        playStoreRepository.getAlbums(after: lastAlbumId, limit: limit)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    // Show error message if server response fails
                    print(error.errorMessage)
                    self.isLoading = false
                    break
                }
            }, receiveValue: { [self] albums in
                // Use the data here
                //print(data)
                albums.forEach({ album in
                    //print(album.title)
                })
                print(albums.count)
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
