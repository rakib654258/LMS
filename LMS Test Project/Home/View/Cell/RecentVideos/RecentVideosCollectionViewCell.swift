//
//  RecentVideosCollectionViewCell.swift
//  LMS Test Project
//
//  Created by Abdul Motalab Rakib on 22/1/25.
//

import UIKit

class RecentVideosCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var recentVideoDetailsContainer1: UIView!
    @IBOutlet weak var recentVideoDetailsContainer2: UIView!
    @IBOutlet weak var recentVideoDetailsContainer3: UIView!
    @IBOutlet weak var viewMoreContainerView: UIView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var lmsTextContainerView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel2: UILabel!
    @IBOutlet weak var titleLabel2: UILabel!
    @IBOutlet weak var dateLabel3: UILabel!
    @IBOutlet weak var titleLabel3: UILabel!

    var viewModel: HomeViewModel? {
        didSet {
            let thumbnailUrl1 = self.viewModel?.createThumbnailUrl(self.viewModel?.recentVideos[0].playbackUrl ?? "")
            image1.setSDImage(URL: thumbnailUrl1)
            dateLabel.text = "(\(formattedDateString(viewModel?.recentVideos[0].fixDate ?? "")) | Highlights"
            titleLabel.text = viewModel?.getTitleFromString(viewModel?.recentVideos[0].playbackUrl ?? "")
            
            
            let thumbnailUrl2 = self.viewModel?.createThumbnailUrl(self.viewModel?.recentVideos[1].playbackUrl ?? "")
            image2.setSDImage(URL: thumbnailUrl2)
            dateLabel2.text = "(\(formattedDateString(viewModel?.recentVideos[1].fixDate ?? "")) | Highlights"
            titleLabel2.text = viewModel?.getTitleFromString(viewModel?.recentVideos[1].playbackUrl ?? "")
            
            
            let thumbnailUrl3 = self.viewModel?.createThumbnailUrl(self.viewModel?.recentVideos[2].playbackUrl ?? "")
            image3.setSDImage(URL: thumbnailUrl3)
            dateLabel3.text = "(\(formattedDateString(viewModel?.recentVideos[2].fixDate ?? "")) | Highlights"
            titleLabel3.text = viewModel?.getTitleFromString(viewModel?.recentVideos[2].playbackUrl ?? "")
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateUI()
    }

    
    
    private func updateUI() {
        lmsTextContainerView.layer.cornerRadius = lmsTextContainerView.frame.height / 2
        
        image1.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        image1.layer.cornerRadius = 5
        recentVideoDetailsContainer1.layer.borderWidth = 2
        recentVideoDetailsContainer1.layer.borderColor = UIColor(hex: "#A6D1C4").cgColor
        recentVideoDetailsContainer1.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        recentVideoDetailsContainer1.layer.cornerRadius = 5
        
        image2.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        image2.layer.cornerRadius = 5
        recentVideoDetailsContainer2.layer.borderWidth = 2
        recentVideoDetailsContainer2.layer.borderColor = UIColor(hex: "#A6D1C4").cgColor
        recentVideoDetailsContainer2.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        recentVideoDetailsContainer2.layer.cornerRadius = 5
        
        image3.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        image3.layer.cornerRadius = 5
        recentVideoDetailsContainer3.layer.borderWidth = 2
        recentVideoDetailsContainer3.layer.borderColor = UIColor(hex: "#A6D1C4").cgColor
        recentVideoDetailsContainer3.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        recentVideoDetailsContainer3.layer.cornerRadius = 5
        
        viewMoreContainerView.layer.cornerRadius = 5
    }
}

extension RecentVideosCollectionViewCell {
    static func dequeue(from collectionView: UICollectionView, at indexPath: IndexPath) -> RecentVideosCollectionViewCell {
        return collectionView.dequeueReusableCell(forIndexPath: indexPath)
    }
}
