//
//  Network.swift
//  MPlay
//
//  Created by Samson Lopez on 22/02/2023.
//

import Foundation
import Apollo
import Combine

protocol NetworkProtocol {
    var apolloClient: ApolloClient { get }
}

class Network {
    static let shared:NetworkProtocol = GraphQLNetwork()
}

