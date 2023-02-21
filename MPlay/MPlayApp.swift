//
//  MPlayApp.swift
//  MPlay
//
//  Created by Samson Lopez on 21/02/2023.
//

import SwiftUI

@main
struct MPlayApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
