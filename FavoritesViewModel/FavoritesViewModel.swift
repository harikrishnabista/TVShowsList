//
//  FavoritesViewModel.swift
//  CoffeeBagel
//
//  Created by Hari Bista on 10/30/21.
//  Copyright © 2021 Hari Bista. All rights reserved.
//

import Foundation

class FavoritesViewModel {
    var favoriteEpisodes: [Episode] = []
    
    func updateFavoriteEpisodes(){
        self.favoriteEpisodes = FavoriteEpisodeList.shared.episodes
    }
}
