//
//  LandingView.swift
//  
//
//  Created by Samson Lopez on 16/04/2023.
//

import SwiftUI
import Home

private enum navigationOptions {
    case login
    case signUp
}

public struct LandingView: View {
    
    @State private var showLogin = false
    @State private var showSignUp = false
    
    @StateObject private var homeViewModel = HomeViewModel(repository: MPlayStoreRepository())
    
    public init() {} // Needed in module with public access modifier.
    
    public var body: some View {
        NavigationStack() {
            VStack {
                HStack {
                    Spacer()
                    NavigationLink(value: navigationOptions.login) {
                        Text("Home")
                    }
                    Spacer()
                    NavigationLink(value: navigationOptions.signUp) {
                        Text("SignUp")
                    }
                    Spacer()
                }
                .navigationDestination(for: navigationOptions.self) { value in
                    switch value {
                    case .login:
                        HomeView()
                            .environmentObject(homeViewModel)
                    case .signUp:
                        Text("Sign up screen!")
                    }
                }
            }
        }
    }
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
    }
}
