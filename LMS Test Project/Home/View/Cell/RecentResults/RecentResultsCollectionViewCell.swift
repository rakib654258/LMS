//
//  RecentResultsCollectionViewCell.swift
//  LMS Test Project
//
//  Created by Abdul Motalab Rakib on 23/1/25.
//

import UIKit

class RecentResultsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var viewAllContainerView: UIView!
    @IBOutlet weak var mainContainerView: UIView!
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var headerTitleLabel: UILabel!
    @IBOutlet weak var containerView5: UIView!
    
    @IBOutlet weak var dateLabel1: UILabel!
    @IBOutlet weak var teamLogo: UIImageView!
    @IBOutlet weak var teamNameLabel1: UILabel!
    @IBOutlet weak var opponentLogo: UIImageView!
    @IBOutlet weak var oppoTeamNameLabel1: UILabel!
    @IBOutlet weak var matchInfoLabel1: UILabel!
    
    @IBOutlet weak var dateLabel2: UILabel!
    @IBOutlet weak var teamLogo2: UIImageView!
    @IBOutlet weak var teamNameLabel2: UILabel!
    @IBOutlet weak var opponentLogo2: UIImageView!
    @IBOutlet weak var oppoTeamNameLabel2: UILabel!
    @IBOutlet weak var matchInfoLabel2: UILabel!
    
    @IBOutlet weak var dateLabel3: UILabel!
    @IBOutlet weak var teamLogo3: UIImageView!
    @IBOutlet weak var teamNameLabel3: UILabel!
    @IBOutlet weak var opponentLogo3: UIImageView!
    @IBOutlet weak var oppoTeamNameLabel3: UILabel!
    @IBOutlet weak var matchInfoLabel3: UILabel!
    
    @IBOutlet weak var dateLabel4: UILabel!
    @IBOutlet weak var teamLogo4: UIImageView!
    @IBOutlet weak var teamNameLabel4: UILabel!
    @IBOutlet weak var opponentLogo4: UIImageView!
    @IBOutlet weak var oppoTeamNameLabel4: UILabel!
    @IBOutlet weak var matchInfoLabel4: UILabel!
    
    @IBOutlet weak var dateLabel5: UILabel!
    @IBOutlet weak var teamLogo5: UIImageView!
    @IBOutlet weak var teamNameLabel5: UILabel!
    @IBOutlet weak var opponentLogo5: UIImageView!
    @IBOutlet weak var oppoTeamNameLabel5: UILabel!
    @IBOutlet weak var matchInfoLabel5: UILabel!
    
    @IBOutlet weak var containerView5HeightConstant: NSLayoutConstraint!
    @IBOutlet weak var winTagImg1: UIImageView!
    @IBOutlet weak var winTagImg2: UIImageView!
    @IBOutlet weak var winTagImg3: UIImageView!
    @IBOutlet weak var winTagImg4: UIImageView!
    @IBOutlet weak var winTagImg5: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateUI()
    }
    private func updateUI() {
        viewAllContainerView.layer.cornerRadius = 5
        mainContainerView.layer.borderWidth = 2
        mainContainerView.layer.borderColor = UIColor(hex: "#A6D1C4").cgColor
                
        viewAllContainerView.layer.cornerRadius = 5
        viewAllContainerView.layer.borderWidth = 2
        viewAllContainerView.layer.borderColor = UIColor(hex: "#A6D1C4").cgColor
    }
    
    var recentresultsData: [MatchHistoryAndUpcomingMatch]? {
        didSet {
            dateLabel1.text = formattedToDayString(recentresultsData?[0].dateTime ?? "")
            teamLogo.setSDImage(URL: recentresultsData?[0].teamLogo ?? "")
            addBorder(teamLogo)
            teamNameLabel1.text = recentresultsData?[0].teamName ?? ""
            
            opponentLogo.setSDImage(URL: recentresultsData?[0].oppLogo ?? "")
            addBorder(opponentLogo)
            oppoTeamNameLabel1.text = recentresultsData?[0].oppTeamName ?? ""
            matchInfoLabel1.text = recentresultsData?[0].matchInfo ?? "View match info"
            
            dateLabel2.text = formattedToDayString(recentresultsData?[1].dateTime ?? "")
            teamLogo2.setSDImage(URL: recentresultsData?[1].teamLogo ?? "")
            addBorder(teamLogo2)
            teamNameLabel2.text = recentresultsData?[1].teamName ?? ""
            opponentLogo2.setSDImage(URL: recentresultsData?[1].oppLogo ?? "")
            addBorder(opponentLogo2)
            oppoTeamNameLabel2.text = recentresultsData?[1].oppTeamName ?? ""
            matchInfoLabel2.text = recentresultsData?[1].matchInfo ?? "View match info"
            
            dateLabel3.text = formattedToDayString(recentresultsData?[2].dateTime ?? "")
            teamLogo3.setSDImage(URL: recentresultsData?[2].teamLogo ?? "")
            addBorder(teamLogo3)
            teamNameLabel3.text = recentresultsData?[2].teamName ?? ""
            opponentLogo3.setSDImage(URL: recentresultsData?[2].oppLogo ?? "")
            addBorder(opponentLogo3)
            oppoTeamNameLabel3.text = recentresultsData?[2].oppTeamName ?? ""
            matchInfoLabel3.text = recentresultsData?[2].matchInfo ?? "View match info"
            
            dateLabel4.text = formattedToDayString(recentresultsData?[3].dateTime ?? "")
            teamLogo4.setSDImage(URL: recentresultsData?[3].teamLogo ?? "")
            addBorder(teamLogo4)
            teamNameLabel4.text = recentresultsData?[3].teamName ?? ""
            opponentLogo4.setSDImage(URL: recentresultsData?[3].oppLogo ?? "")
            addBorder(opponentLogo4)
            oppoTeamNameLabel4.text = recentresultsData?[3].oppTeamName ?? ""
            matchInfoLabel4.text = recentresultsData?[3].matchInfo ?? "View match info"
            
            if recentresultsData?.count == 5 {
                dateLabel5.text = formattedToDayString(recentresultsData?[4].dateTime ?? "")
                teamLogo5.setSDImage(URL: recentresultsData?[4].teamLogo ?? "")
                addBorder(teamLogo5)
                teamNameLabel5.text = recentresultsData?[4].teamName ?? ""
                opponentLogo5.setSDImage(URL: recentresultsData?[4].oppLogo ?? "")
                addBorder(opponentLogo5)
                oppoTeamNameLabel5.text = recentresultsData?[4].oppTeamName ?? ""
                matchInfoLabel5.text = recentresultsData?[4].matchInfo ?? "View match info"
            } else {
                containerView5HeightConstant.constant = 0
                containerView5.isHidden = true
            }
        }
    }
    
    var isForUpcomingFixture: Bool = false {
        didSet {
            if isForUpcomingFixture {
                winTagImg1.image = UIImage(named: "")
                winTagImg2.image = UIImage(named: "")
                winTagImg3.image = UIImage(named: "")
                winTagImg4.image = UIImage(named: "")
                winTagImg5.image = UIImage(named: "")
            }
        }
    }
    
    func addBorder(_ image: UIImageView) {
        image.layer.cornerRadius = image.frame.height / 2
        image.layer.borderColor = UIColor(hex: "#008977").cgColor
        image.layer.borderWidth = 2
    }
    
}

extension RecentResultsCollectionViewCell {
    static func dequeue(from collectionView: UICollectionView, at indexPath: IndexPath) -> RecentResultsCollectionViewCell {
        return collectionView.dequeueReusableCell(forIndexPath: indexPath)
    }
}
