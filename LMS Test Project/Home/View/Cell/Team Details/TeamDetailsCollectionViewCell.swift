//
//  TeamDetailsCollectionViewCell.swift
//  LMS Test Project
//
//  Created by Abdul Motalab Rakib on 21/1/25.
//

import UIKit

class TeamDetailsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var teamLogoImage: UIImageView!
    @IBOutlet weak var sponsorLogoImage: UIImageView!
    @IBOutlet weak var teamNameLabel: UILabel!
    
    let tabCategoryItem = ["Summary", "Batting", "Bowling", "All Rounder","Keeping", "Squad"]
    var selectedIndex = 0
    
    @IBOutlet weak var typeCollectionView: UICollectionView! {
        didSet {
            typeCollectionView.collectionViewLayout = UICollectionViewCompositionalLayout(section: tabSection())
            typeCollectionView.delegate = self
            typeCollectionView.dataSource = self
            typeCollectionView.registerNibCell(TabCollectionViewCell.self)
            typeCollectionView.clipsToBounds = true
            typeCollectionView.backgroundColor = .white
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        teamLogoImage.layer.cornerRadius = 5
    }
    
    var teamInfo: TeamInfo? {
        didSet {
            guard let teamInfo = teamInfo else { return }
            
            self.teamLogoImage.setSDImage(URL: teamInfo.teamLogo)
            self.sponsorLogoImage.setSDImage(URL: teamInfo.sponsorLogo)
            self.teamNameLabel.text = teamInfo.teamName
        }
    }

    func tabSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 8)

        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(90.0), heightDimension: .estimated(40.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets.leading = 12.0
        section.contentInsets.trailing = 12.0
        section.orthogonalScrollingBehavior = .continuous
        
        return section
    }
}
extension TeamDetailsCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabCategoryItem.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as TabCollectionViewCell
        cell.titleLabel.text = tabCategoryItem[indexPath.row]

        if selectedIndex == indexPath.row {
            cell.containerView.backgroundColor = UIColor(hex: "#0C3539")
        } else {
            cell.containerView.backgroundColor = UIColor(hex: "#008977")
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
    }
}

extension TeamDetailsCollectionViewCell {
    static func dequeue(from collectionView: UICollectionView, at indexPath: IndexPath) -> TeamDetailsCollectionViewCell {
        return collectionView.dequeueReusableCell(forIndexPath: indexPath)
    }
}

