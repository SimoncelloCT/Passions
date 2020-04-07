//
//  Collection.swift
//  Passions
//
//  Created by Simone Scionti on 04/04/2020.
//  Copyright © 2020 SSCode. All rights reserved.
//

import Foundation
import UIKit
class Collection{
    var items : [ShareObject]!
    var leftUpImage : UIImage!
    var rightImage: UIImage!
    var leftBottomImage : UIImage!
    var collectionName: String!
    var collectionOwner : Profile!
    var passion : Passion!
    
    init(items : [ShareObject],collectionName: String, collectionOwner : Profile, passion: Passion) {
        self.items = items
        self.collectionName = collectionName
        self.collectionOwner = collectionOwner
        self.passion = passion
        setFrontImages()
    }
    private func setFrontImages(){
        switch items.count {
        case 0:
            leftUpImage = nil
            leftBottomImage = nil
            rightImage = nil
        case 1:
            leftUpImage = items[0].collectionCoverImage
            leftBottomImage = nil
            rightImage = nil
        case 2:
            leftUpImage = items[0].collectionCoverImage
            leftBottomImage = items[1].collectionCoverImage
            rightImage = nil
        default:
            leftUpImage = items[0].collectionCoverImage
            leftBottomImage = items[1].collectionCoverImage
            rightImage = items[2].collectionCoverImage
        }
    }
    
    
}
