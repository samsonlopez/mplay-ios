//
//  PlayStoreRepository.swift
//  MPlay
//
//  Created by Samson Lopez on 22/02/2023.
//

import Foundation
import Combine
import Apollo

public enum PlayStoreError: Error {
    case networkError
    case serverError
    case unknownError
    
    var errorMessage: String {
        switch self {
        case .networkError:
            return "Unable to connect to the server. Please try again later."
        case .serverError:
            return "Server error. Please try again later."
        case .unknownError:
            return "An error has occured. Please try again later."
        }
    }
}

public protocol PlayStoreRepository {
    func getAlbums(after: String?, limit: Int) -> AnyPublisher<[Album], PlayStoreError>
}

public class MPlayStoreRepository: PlayStoreRepository {
    
    var albumsWatcher: GraphQLQueryWatcher<MPlaySchema.AlbumsQuery>?
    var apolloClient: ApolloClient

    public init(apolloClient: ApolloClient = Network.shared.apolloClient) {
        self.apolloClient = apolloClient
    }

    public func getAlbums(after: String?, limit: Int) -> AnyPublisher<[Album], PlayStoreError> {
        let subject = PassthroughSubject<[Album], PlayStoreError>()

        albumsWatcher = apolloClient.watch(query: MPlaySchema.AlbumsQuery(after: after ?? "0", limit: limit)) { result in
            switch result {
            case .success(let graphQLResult):
                let albums = graphQLResult.data?.albums?.compactMap({ album in
                    album?.mapToModel()
                })
                guard let albums = albums else {
                    subject.send(completion: .failure(PlayStoreError.unknownError))
                    break
                }
                subject.send(albums)
                break;
            case .failure(let error):
                // print(error)
                subject.send(completion: .failure(PlayStoreError.networkError))
                break;
            }
        }
        return subject.eraseToAnyPublisher()
    }
}

// Extend GraphQL data class to map to model class
extension MPlaySchema.AlbumsQuery.Data.Album {
    func mapToModel() -> Album? {
        guard let id = self.id, let title = self.title, let artistId = self.artistId else {
            return nil
        }
        return Album(id: id, title: title, artistId: artistId)
    }
}
