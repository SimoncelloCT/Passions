//
//  CollectionViewTableViewCell.swift
//  Passions
//
//  Created by Simone Scionti on 04/04/2020.
//  Copyright © 2020 SSCode. All rights reserved.
//

import UIKit

class CollectionTableViewCell: UITableViewCell, SSCVDataSource, SSCVSignalUpdateObserver {
    
    var collectionViewItems : [Collection]!
    
    @IBOutlet weak var horizontalCollectionView : SSCollectionView!
    @IBOutlet weak var collectionNameLabel: UILabel!
    @IBOutlet weak var ownerProfileNameLabel: UILabel!
    @IBOutlet weak var ownerProfileImage: UIImageView!
    
     override func awakeFromNib() {
        horizontalCollectionView.setup(cellPeekWidth: 90, cellSpacing: 15, scaleValue: 2.0)
        horizontalCollectionView.dataSource = self
        horizontalCollectionView.signalObserver = self
        self.selectionStyle = .none
        setProfileImageCornerRadius()
        
     }
     
     public func setCellContent(items: [Collection]){
        collectionViewItems = items
        setCellExternData(fromIndex: 0)
     }
    
    private func setCellExternData(fromIndex i : Int){
        self.collectionNameLabel.text = collectionViewItems[i].collectionName
        self.ownerProfileNameLabel.text = collectionViewItems[i].collectionOwner.profileUsername
        self.ownerProfileImage.image = collectionViewItems[i].collectionOwner.profileImage
        self.ownerProfileImage.contentMode = .scaleAspectFill
    }
     func alphaChanged(alpha: CGFloat) {
          //print("alphaChanged")
        //setCellDataAlpha(alpha: alpha)
        
     }
     func targetIndexChanged(targetIndex: Int, previousTargetIndex: Int) {
         setCellExternData(fromIndex: targetIndex)
     }
     func SSCV(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return collectionViewItems.count
     }    
     func SSCV(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCollectionViewCell", for: indexPath) as! CollectionCollectionViewCell
         //cell.backgroundColor = collectionViewItems[indexPath.row]
        //cell.backgroundColor = UIColor.lightGray
         cell.setCollectionData(collection: collectionViewItems[indexPath.row])
         return cell
     }
    private func setProfileImageCornerRadius(){
        ownerProfileImage.clipsToBounds = true
        ownerProfileImage.layer.cornerRadius = ownerProfileImage.frame.size.width/2
    }
    
    private func setCellDataAlpha(alpha: CGFloat){
        collectionNameLabel.alpha = alpha
        ownerProfileImage.alpha = alpha
        ownerProfileNameLabel.alpha = alpha
    }
}
