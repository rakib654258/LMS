//
//  PlayerDetailsInfo.swift
//  LMS Test Project
//
//  Created by Abdul Motalab Rakib on 24/1/25.
//

import Foundation

struct PlayerDetailsInfo: Codable {
    let userId: Int
    let userName: String?
    let userPicture: String
    let playerInfo: String
    let innings: Int
    let runs: Int
    let battingAverage: Double
    let strikeRate: Double
    let wickets: Int
    let bowlingAverage: Double
    let economy: Double
    let worldRank: Int
    let nationalRank: Int
    let isFormar: Int

    // Coding keys for custom JSON keys
    enum CodingKeys: String, CodingKey {
        case userId = "UserId"
        case userName = "UserName"
        case userPicture = "UserPicture"
        case playerInfo = "PlayerInfo"
        case innings = "Innings"
        case runs = "Runs"
        case battingAverage = "BattingAverage"
        case strikeRate = "StrikeRate"
        case wickets = "Wickets"
        case bowlingAverage = "BowlingAverage"
        case economy = "Economy"
        case worldRank = "WorldRank"
        case nationalRank = "NationalRank"
        case isFormar = "IsFormar"
    }
}
