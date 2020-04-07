//
//  PhotoObject.swift
//  Passions
//
//  Created by Simone Scionti on 04/04/2020.
//  Copyright © 2020 SSCode. All rights reserved.
//

import UIKit
import Foundation

class PhotoObject : ContentObject{
    var photo : UIImage!

    init(photo: UIImage, description : String! = nil) {
        super.init(description: description, collectionCoverImage: photo)
        self.photo = photo
    }
    override public func getContentTypeName() -> String { //virtual method
        return "Foto"
    }
    
    
    
}
