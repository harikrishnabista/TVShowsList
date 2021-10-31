//
//  FavoriteEpisodeList.swift
//  CoffeeBagel
//
//  Created by Hari Bista on 10/31/21.
//  Copyright © 2021 Hari Bista. All rights reserved.
//

import Foundation

class FavoriteEpisodeList {
    static let shared = FavoriteEpisodeList()
    
    private(set) var episodes: [Episode] = []
    
    func add(episode: Episode) {
        
        for episodeItem in episodes {
            if episodeItem.id == episode.id {
                return
            }
        }
        
        episodes.insert(episode, at: 0)
    }
    
    func remove(episode: Episode) {
        for (i,episodeItem) in episodes.enumerated() {
            if episodeItem.id == episode.id {
                episodes.remove(at: i)
                break
            }
        }
    }
    
    func checkIfIsFavorite(episode: Episode) -> Bool {
        for episodeItem in episodes {
            if episodeItem.id == episode.id {
                return true
            }
        }
        return false
    }
    
    
}
