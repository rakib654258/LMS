//
//  SquadListContainerCollectionViewCell.swift
//  LMS Test Project
//
//  Created by Abdul Motalab Rakib on 22/1/25.
//

import UIKit

class SquadListContainerCollectionViewCell: UICollectionViewCell {
        
    @IBOutlet weak var viewAllContainerView: UIView!
    @IBOutlet weak var squadCollectionView: UICollectionView! {
        didSet {
            squadCollectionView.collectionViewLayout = UICollectionViewCompositionalLayout(section: itemSection())
            squadCollectionView.delegate = self
            squadCollectionView.dataSource = self
            squadCollectionView.registerNibCell(SquadListCollectionViewCell.self)
            squadCollectionView.clipsToBounds = true
            squadCollectionView.backgroundColor = .clear
        }
    }
    
    var playerSquadList: [PlayerDetailsInfo]? {
        didSet {
            squadCollectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateUI()
    }

    private func updateUI() {
        viewAllContainerView.layer.cornerRadius = 5
    }
    
    private func itemSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 12)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7), heightDimension: .fractionalHeight(1))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets.leading = 12.0
        section.contentInsets.trailing = 12.0
        section.orthogonalScrollingBehavior = .continuous
        
        return section
    }
}

extension SquadListContainerCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return playerSquadList?.count ?? 0 > 15 ?  15 : playerSquadList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as SquadListCollectionViewCell
        cell.playerData = playerSquadList?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
}

extension SquadListContainerCollectionViewCell {
    static func dequeue(from collectionView: UICollectionView, at indexPath: IndexPath) -> SquadListContainerCollectionViewCell {
        return collectionView.dequeueReusableCell(forIndexPath: indexPath)
    }
}
