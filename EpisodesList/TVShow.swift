//
//  TVShow.swift
//  CoffeeBagel
//
//  Created by Hari Bista on 10/30/21.
//  Copyright © 2021 Hari Bista. All rights reserved.
//

import Foundation

// MARK: - TvShow
struct TvShow: Codable {
    let id: String
    let url: String
    let name, type, language: String
    let genres: [String]
    let status: String
    let runtime: Int
    let premiered: String
    let officialSite: String
    let schedule: Schedule
    let rating: Rating
    let weight: Int
    let network: Network
    let externals: Externals
    let image: Image
    let summary: String
    let updated: Int
    let links: TvShowLinks
    let embedded: Embedded
    
    enum CodingKeys: String, CodingKey {
        case id, url, name, type, language, genres, status, runtime, premiered, officialSite, schedule, rating, weight, network, externals, image, summary, updated
        case links = "_links"
        case embedded = "_embedded"
    }
}

// MARK: - Embedded
struct Embedded: Codable {
    let episodes: [Episode]
}

// MARK: - Episode
struct Episode: Codable {
    let id: String
    let url: String
    let name: String
    let season, number: Int
    let airdate: String?
    let airtime: String
    let airstamp: String
    let runtime: Int?
    let image: Image
    let summary: String
    let links: EpisodeLinks
    
    enum CodingKeys: String, CodingKey {
        case id, url, name, season, number, airdate, airtime, airstamp, runtime, image, summary
        case links = "_links"
    }
}

// MARK: - Image
struct Image: Codable {
    let medium, original: String
}

// MARK: - EpisodeLinks
struct EpisodeLinks: Codable {
    let linksSelf: Previousepisode
    
    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
    }
}

// MARK: - Previousepisode
struct Previousepisode: Codable {
    let href: String
}

// MARK: - Externals
struct Externals: Codable {
    let tvrage, thetvdb: Int
    let imdb: String
}

// MARK: - TvShowLinks
struct TvShowLinks: Codable {
    let linksSelf, previousepisode: Previousepisode
    
    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case previousepisode
    }
}

// MARK: - Network
struct Network: Codable {
    let id, name: String
    let country: Country
}

// MARK: - Country
struct Country: Codable {
    let name, code, timezone: String
}

// MARK: - Rating
struct Rating: Codable {
    let average: Double
}

// MARK: - Schedule
struct Schedule: Codable {
    let time: String
    let days: [String]
}
