//
//  TopPlayerCollectionViewCell.swift
//  LMS Test Project
//
//  Created by Abdul Motalab Rakib on 22/1/25.
//

import UIKit

enum TopCategory: String {
    case topBatsman = "Top Batsman"
    case topBowler = "Top Bowler"
    case topAllRounder = "Top All Rounder"
}

class TopPlayerCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var topPlayerTypeLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var countryFlagImage: UIImageView!
    @IBOutlet weak var seeFullListContainerView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nationalRankLabel: UILabel!
    @IBOutlet weak var worldRankLabel: UILabel!
    
    @IBOutlet weak var profileImage2: UIImageView!
    @IBOutlet weak var nameLabel2: UILabel!
    @IBOutlet weak var countryFlag2: UIImageView!
    @IBOutlet weak var rank2Label: UILabel!
    
    @IBOutlet weak var profileImage3: UIImageView!
    @IBOutlet weak var nameLabel3: UILabel!
    @IBOutlet weak var countryFlag3: UIImageView!
    @IBOutlet weak var rank3Label: UILabel!
    
    @IBOutlet weak var profileImage4: UIImageView!
    @IBOutlet weak var nameLabel4: UILabel!
    @IBOutlet weak var countryFlag4: UIImageView!
    @IBOutlet weak var rank4Label: UILabel!
    
    @IBOutlet weak var profileImage5: UIImageView!
    @IBOutlet weak var nameLabel5: UILabel!
    @IBOutlet weak var countryFlag5: UIImageView!
    @IBOutlet weak var rank5Label: UILabel!
    
    @IBOutlet weak var profileImage6: UIImageView!
    @IBOutlet weak var nameLabel6: UILabel!
    @IBOutlet weak var countryFlag6: UIImageView!
    @IBOutlet weak var rank6Label: UILabel!
    
    var topPlayerCategory: TopCategory = .topBatsman
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

    var playerList: [Player]? {
        didSet {
            guard let playerList = playerList else { return }
            containerView.layer.cornerRadius = 5
            containerView.layer.borderWidth = 2
            containerView.layer.borderColor = UIColor(hex: "#A6D1C4").cgColor
            
            profileImage.layer.cornerRadius = profileImage.frame.height / 2
            profileImage.layer.borderWidth = 4
            profileImage.layer.borderColor = UIColor(hex: "#FFFFFF").cgColor
            
            countryFlagImage.layer.cornerRadius = countryFlagImage.frame.height / 2
            
            seeFullListContainerView.layer.cornerRadius = 5
            seeFullListContainerView.layer.borderWidth = 2
            seeFullListContainerView.layer.borderColor = UIColor(hex: "#A6D1C4").cgColor
            
            topPlayerTypeLabel.text = topPlayerCategory.rawValue
            profileImage.setSDImage(URL: playerList[0].userPicture)
            nameLabel.text = playerList[0].userName
            nationalRankLabel.text = "National Rank : \(String(describing: playerList[0].nationalRank))"
            worldRankLabel.text = "World Rank : \(String(describing: playerList[0].worldRank))"
            
            profileImage2.layer.cornerRadius = profileImage2.frame.height / 2
            profileImage2.setSDImage(URL: playerList[1].userPicture)
            nameLabel2.text = playerList[1].userName
            rank2Label.text = "\(String(describing: playerList[1].nationalRank))/\(String(describing: playerList[1].worldRank))"
            
            profileImage3.layer.cornerRadius = profileImage3.frame.height / 2
            profileImage3.setSDImage(URL: playerList[2].userPicture)
            nameLabel3.text = playerList[2].userName
            rank3Label.text = "\(String(describing: playerList[2].nationalRank))/\(String(describing: playerList[2].worldRank))"
            
            profileImage4.layer.cornerRadius = profileImage4.frame.height / 2
            profileImage4.setSDImage(URL: playerList[3].userPicture)
            nameLabel4.text = playerList[3].userName
            rank4Label.text = "\(String(describing: playerList[3].nationalRank))/\(String(describing: playerList[3].worldRank))"
            
            profileImage5.layer.cornerRadius = profileImage5.frame.height / 2
            profileImage5.setSDImage(URL: playerList[4].userPicture)
            nameLabel5.text = playerList[4].userName
            rank5Label.text = "\(String(describing: playerList[4].nationalRank))/\(String(describing: playerList[4].worldRank))"
            
            profileImage6.layer.cornerRadius = profileImage6.frame.height / 2
            profileImage6.setSDImage(URL: playerList[5].userPicture)
            nameLabel6.text = playerList[5].userName
            rank6Label.text = "\(String(describing: playerList[5].nationalRank))/\(String(describing: playerList[5].worldRank))"
        }
    }
    
    func updateUI(playerList: [Player]?) {
        
        
    }
}

extension TopPlayerCollectionViewCell {
    static func dequeue(from collectionView: UICollectionView, at indexPath: IndexPath) -> TopPlayerCollectionViewCell {
        return collectionView.dequeueReusableCell(forIndexPath: indexPath)
    }
}
