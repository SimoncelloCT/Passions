//
//  CollectionViewTableViewCell.swift
//  Passions
//
//  Created by Simone Scionti on 04/04/2020.
//  Copyright © 2020 SSCode. All rights reserved.
//

import UIKit

class CollectionTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    //collectionCollectionView
    //focusedCollectionName
    //focusedCollectionOwnerProfile
    var collectionViewItems = [Collection]()
    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    public func setCellContent(items: [Collection]){
          collectionViewItems = items
      }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return collectionViewItems.count
       }
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           //collectionCollectionViewCell -> id
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCollectionViewCell", for: indexPath) as! CollectionCollectionViewCell
             //  cell.backgroundColor = collectionItems[indexPath.row]
        return cell
       }

}
