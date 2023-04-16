//
//  HomeView.swift
//  MPlay
//
//  Created by Samson Lopez on 22/02/2023.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var homeViewModel = HomeViewModel()
    
    init(homeViewModel: HomeViewModel) {
        self.homeViewModel = homeViewModel
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    if let albums = homeViewModel.albums {
                        ForEach(albums) { album in
                            Text(album.title)
                                .onAppear {
                                    if album.id == homeViewModel.lastAlbumId && homeViewModel.hasMoreAlbums {
                                        homeViewModel.isLoading = true
                                        homeViewModel.fetchData()
                                    }
                                }
                        }
                    }
                }.navigationTitle("Albums")
                if homeViewModel.isLoading {
                    Text("Loading...")
                }
            }
        }
        .onAppear {
            homeViewModel.fetchData()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(homeViewModel: HomeViewModel())
    }
}
