//
//  MatchSummaryCollectionViewCell.swift
//  LMS Test Project
//
//  Created by Abdul Motalab Rakib on 21/1/25.
//

import UIKit

class MatchSummaryCollectionViewCell: UICollectionViewCell {
        
    @IBOutlet weak var cityRankContainerView: UIView!
    @IBOutlet weak var nationalRankContainerView: UIView!
    @IBOutlet weak var worldRankContainerView: UIView!
    @IBOutlet weak var formContainerView: UIView!
    @IBOutlet weak var matchesLabel: UILabel!
    @IBOutlet weak var winRatioLabel: UILabel!
    @IBOutlet weak var winsLabel: UILabel!
    @IBOutlet weak var losesLabel: UILabel!
    @IBOutlet weak var cityRankLabel: UILabel!
    @IBOutlet weak var worldRankLabel: UILabel!
    @IBOutlet weak var nationalRankLabel: UILabel!
    @IBOutlet weak var formLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
    }
    
    private func setUpUI() {
        cityRankContainerView.layer.cornerRadius = 5
        worldRankContainerView.layer.cornerRadius = 5
        nationalRankContainerView.layer.cornerRadius = 5
        formContainerView.layer.cornerRadius = 5
    }
    
    var teamStatsData: TeamStats? {
        didSet {
            guard let teamStatsData = teamStatsData else { return }
            matchesLabel.text = "\(teamStatsData.gamesPlayed)"
            winRatioLabel.text = "\(teamStatsData.winRatio)%"
            winsLabel.text = "\(teamStatsData.wins)"
            losesLabel.text = "\(teamStatsData.loses)"
        }
    }
    var teamRankingData: TeamRanking? {
        didSet {
            guard let teamRankingData = teamRankingData else { return }
            cityRankLabel.text = "\(teamRankingData.regionalRank)"
            nationalRankLabel.text = "\(teamRankingData.countryRank)"
            worldRankLabel.text = "\(teamRankingData.worldRank)"
            formLabel.text = "\(teamRankingData.form)"
        }
    }
}
extension MatchSummaryCollectionViewCell {
    static func dequeue(from collectionView: UICollectionView, at indexPath: IndexPath) -> MatchSummaryCollectionViewCell {
        return collectionView.dequeueReusableCell(forIndexPath: indexPath)
    }
}
