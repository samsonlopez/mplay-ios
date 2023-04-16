//
//  MPlayApp.swift
//  MPlay
//
//  Created by Samson Lopez on 21/02/2023.
//

import SwiftUI
import Apollo
import Combine

@main
struct MPlayApp: App {
    let persistenceController = PersistenceController.shared
    //var apolloClient = ApolloClient(url: URL(string: "http://localhost:4000/graphql")!)
    var apolloClient = ApolloClient(url: URL(string: Configuration.shared.networkSettings.graphQLURL)!)

    var playstoreAlbums = Set<AnyCancellable>()
    
    init() {
        //fetchData()
    }
    
    var body: some Scene {
        WindowGroup {
            let homeViewModel = HomeViewModel()
            HomeView(homeViewModel: homeViewModel)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
