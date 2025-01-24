//
//  HonoursAndAwardsCollectionViewCell.swift
//  LMS Test Project
//
//  Created by Abdul Motalab Rakib on 23/1/25.
//

import UIKit

class HonoursAndAwardsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var descriptionContainerView: UIView!
    @IBOutlet weak var honourContainerView: UIView!
    @IBOutlet weak var viewAllHonoursContainerView: UIView!
    @IBOutlet weak var championCountLabel: UILabel!
    @IBOutlet weak var runnerUpCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateUI()
    }

    private func updateUI() {
        descriptionContainerView.layer.borderWidth = 2
        descriptionContainerView.layer.borderColor = UIColor(hex: "#A6D1C4").cgColor
        descriptionContainerView.layer.cornerRadius = 5
        
        honourContainerView.layer.borderWidth = 2
        honourContainerView.layer.borderColor = UIColor(hex: "#A6D1C4").cgColor
        honourContainerView.layer.cornerRadius = 5
        
        viewAllHonoursContainerView.layer.borderWidth = 2
        viewAllHonoursContainerView.layer.borderColor = UIColor(hex: "#A6D1C4").cgColor
        viewAllHonoursContainerView.layer.cornerRadius = 5
    }
    
    var championShipData: Championship? {
        didSet {
            guard let championShipData = championShipData else { return }
            championCountLabel.text = "\(championShipData.champion)"
            runnerUpCountLabel.text = "\(championShipData.runnersUp)"
        }
    }
}

extension HonoursAndAwardsCollectionViewCell {
    static func dequeue(from collectionView: UICollectionView, at indexPath: IndexPath) -> HonoursAndAwardsCollectionViewCell {
        return collectionView.dequeueReusableCell(forIndexPath: indexPath)
    }
}
