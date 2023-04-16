//
//  Configuration.swift
//  MPlay
//
//  Created by Samson Lopez on 22/02/2023.
//

import Foundation

class Configuration {
    
    static let shared = Configuration()
    
    private static let infoDictonary =  Bundle.main.infoDictionary!
    
    let networkSettings:NetworkSettings
    
    init() {
        networkSettings = Configuration.getNetworkSettings()
    }
    
    static func getNetworkSettings() -> NetworkSettings {
        let networkSettings = NetworkSettings(
            graphQLURL: getInfoForKey(key: EnvironmentKeys.graphQLURL.key)
        )
        return networkSettings
    }
    
    static func getInfoForKey(key: String) -> String {
        //print(key)
        //let infoDictonary2 = Configuration.infoDictonary
        //print(infoDictonary2)
        guard let info = infoDictonary[key] as? String else {
            fatalError("No value for key \(key) in build settings")
        }
        return info
    }
}

public struct NetworkSettings {
    let graphQLURL:String
}

public enum EnvironmentKeys: CaseIterable {
    case graphQLURL
    
    public var key: String {
        switch self {
        case .graphQLURL:
            return "GRAPHQL_URL"
        }
    }
}
