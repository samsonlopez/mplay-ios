//
//  PlayStoreRepository.swift
//  MPlay
//
//  Created by Samson Lopez on 22/02/2023.
//

import Foundation
import Combine
import Apollo

enum PlayStoreError: Error {
    case serverError
    case unknownError
    
    var errorMessage: String {
        switch self {
        case .serverError:
            return "Unable to connect to the server. Please try again later."
        case .unknownError:
            return "An error has occured. Please try again later."
        }
    }
}

protocol PlayStoreRepository {
    func getAlbums(after: String?, limit: Int) -> AnyPublisher<[Album], PlayStoreError>
}

class MPlayStoreRepository: PlayStoreRepository {
    
    var albumsWatcher: GraphQLQueryWatcher<MPlaySchema.AlbumsQuery>?
    var apolloClient: ApolloClient

    init(apolloClient: ApolloClient = Network.shared.apolloClient) {
        self.apolloClient = apolloClient
    }

    func getAlbums(after: String?, limit: Int) -> AnyPublisher<[Album], PlayStoreError> {
        let subject = PassthroughSubject<[Album], PlayStoreError>()

        albumsWatcher = apolloClient.watch(query: MPlaySchema.AlbumsQuery(after: after ?? "0", limit: limit)) { result in
            switch result {
            case .success(let graphQLResult):
                //print(graphQLResult.data?.albums?.count)
                graphQLResult.data?.albums?.forEach({ album in
                    //print(album?.title)
                })
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
                print(error)
                subject.send(completion: .failure(PlayStoreError.unknownError))
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
