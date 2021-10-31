//
//  EpisodeDetailsViewModel.swift
//  CoffeeBagel
//
//  Created by Hari Bista on 10/31/21.
//  Copyright © 2021 Hari Bista. All rights reserved.
//

import Foundation

class EpisodeDetailsViewModel {
    var episode: Episode?
    
    var isFavorite: Bool {
        guard let episode = episode else { return false }
        return FavoriteEpisodeList.shared.checkIfIsFavorite(episode: episode)
    }
    
    var seasonEpisodeDisplayValue: String {
        guard let episode = episode else { return "" }
        return " Season \(episode.season) - Episode \(episode.number)"
    }
}
