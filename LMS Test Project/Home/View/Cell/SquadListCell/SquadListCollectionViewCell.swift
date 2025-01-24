//
//  SquadListCollectionViewCell.swift
//  LMS Test Project
//
//  Created by Abdul Motalab Rakib on 22/1/25.
//

import UIKit

class SquadListCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var batingStyleLabel: UILabel!
    @IBOutlet weak var bowlingStyleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateUI()
    }

    private func updateUI() {
        containerView.layer.cornerRadius = 5
    }
    
    var playerData: PlayerDetailsInfo? {
        didSet {
            guard let playerData = playerData else { return }
            self.profileImage.setSDImage(URL: playerData.userPicture)
            nameLabel.text = playerData.userName
            splitInfo(playerData.playerInfo)
        }
    }
    func splitInfo(_ splitInfoString: String) {
        // Split the string by " / "
        let splitInfo = splitInfoString.components(separatedBy: " / ")
        if splitInfo.count == 2 {
            let battingStyle = splitInfo[0]
            let bowlingStyle = splitInfo[1]
            batingStyleLabel.text = battingStyle
            bowlingStyleLabel.text = bowlingStyle
        } else {
            debugPrint("The string does not have the expected format.")
        }
        
    }
}

extension SquadListCollectionViewCell {
    static func dequeue(from collectionView: UICollectionView, at indexPath: IndexPath) -> SquadListCollectionViewCell {
        return collectionView.dequeueReusableCell(forIndexPath: indexPath)
    }
}
