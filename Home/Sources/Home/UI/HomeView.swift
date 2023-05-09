//
//  HomeView.swift
//  MPlay
//
//  Created by Samson Lopez on 22/02/2023.
//

import SwiftUI

public struct HomeView: View {
    @EnvironmentObject var homeViewModel: HomeViewModel
    
    public init() {} // Needed in module with public access modifier.

    public var body: some View {
        VStack {
            List {
                if let albums = homeViewModel.albums {
                    ForEach(albums) { album in
                        Text(album.title)
                        .onAppear {
                            if album.id == homeViewModel.lastAlbumId && homeViewModel.hasMoreAlbums {
                                homeViewModel.isLoading = true
                                homeViewModel.fetchAlbums()
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("Albums", displayMode:.large)
            
            if homeViewModel.isLoading {
                Text("Loading...")
            }
        }
        .task {
            homeViewModel.fetchAlbums()
        }
        .alert(isPresented: $homeViewModel.showAlert) {
            Alert(title: Text("Error"), message: Text(homeViewModel.errorMessage), dismissButton: .cancel())
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(HomeViewModel(repository: MPlayStoreRepository()))
    }
}
