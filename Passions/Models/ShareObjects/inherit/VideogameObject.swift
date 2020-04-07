//
//  VideogameObject.swift
//  Passions
//
//  Created by Simone Scionti on 04/04/2020.
//  Copyright © 2020 SSCode. All rights reserved.
//

import Foundation
import UIKit

class VideogameObject : SuggestionObject {
    var image : UIImage!
    var amazonLink : String!
    var youtubeLink : String!
    var twitchLink : String!
    
    init(image: UIImage! = nil, description: String! = nil, amazonLink: String! = nil , youtubeLink: String! = nil, twitchLink: String! = nil) {
        super.init(description: description, collectionCoverImage: image)
        self.image = image
        self.amazonLink = amazonLink
        self.youtubeLink = youtubeLink
        self.twitchLink = twitchLink
    }
    
    override public func getContentTypeName() -> String { //virtual method
        return "Videogame"
    }
    
}
