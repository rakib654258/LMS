//
//  SummaryModel.swift
//  LMS Test Project
//
//  Created by Abdul Motalab Rakib on 21/1/25.
//

import Foundation

import Foundation

struct TeamInfo: Codable {
    let teamName: String
    let teamLogo: String
    let sponsorLogo: String
    let teamDescription: String
}

struct TeamStats: Codable {
    let gamesPlayed: Int
    let winRatio: Double
    let wins: Int
    let loses: Int
}

struct TeamRanking: Codable {
    let worldRank: Int
    let countryRank: Int
    let regionalRank: Int
    let form: String
}

struct Player: Codable {
    let userId: Int
    let userName: String
    let nationality: Int
    let userPicture: String
    let worldRank: Int
    let nationalRank: Int
}

struct Championship: Codable {
    let champion: Int
    let runnersUp: Int
}

struct MatchHistoryAndUpcomingMatch: Codable {
    let teamId: Int
    let teamName: String
    let teamLogo: String
    let oppoTeamId: Int
    let oppTeamName: String
    let oppLogo: String
    let matchInfo: String?
    let dateTime: String
}

//struct UpcomingMatch: Codable {
//    let teamId: Int
//    let teamName: String
//    let teamLogo: String
//    let oppoTeamId: Int
//    let oppTeamName: String
//    let oppLogo: String
//    let dateTime: String
//}

struct MatchVideo: Codable {
    let teamFixture: Int
    let date: String
    let playbackUrl: String
    let youtube: String
    let fixDate: String
    let teamId: Int
}

typealias ApiResponse = (
    teamInfo: [TeamInfo],
    teamStats: [TeamStats],
    teamRanking: [TeamRanking],
    players: [Player],
    keyPlayers: [Player],
    topPerformers: [Player],
    championships: [Championship],
    matchHistory: [MatchHistoryAndUpcomingMatch],
    upcomingMatches: [MatchHistoryAndUpcomingMatch],
    matchVideos: [MatchVideo]
)

// Decoding Example
func parseApiResponse(from jsonData: Data) throws -> ApiResponse {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    
    let arrays = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [[Any]]
    
    guard let arrays = arrays, arrays.count >= 10 else {
        throw DecodingError.dataCorrupted(.init(codingPath: [], debugDescription: "Invalid data structure"))
    }
    
    let teamInfo = try JSONDecoder().decode([TeamInfo].self, from: JSONSerialization.data(withJSONObject: arrays[0]))
    let teamStats = try JSONDecoder().decode([TeamStats].self, from: JSONSerialization.data(withJSONObject: arrays[1]))
    let teamRanking = try JSONDecoder().decode([TeamRanking].self, from: JSONSerialization.data(withJSONObject: arrays[2]))
    let players = try JSONDecoder().decode([Player].self, from: JSONSerialization.data(withJSONObject: arrays[3]))
    let keyPlayers = try JSONDecoder().decode([Player].self, from: JSONSerialization.data(withJSONObject: arrays[4]))
    let topPerformers = try JSONDecoder().decode([Player].self, from: JSONSerialization.data(withJSONObject: arrays[5]))
    let championships = try JSONDecoder().decode([Championship].self, from: JSONSerialization.data(withJSONObject: arrays[6]))
    let matchHistory = try JSONDecoder().decode([MatchHistoryAndUpcomingMatch].self, from: JSONSerialization.data(withJSONObject: arrays[7]))
    let upcomingMatches = try JSONDecoder().decode([MatchHistoryAndUpcomingMatch].self, from: JSONSerialization.data(withJSONObject: arrays[8]))
    let matchVideos = try JSONDecoder().decode([MatchVideo].self, from: JSONSerialization.data(withJSONObject: arrays[9]))
    
    return (
        teamInfo: teamInfo,
        teamStats: teamStats,
        teamRanking: teamRanking,
        players: players,
        keyPlayers: keyPlayers,
        topPerformers: topPerformers,
        championships: championships,
        matchHistory: matchHistory,
        upcomingMatches: upcomingMatches,
        matchVideos: matchVideos
    )
}

