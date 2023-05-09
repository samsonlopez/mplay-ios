//
//  Network.swift
//  MPlay
//
//  Created by Samson Lopez on 22/02/2023.
//

import Foundation
import Apollo
import Combine

public protocol NetworkProtocol {
    var apolloClient: ApolloClient { get }
}

public class Network {
    public static let shared:NetworkProtocol = GraphQLNetwork()
}

