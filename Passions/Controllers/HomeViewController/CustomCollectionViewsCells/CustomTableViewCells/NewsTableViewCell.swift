//
//  NewsTableViewCell.swift
//  Passions
//
//  Created by Simone Scionti on 04/04/2020.
//  Copyright © 2020 SSCode. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell, SSCVDataSource, SSCVSignalUpdateObserver{
    
    var collectionViewItems = [UIImage]()
    @IBOutlet private weak var horizontalCollectionView: SSCollectionView!
    
    override func awakeFromNib() {
        horizontalCollectionView.setup(cellPeekWidth: 0, cellSpacing: 20, scaleValue: 3.0)
        horizontalCollectionView.dataSource = self
        horizontalCollectionView.signalObserver = self
        self.selectionStyle = .none
        //setProfileImageCornerRadius()
    }

    public func setCellContent(items: [UIImage]){
        collectionViewItems = items
    }
   
    func alphaChanged(alpha: CGFloat) {
          //print("alphaChanged")
      }
      
    func targetIndexChanged(targetIndex: Int, previousTargetIndex : Int) {
         // print("indexChanged")
    }
    func SSCV(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionViewItems.count
    }
    
    func SSCV(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newsCollectionViewCell", for: indexPath) as! NewsCollectionViewCell
        cell.setCellContent(image: collectionViewItems[indexPath.row])
        return cell
    }
}
