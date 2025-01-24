//
//  HomeViewModel.swift
//  LMS Test Project
//
//  Created by Abdul Motalab Rakib on 21/1/25.
//

import Foundation

extension HomeViewModel {
    class Callback {
        var complete: () -> Void = { }
    }
}
class HomeViewModel {
    let callback = Callback()
    var sections: [HomeSections] = [.teamInfo,.matchSummary, .topPlayer, .squardList, .recentVideos, .honoursAndAwards, .recentResults, .upcommingFixtures]
    
    private let homeAPIClient: HomeAPIClient = .init()
    
    var teamInfoData: TeamInfo?
    var teamStatsData: TeamStats?
    var teamRankingsData: TeamRanking?
    var playerList = [[Player]]()
    var championshipData: Championship?
    var matchesHistory = [MatchHistoryAndUpcomingMatch]()
    var upcomingMatches = [MatchHistoryAndUpcomingMatch]()
    var recentVideos = [MatchVideo]()
    var squadList = [PlayerDetailsInfo]()
    
    var errorMessage = ""
    
    
    func requestForApiData() {
        getWorldTeamProfileSummery()
        getSquadList()
    }
    
    private func getWorldTeamProfileSummery() {
//        isLoading = true
        self.homeAPIClient.getWorldTeamProfileSummery { [weak self] response in
            switch response.result {
            case .success(let data):
                if let data = data {
                    do {
//                        self?.isLoading = false
                        
                        guard let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as? [[Any]] else {
                            debugPrint("Invalid JSON format")
                            return
                        }
                        
                        // Parse each section of the response
                        if let teamDetails = jsonArray[0].first as? [String: Any] {
                            let team = TeamInfo(
                                teamName: teamDetails["TeamName"] as? String ?? "",
                                teamLogo: teamDetails["TeamLogo"] as? String ?? "",
                                sponsorLogo: teamDetails["SponsorLogo"] as? String ?? "",
                                teamDescription: teamDetails["TeamDescription"] as? String ?? ""
                            )
                            self?.teamInfoData = team
                            debugPrint("Parsed Team: \(team)")
                        }
                        // for team details
                        if let statsDetails = jsonArray[1].first as? [String: Any] {
                            let stats = TeamStats(
                                gamesPlayed: statsDetails["gamesPlayed"] as? Int ?? 0,
                                winRatio: statsDetails["WinRatio"] as? Double ?? 0.0,
                                wins: statsDetails["Wins"] as? Int ?? 0,
                                loses: statsDetails["Loses"] as? Int ?? 0
                            )
                            self?.teamStatsData = stats
                            debugPrint("Parsed Stats: \(stats)")
                        }
                        // for ranking
                        if let rankingsDetails = jsonArray[2].first as? [String: Any] {
                            let rankings = TeamRanking(
                                worldRank: rankingsDetails["WorldRank"] as? Int ?? 0,
                                countryRank: rankingsDetails["CountryRank"] as? Int ?? 0,
                                regionalRank: rankingsDetails["RegionalRank"] as? Int ?? 0,
                                form: rankingsDetails["Form"] as? String ?? ""
                            )
                            self?.teamRankingsData = rankings
                            debugPrint("Parsed Rankings: \(rankings)")
                        }
                        // for Top players
                        for i in 3...5 {
                            if let playersArray = jsonArray[i] as? [[String: Any]] {
                                let players = playersArray.compactMap { dict -> Player? in
                                    guard let userId = dict["UserId"] as? Int else { return nil }
                                    return Player(
                                        userId: userId,
                                        userName: "\(dict["FirstName"] as? String ?? "") \(dict["LastName"] as? String ?? "")",
                                        nationality: dict["Nationality"] as? Int ?? 0,
                                        userPicture: dict["UserPicture"] as? String ?? "",
                                        worldRank: dict["WorldRank"] as? Int ?? 0,
                                        nationalRank: dict["NationalRank"] as? Int ?? 0
                                    )
                                }
                                self?.playerList.append(players)
                                debugPrint("Parsed Players: \(players)")
                            }
                        }
                        // for honours
                        if let championshipDetails = jsonArray[6].first as? [String: Any] {
                            let championship = Championship(
                                champion: championshipDetails["Champion"] as? Int ?? 0,
                                runnersUp: championshipDetails["RunnersUp"] as? Int ?? 0
                            )
                            self?.championshipData = championship
                            debugPrint("Parsed championship: \(championship)")
                        }
                        
                        // for recent Results
                        if let matchHistoryArray = jsonArray[7] as? [[String: Any]] {
                            let matchHistory = matchHistoryArray.compactMap { dict -> MatchHistoryAndUpcomingMatch? in
                                guard let teamId = dict["TeamId"] as? Int else { return nil }
                                return MatchHistoryAndUpcomingMatch(
                                    teamId: teamId,
                                    teamName: dict["TeamName"] as? String ?? "",
                                    teamLogo: dict["TeamLogo"] as? String ?? "",
                                    oppoTeamId: dict["oppoTeamId"] as? Int ?? 0,
                                    oppTeamName: dict["oppTeamName"] as? String ?? "",
                                    oppLogo: dict["oppLogo"] as? String ?? "",
                                    matchInfo: dict["MatchInfo"] as? String ?? "",
                                    dateTime: dict["DateTime"] as? String ?? ""
                                )
                            }
                            self?.matchesHistory = matchHistory
                            debugPrint("matchHistory: \(String(describing: self?.matchesHistory.count))")
                        }
                        // for Upcoming fixtures
                        if let upcomingMatchArray = jsonArray[8] as? [[String: Any]] {
                            let upcomingMatch = upcomingMatchArray.compactMap { dict -> MatchHistoryAndUpcomingMatch? in
                                guard let teamId = dict["TeamId"] as? Int else { return nil }
                                return MatchHistoryAndUpcomingMatch(
                                    teamId: teamId,
                                    teamName: dict["TeamName"] as? String ?? "",
                                    teamLogo: dict["TeamLogo"] as? String ?? "",
                                    oppoTeamId: dict["oppoTeamId"] as? Int ?? 0,
                                    oppTeamName: dict["oppTeamName"] as? String ?? "",
                                    oppLogo: dict["oppLogo"] as? String ?? "", 
                                    matchInfo: nil,
                                    dateTime: dict["DateTime"] as? String ?? ""
                                )
                            }
                            self?.upcomingMatches = upcomingMatch
                            debugPrint("upcomingMatch: \(String(describing: self?.upcomingMatches.count))")
                        }
                        // for recent videos
                        if let recentVideoArray = jsonArray[9] as? [[String: Any]] {
                            let recentVideo = recentVideoArray.compactMap { dict -> MatchVideo? in
                                guard let teamId = dict["TeamId"] as? Int else { return nil }
                                return MatchVideo(
                                    teamFixture: dict["TeamFixture"] as? Int ?? 0,
                                    date: dict["Date"] as? String ?? "",
                                    playbackUrl: dict["PlaybackUrl"] as? String ?? "",
                                    youtube: dict["YouTube"] as? String ?? "",
                                    fixDate: dict["FixDate"] as? String ?? "",
                                    teamId: teamId
                                )
                            }
                            self?.recentVideos = recentVideo
                            debugPrint("upcomingMatch: \(String(describing: self?.recentVideos.count))")
                        }
                        // notify for complete task
                        self?.callback.complete()
                    } catch {
                        debugPrint("Error parsing JSON: \(error)")
                    }
                    
                } else {
                    self?.errorMessage = "No Data Found"
                }
            case .failure(let error):
                self?.errorMessage = error.localizedDescription
            }
        }
    }
    
    private func getSquadList() {
//        isLoading = true
        self.homeAPIClient.getSquadList { [weak self] response in
            switch response.result {
            case .success(let data):
                if let data = data {
                    do {
//                        self?.isLoading = false
                        let playerArray = try JSONDecoder().decode([PlayerDetailsInfo].self, from: data)
                        self?.squadList = playerArray
                        debugPrint("squadList - \(self?.squadList.count)")
                        // notify for complete task
                        self?.callback.complete()
                    } catch {
                        debugPrint("Error parsing JSON: \(error)")
                    }
                } else {
                    self?.errorMessage = "No Data Found"
                }
            case .failure(let error):
                self?.errorMessage = error.localizedDescription
            }
        }
    }
    
    func createThumbnailUrl(_ fromString: String) -> String {
        let playbackUrl = fromString
        // Extract the video ID using a regex
        if let range = playbackUrl.range(of: "embed/([a-zA-Z0-9_-]+)", options: .regularExpression) {
            let videoId = String(playbackUrl[range].split(separator: "/").last ?? "")
            
            // Construct the thumbnail URL
            let thumbnailUrl = "https://img.youtube.com/vi/\(videoId)/maxresdefault.jpg"
            debugPrint("Thumbnail URL: \(thumbnailUrl)")
            return thumbnailUrl
        }
        return ""
    }
    
    func getTitleFromString(_ iframeString: String) -> String {
        // Define a regex pattern to capture the title value
        let pattern = "title=\"([^\"]+)\""

        do {
            let regex = try NSRegularExpression(pattern: pattern)
            if let match = regex.firstMatch(in: iframeString, range: NSRange(iframeString.startIndex..., in: iframeString)) {
                if let range = Range(match.range(at: 1), in: iframeString) {
                    let title = String(iframeString[range])
                    debugPrint("Extracted Title: \(title)")
                    return title
                }
            }
        } catch {
            debugPrint("Invalid regex: \(error.localizedDescription)")
        }
        return ""
    }
}

