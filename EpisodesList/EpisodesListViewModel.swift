//
//  EpisodesListViewModel.swift
//  CoffeeBagel
//
//  Created by Hari Bista on 10/30/21.
//  Copyright © 2021 Hari Bista. All rights reserved.
//

import Foundation

class EpisodesListViewModel {
    
    var show: TvShow?
    let endPoint = "/b/617dfa014a82881d6c67f87b"

    func fetchEpisodes( completion: @escaping (Bool, String?) -> Void) {
        let apiCaller = DefaultApiCaller<TvShow>()
        apiCaller.callApi(endPoint: endPoint) { (result) in
            switch result {
            case .success(let show):
                self.show = show
                completion(true, nil)
            case .failure(let error):
                completion(true, error.localizedDescription)
            }
        }
        
    }
    
    var seasonEpisodeDisplayValue: String {
        guard let show = show else { return "" }
        return "Total Seasons: \(show.embedded.episodes[show.embedded.episodes.count - 1].season) | Total episodes: \(show.embedded.episodes.count)"
    }
}
