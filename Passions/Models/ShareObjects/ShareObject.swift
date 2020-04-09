//
//  ShareObject.swift
//  Passions
//
//  Created by Simone Scionti on 04/04/2020.
//  Copyright © 2020 SSCode. All rights reserved.
//

import Foundation
import UIKit

class ShareObject {
    var description: String!
    var collectionCoverImage: UIImage!
    var comments = [Comment]()
    init(description: String!, collectionCoverImage: UIImage!, comments : [Comment]! = nil) {
        self.description = description
        self.collectionCoverImage = collectionCoverImage
        if comments != nil{
            self.comments = comments
        }
    }
    public func getContentTypeName() -> String { //virtual method
              return "superClass"
    }
    public func insertComments(comments: [Comment]){
        self.comments = comments
    }
}
