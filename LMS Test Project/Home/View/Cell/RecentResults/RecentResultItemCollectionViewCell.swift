//
//  RecentResultItemCollectionViewCell.swift
//  LMS Test Project
//
//  Created by Abdul Motalab Rakib on 23/1/25.
//

import UIKit

class RecentResultItemCollectionViewCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
extension RecentResultItemCollectionViewCell {
    static func dequeue(from collectionView: UICollectionView, at indexPath: IndexPath) -> RecentResultItemCollectionViewCell {
        return collectionView.dequeueReusableCell(forIndexPath: indexPath)
    }
}
