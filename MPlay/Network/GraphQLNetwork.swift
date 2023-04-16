//
//  GraphQLNetwork.swift
//  MPlay
//
//  Created by Samson Lopez on 22/02/2023.
//

import Foundation
import Apollo
import Combine

class GraphQLNetwork: NetworkProtocol {
    
    private(set) lazy var apolloClient: ApolloClient = {
        return ApolloClient.init(url: getNetworkURL())
    }()
    
    func getNetworkURL() -> URL {
        let connectionProtocol = ""//Environment.shared.connectionProtocol
        let graphQLURL = Configuration.shared.networkSettings.graphQLURL
        //return URL(string: "\(connectionProtocol))://\(graphQLURL)")!
        return URL(string: "\(graphQLURL)")!
    }
}

